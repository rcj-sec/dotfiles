-- Commands Table
CREATE TABLE commands (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tool TEXT NOT NULL,
    description TEXT
);

-- Tags Table
CREATE TABLE tags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tag TEXT NOT NULL UNIQUE
);

-- Junction Table (Many-to-Many relationship between commands and tags)
CREATE TABLE command_tags (
    command_id INTEGER,
    tag_id INTEGER,
    FOREIGN KEY (command_id) REFERENCES commands(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id),
    PRIMARY KEY (command_id, tag_id)
);

-- Arguments Table (Storing command arguments in a flexible way)
CREATE TABLE arguments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    command_id INTEGER,
    argument TEXT NOT NULL,
    position INTEGER NOT NULL,
    FOREIGN KEY (command_id) REFERENCES commands(id)
);
