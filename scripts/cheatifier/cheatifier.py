import utils.args_manager as am

from utils.db_manager import db_manager

if __name__ == '__main__':
    parser = am.get_parser()
    args = parser.parse_args()
    args.func(args)
    
    db_manager.get_command_by_tags('test', ['adb'])
    