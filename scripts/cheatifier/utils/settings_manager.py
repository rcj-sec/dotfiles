import json
import sys
import os
from pathlib import Path

class SettingsManager:
    _instance = None
    _settings = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(SettingsManager, cls).__new__(cls)
            cls._load()
        return cls._instance
    
    @classmethod
    def _load(cls):
        settings_path = Path.home() / 'scripts' / 'cheatifier' / 'settings.json'

        if not settings_path.exists():
            print(f'Error: settings.json not found at > {settings_path}')
            sys.exit(1)

        with open(settings_path, 'r', encoding='utf-8') as f:
            cls._settings = json.load(f)

    @classmethod
    def get_global_settings(cls):
        return cls._settings['global']
    
    @classmethod
    def get_database_settings(cls):
        return cls._settings['database']

    @classmethod
    def get_vault_path(cls):
        return cls._settings['global']['vault_path']

    @classmethod
    def get_schema_dir(cls):
        return cls._settings['database']['schema_dir']

settings = SettingsManager()
 