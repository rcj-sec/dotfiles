import readline

from actions import help, create, add, manage, query


def close():
    print("👋 Bye!")


def cheetah():

    active_sheet = ""

    print(
        "Welcome to Cheetah CLI 🐆! (type 'help' or 'h' for available actions, 'exit' to quit)"
    )

    while True:
        try:
            user_input = input(f"🐆 {active_sheet}> ").strip().split(maxsplit=1)
            action = user_input[0]
            args = user_input[1] if len(user_input) > 1 else None

            if action == "exit":
                close()
                break

            elif action == "help" or action == "h":
                help.run()

            elif action == "?":
                help.print_available_sheets()

            elif action == "create":
                active_sheet = f"{create.create_sheet(args)} "

            elif action == "select":
                active_sheet = f"{manage.select_sheet(args)} "

        except KeyboardInterrupt:
            close()
            break
        except EOFError:
            close()
            break


if __name__ == "__main__":
    cheetah()
