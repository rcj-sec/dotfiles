import sqlite3
import sys

from pathlib import Path

import utils.error_manager as em

from utils.settings_manager import settings

class DatabaseManager:
    
    _instance = None

    def __new__(cls, schema='schema1'):
        if cls._instance is None:
            cls._instance = super(DatabaseManager, cls).__new__(cls)
            cls._instance._initialized = False
        return cls._instance
    
    def __init__(self, schema='schema1'):
        if self._initialized:
            return
        self.vault_path = Path(settings.vault_path)          
        self.schema_path = Path(settings.schema_dir_path) / f'{schema}.sql'
        self.database_path = None
        self.connection = None

    

    def connect(self, database: str, force=False):
        """Closes existing connection (if any) and connect to new database.

        Args:
            database (str): database name (not path)
        """
        if self.connection:
            self.connection.close()

        self.database_path = self.vault_path / f'{database}.db'

        if not self.database_path.exists() and not force:
            print(f'Error connecting to database {database}. \nFile not found: {self.database_path}')
            sys.exit(1)
        
        self.connection = sqlite3.connect(self.database_path)
        self.connection.row_factory = sqlite3.Row

    def disconnect(self):
        """Disconnect from database if any. 
        """
        if self.connection:
            self.connection.close()
            
    def create(self, database: str):
        """Create DB. Does not overwrite if database already exists

        Args:
            database (str): database name (not path).
        """
        
        self.connect(database, force=True)
        if not self._table_exists('commands'):
            self._execute_schema()
        else:
            print(f'Warning: cheatsheet {database} exists. Not performing any action.')
        self.disconnect()
        
    def full_insert(self, database, tool, description, tags, arguments):
        self.connect(database)
        
        cursor = self.connection.cursor()
        
        cursor.execute(
            'insert into commands (tool, description) values (?, ?)',
            (tool, description)
        )
        
        command_id = cursor.lastrowid
        
        tag_ids = []
        for tag in tags: 
            cursor.execute('insert or ignore into tags (tag) values (?)', (tag,))
            cursor.execute('select id from tags where tag = ?', (tag,))
            tag_id = cursor.fetchone()[0]
            tag_ids.append(tag_id)
            
        for tag_id in tag_ids:
            cursor.execute('insert into command_tags (command_id, tag_id) values (?, ?)', (command_id, tag_id))
            
        for position, argument in enumerate(arguments):
            cursor.execute('insert into arguments (command_id, argument, position) values (?, ?, ?)', (command_id, argument, position))
            
        self.connection.commit()
        self.disconnect()
        
    def get_command_by_tags(self, database, tags):
        for tag in tags:
            self.connect(database)
            cursor = self.connection.cursor()
            
            cursor.execute(
                """
                select c.id, c.tool, c.description
                from commands c
                join command_tags ct on c.id = ct.command_id
                join tags t on ct.tag_id = t.id
                where t.tag = ?
                """,
                (tag,)
            )
            
            
            
            commands = cursor.fetchall()
            for command in commands:
                print(dict(command))
        
    def database_exists(self, database: str) -> bool:
        tmp = self.vault_path / f'{database}.db'
        return tmp.exists()

    def _execute_schema(self):
        """Executa schema in self.schema_path
        """
        if not self.schema_path.exists():
            print(f'Error creating database. Could not execute schema.\nFile not found: {self.schema_path}')
            sys.exit(1)
        
        schema_sql = self.schema_path.read_text(encoding='utf-8')
        self.connection.cursor().executescript(schema_sql)
        self.connection.commit()
             
    def _table_exists(self, table: str) -> bool:
        """Check if table exists in currently connected DB

        Args:
            table (str): table name

        Returns:
            bool: true if table exists
        """
        cursor = self.connection.cursor()
        cursor.execute('SELECT name FROM sqlite_master WHERE type="table" AND name=?', (table,))
        return cursor.fetchone() is not None
    
    
    
db_manager = DatabaseManager()