import sqlite3
import sys

from pathlib import Path

import utils.error_manager as em

from utils.settings_manager import settings


class DatabaseManager:

    _instance = None

    def __new__(cls, schema="schema1"):
        if cls._instance is None:
            cls._instance = super(DatabaseManager, cls).__new__(cls)
            cls._instance._initialized = False
        return cls._instance

    def __init__(self, schema="schema1"):
        if self._initialized:
            return
        self.vault_path = Path(settings.vault_path)
        self.schema_path = Path(settings.schema_dir_path) / f"{schema}.sql"
        self.database_path = None
        self.connection = None

    def change_database(self, database: str) -> bool:
        if self.connection:
            self.connection.close()

        if not self._database_exists(database):
            return False

        self.database_path = self.vault_path / f"{database}.db"

        return True

    def create(self, database: str) -> bool:
        """Create DB. Does not overwrite if database already exists

        Args:
            database (str): database name (not path).
        """

        if self._database_exists(database):
            return False

        self.database_path = self.vault_path / f"{database}.db"
        self._connect()
        self._execute_schema()
        self._disconnect()

        return True

    def full_insert(self, database, tool, description, tags, arguments):
        self._connect(database)

        cursor = self.connection.cursor()

        cursor.execute(
            "insert into commands (tool, arguments, description) values (?, ?, ?)",
            (tool, arguments, description),
        )

        command_id = cursor.lastrowid

        tag_ids = []
        for tag in tags:
            cursor.execute("insert or ignore into tags (tag) values (?)", (tag,))
            cursor.execute("select id from tags where tag = ?", (tag,))
            tag_id = cursor.fetchone()[0]
            tag_ids.append(tag_id)

        for tag_id in tag_ids:
            cursor.execute(
                "insert into command_tags (command_id, tag_id) values (?, ?)",
                (command_id, tag_id),
            )

        self.connection.commit()
        self._disconnect()

    def get_commands_by_tool(self, tool: str) -> list:
        results = []

        self._connect()
        cursor = self.connection.cursor()

        cursor.execute(
            """
            select c.id, c.tool, c.arguments, c.description
            from commands c
            where c.tool = ?
            """,
            (tool,),
        )

        commands = cursor.fetchall()

        for command in commands:
            results.append(dict(command))

        return results

    def get_commands_by_tags(self, tags: list) -> dict:
        results = {}
        for tag in tags:
            self._connect()
            cursor = self.connection.cursor()

            cursor.execute(
                """
                select c.id, c.tool, c.arguments, c.description
                from commands c
                join command_tags ct on c.id = ct.command_id
                join tags t on ct.tag_id = t.id
                where t.tag = ?
                """,
                (tag,),
            )

            commands = cursor.fetchall()

            results[tag] = []

            for command in commands:
                results[tag] = dict(command)

        return results

    def list_databases(self):
        return list(self.vault_path.glob("*.db"))

    def _connect(self):
        """Closes existing connection (if any) and connect to new database.

        Args:
            database (str): database name (not path)
        """
        if self.connection:
            self.connection.close()

        if not self.database_path:
            print(f"No database selected")
            sys.exit(1)

        self.connection = sqlite3.connect(self.database_path)
        self.connection.row_factory = sqlite3.Row

    def _disconnect(self):
        """Disconnect from database if any."""
        if self.connection:
            self.connection.close()

    def _execute_schema(self):
        """Executa schema in self.schema_path"""
        if not self.schema_path.exists():
            print(
                f"Error creating database. Could not execute schema.\nFile not found: {self.schema_path}"
            )
            sys.exit(1)

        schema_sql = self.schema_path.read_text(encoding="utf-8")
        self.connection.cursor().executescript(schema_sql)
        self.connection.commit()

    def _database_exists(self, database: str) -> bool:
        tmp = self.vault_path / f"{database}.db"
        return tmp.exists()


db_manager = DatabaseManager()
