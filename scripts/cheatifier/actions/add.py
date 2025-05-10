
from utils.db_manager import DatabaseManager

def cheatsheet_exists(cheatsheet: str)
    dbm = DatabaseManager()
    dbm.connect(cheatsheet)

def run(args):
    cheatsheet = args.cheatsheet

