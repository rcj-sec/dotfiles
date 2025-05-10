from utils.db_manager import DatabaseManager


def run(args):
    table_name = args.cheatsheet
    dbm = DatabaseManager()
    dbm.create(table_name)