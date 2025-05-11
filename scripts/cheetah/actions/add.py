from utils.db_manager import db_manager


def get_list_from_user(item_name):
    items = []
    item_counter = 1
    item = input(f"{item_name} {item_counter} > ").strip()

    while item:
        items.append(item)
        item_counter += 1
        item = input(f"{item_name} {item_counter} > ").strip()

    return items


def run(args):
    sheet = args.sheet

    if not db_manager.database_exists(sheet):
        print(f"Error: sheet does not exist > {sheet}")
        return

    tool = input("Tool used > ").strip()

    while len(tool.split()) != 1:
        print("Only one word is allowed")
        tool = input("Tool used > ").strip()

    arguments = get_list_from_user("Argument")
    arguments = " ".join(arguments)

    description = input("Description > ")

    tags = [tool] + get_list_from_user("Tag")

    tags = list(dict.fromkeys(tags))

    print(tool)
    print(arguments)
    print(description)
    print(tags)

    db_manager.full_insert(sheet, tool, description, tags, arguments)
