import sqlite3

from pathlib import Path

import utils.error_manager as em

from utils.settings_manager import settings

class DatabaseManager:
    def __init__(self, schema='schema1'):
        self.database_dir = Path(settings.get_vault_path())          
        self.schema_path = Path(settings.get_schema_dir()) / f'{schema}.sql'
        self.database_path = None
        self.connection = None

    def create(self, database: str):
        """Create DB. Does not overwrite if database already exists

        Args:
            database (str): database name (not path).
        """
        self.database_path = self.database_dir / f'{database}.db'

        self.connection = sqlite3.connect(self.database_path)
        self.connection.row_factory = sqlite3.Row

        if not self._table_exists('commands'):
            self._execute_schema()
        else:
            print('Warning: database exists. Not performing any action.')

        self.disconnect()

    def connect(self, database: str):
        """Closes existing connection (if any) and connect to new database.

        Args:
            database (str): database name (not path)
        """
        if self.connection:
            self.connection.close()

        self.database_path = self.database_dir / f'{database}.db'

        em.file_exists(self.database_path)
        
        self.connection = sqlite3.connect(self.database_path)
        self.connection.row_factory = sqlite3.Row

    def disconnect(self):
        """Disconnect from database if any. 
        """
        if self.connection:
            self.connection.close()

    def _execute_schema(self):
        """Executa schema in self.schema_path
        """
        em.file_exists(self.schema_path)

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