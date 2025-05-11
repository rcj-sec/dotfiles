from utils.db_manager import db_manager


def print_commands_by_tag(tags: str):
    tags = tags.split()

    entries = db_manager.change_database(entries)
