from utils.db_manager import DatabaseManager

from utils.db_manager import db_manager


def create_sheet(sheet: str) -> str:
    if len(sheet.split()) != 1:
        print("Error: can only create one sheet at once")
        return

    if not db_manager.create(sheet):
        print("Error: sheet already exists")
        return

    return sheet
