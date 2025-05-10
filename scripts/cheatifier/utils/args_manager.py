import argparse

from actions import create

def get_parser():
    parser = argparse.ArgumentParser(
        prog="cheatifier",
        description="A CLI tool to create and manage cheatsheets.",
    )

    subparsers = {}

    sps = parser.add_subparsers(title='main actions', dest='command', required=True)

    subparsers['create'] = sps.add_parser('create', help='Create new cheatsheet')
    subparsers['create'].add_argument('cheatsheet', help='Name of the cheatsheet')
    subparsers['create'].set_defaults(func=create.run)

    subparsers['add'] = sps.add_parser('add', help='Add entry to cheatsheet')
    subparsers['add'].add_argument('cheatsheet', help='Name of the cheatsheet')


    return parser