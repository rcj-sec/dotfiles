from utils.db_manager import db_manager


def run():
    print("\nAvailable actions:")
    print("    - ?                          list available sheets")
    print("    - create <sheet>             create an empty sheet")
    print("    - select <sheet>             select a sheet to work on")
    print("    - tag <tag1> <tag2> ...      select commands from tags")
    print("    - tool <tool>                select commands from tool")
    print()


def print_available_sheets():
    sheets = db_manager.list_databases()

    print("\nAvailable sheets:")
    for sheet in sheets:
        print(f"    - {sheet.stem}")
    print()
