import os
import json 

registers = {}
session_file = "registers.json"
registers_count = 20
is_saved = True

def get_input(help="", prompt=">>> "):
    full_prompt = '\n' + prompt
    if help:
        full_prompt = f'\n({help} {prompt})'

    return input(prompt).strip()

def init_registers(count=20):
    global registers, registers_count, is_saved
    is_saved = True
    registers_count = count
    registers = {f"v{i}": None for i in range(1, count + 1)}

def clear_screen():
    os.system('clear')

def print_commands():
    print("\nCommands:")
    print("  set <register> <value>  -> Set value of register. Example: set v11 hello")
    print("  <register_num> <value>  -> Set value of register. Example: 11 hello")
    print("  ls [register]           -> Show one of all registers. Example: ls v11")
    print("  flush [register]        -> Flush one of all registers")
    print("  load [file]             -> Load registers from json file")
    print("  dump [file]             -> Dump registers to json.file")
    print("  clear                   -> Clear the screen")
    print("  exit                    -> Quit the program")

def print_registers():
        for reg, val in sorted(registers.items(), key=lambda x: int(x[0][1:])):
            if len(reg) == 2:
                print(f'{reg}:  {val}')
            else:
                print(f'{reg}: {val}')

def set_register(reg, val):
    global is_saved
    if not reg or not val:
        print("Error: bad syntax.\nExpected: add <register> <value>")
        return

    if reg not in registers:
        print(f'Error: <{reg}> not a register ')
        return

    registers[reg] = val
    is_saved = False

def list_registers(reg):
    if not reg:
        print_registers()
    elif reg in registers:
        print(f'{reg}: {registers[reg]}')
    else:
        print(f'Error: <{reg}> not a register ')

def get_path(path):
    if path:
        if not path.endswith(".json"):
            path += ".json"
    else:
        path = session_file

    return path

def list_json_files():
    json_files = [f for f in os.listdir('.') if f.endswith('.json')]
    
    if not json_files:
        print("No JSON files found in this directory.")

    for file in sorted(json_files):
        print(file.strip(".json"))

def dump_to_file(path: str):
    global session_file, is_saved

    if path == "help":
        return list_json_files()

    path = get_path(path)

    with open(path, "w") as f:
        json.dump(registers, f)

    print(f'Contents written to: {path}')

    session_file = path

    is_saved = True

def load_from_file(path):
    global session_file

    if path == "help":
        return list_json_files()
    
    check_save()
    
    path = get_path(path)

    try:

        print(f'Loading {path}')

        with open(path, "r") as f:
            global registers
            registers = json.load(f)

        print(f"Registers loaded from {path}")

        session_file = path

    except FileNotFoundError:
        print(f'File {path} not found. To view JSON files in current directory:')
        print('\n    - load help\n')

def flush_registers(reg):
    if not reg:
        print('You are about to reset all registers.')
        check_save()
        init_registers(registers_count)
    else:
        registers[reg] = None

def check_save():
    if is_saved:
        return
    
    good_answers = 'ynNY'
    save = get_input(prompt="Changes not saved. Save? [Y]/n : ")
    if not save:
        save = 'y'

    if save not in good_answers:
        check_save()

    while save == 'y' or save == 'Y':
        current_filepath = ""
        if session_file:
            current_filepath = f'[{session_file}]'
        file = get_input(prompt=f'Enter filepath {current_filepath} (help): ')
        if file == "help":
            list_json_files()
        else:
            dump_to_file(file)
            return
    
def main():

    print("\nRegister Tracker")
    
    print_commands()

    init_registers()

    while True:
        try:
            command = get_input()

            if not command:
                continue

            parts = command.split(maxsplit=2)
            cmd, arg1, arg2 = (parts + [None]*3)[:3]

            if cmd == "exit":
                check_save()
                break

            elif cmd == "set":
                set_register(arg1, arg2)

            elif cmd.isdigit():
                arg = arg1
                if arg2:
                    arg += f' {arg2}'
                set_register('v' + cmd, arg)

            elif cmd == "ls":
                list_registers(arg1)
            
            elif cmd == "clear":
                clear_screen()

            elif cmd == "dump":
                dump_to_file(arg1)

            elif cmd == "load":
                load_from_file(arg1)

            elif cmd == "flush":
                flush_registers(arg1)

            else:
                print_commands()
        
        except KeyboardInterrupt:
            break

if __name__ == "__main__":
    main()

        
