from utils.db_manager import DatabaseManager

from utils.db_manager import db_manager


def run(args):
    table_name = args.cheatsheet
    db_manager.create(table_name)