#!/bin/bash

# Build, Run, and Clean CMake projects

set -e

usage() {
    echo -e "\nBuild, run, and clean CMake projects."
    echo -e "\nUsage:"
    echo "    prun clean                 # Clean project"
    echo "    prun b <executable_name>   # Build only"
    echo "    prun r <executable_name>   # Run only"
    echo "    prun <executable_name>     # Build and run"
    echo -e "\nExpected to be run from the project's root dir."
    echo
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

if [ "$1" = "b" ]; then
    if [ -z "$2" ]; then usage; fi
	MODE="build"
	EXECUTABLE_NAME="$2"
elif [ "$1" = "r" ]; then
    if [ -z "$2" ]; then usage; fi
	MODE="run"
	EXECUTABLE_NAME="$2"
elif [ "$1" = "clean" ]; then
	MODE="clean"
else
    MODE="build_run"
    EXECUTABLE_NAME="$1"
fi

PROJECT_DIR=$(pwd)

BUILD_DIR="$PROJECT_DIR/build"
SOURCE_DIR="$PROJECT_DIR/src"
BIN_DIR="$PROJECT_DIR/bin"

CMAKELISTS="$PROJECT_DIR/CMakeLists.txt"

# compile_commands.json is required by clangd
CMP_CMD="$BUILD_DIR/compile_commands.json"
CMP_CMD_SYM="$PROJECT_DIR/compile_commands.json"

if [ "$MODE" = "clean" ]; then
    echo 
    echo "Deleting bin/, build/, and compile_commands.json"
    rm -rf "$BUILD_DIR" "$BIN_DIR" "$CMP_CMD_SYM"
    echo "Done."
    exit 0
fi

EXECUTABLE="$BIN_DIR/$EXECUTABLE_NAME"

if [ "$MODE" != "run" ]; then 
    need_configure=false

    if [ ! -f "$EXECUTABLE" ]; then
        need_configure=true
        echo
        echo "Executable not found"
    elif [ ! -f "$CMP_CMD" ]; then
        need_configure=true
        echo
        echo "build/compile_commands.json not found"
    elif [ ! -f "$CMP_CMD_SYM" ]; then
        need_configure=true
        echo
        echo "Symlink to build/compile_commands.json not found"
    elif [ "$CMAKELISTS" -nt "$EXECUTABLE" ]; then 
        need_configure=true
        echo 
        echo "CMakeLists.txt updated."
    elif [ "$SOURCE_DIR" -nt "$EXECUTABLE" ]; then
        need_configure=true
        echo 
        echo "Source directory updated."
    fi

    mkdir -p "$BUILD_DIR"
    cd "$BUILD_DIR"

    if $need_configure; then
        echo -e "\nRunning CMake configuration...\n"
        cmake -DEXECUTABLE_NAME="$EXECUTABLE_NAME" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
        ln -sf "$CMP_CMD" "$CMP_CMD_SYM"
    else
        echo -e "\nCMake configuration up to date, skipping..."
    fi

    echo -e "\nBuilding...\n"
    cmake --build .
fi

if [ "$MODE" = "run" ] || [ "$MODE" = "build_run" ]; then 
    echo
    if [ ! -x "$EXECUTABLE" ]; then
        echo -e "\nError: executable '$EXECUTABLE' not found or not executbale\n"
        exit 1
    fi

    "$EXECUTABLE"
fi
