import utils.args_manager as am

from utils.settings_manager import settings

if __name__ == '__main__':
    parser = am.get_parser()
    args = parser.parse_args()
    args.func(args)

    print(settings['global'])