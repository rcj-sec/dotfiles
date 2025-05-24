#include "cheetah/core.h"

#include <fmt/core.h>

#include <iostream>
#include <string>

#include "fmt/base.h"

using namespace std;

IShell::IShell(const string& appName) : prompt(appName) {
    fmt::print("\033[30;43m Welcome to the {} interactive shell \033[0m\n", prompt);
}

void IShell::processCommand(const string& line) {}

string IShell::getInput() {
    fmt::print("{} > ", prompt);
    string line;
    getline(cin, line);
    return line;
}

void IShell::start() {
    string line;
    while (true) {
        line = getInput();

        if (line == "exit") {
            break;
        }
    }
}