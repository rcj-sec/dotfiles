from pathlib import Path
import sys

def file_exists(path: Path, msg='Error: file not found > '):
    try:
        if not path.exists():
            raise FileNotFoundError(f'{msg}{path}')
    except FileNotFoundError as e:
        print(e)
        sys.exit(1)