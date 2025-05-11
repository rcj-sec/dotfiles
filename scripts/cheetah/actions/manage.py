from utils.db_manager import db_manager

from actions import help


def select_sheet(sheet: str) -> str:
    if len(sheet.split()) != 1:
        print("Error: cannot select more than one sheet")
        return

    if not db_manager.change_database(sheet):
        print("Error: database does not exist.")
        help.print_available_sheets()
        return

    return sheet
