-- Elimina le tabelle se esistono
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS foto;

-- Crea la tabella 'accounts'
CREATE TABLE accounts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE CHECK(length(username) <= 50),
    email TEXT NOT NULL UNIQUE CHECK(length(email) <= 255),
    password_ TEXT NOT NULL CHECK(length(password_) <= 20),
    role TEXT NOT NULL CHECK(length(role) <= 10),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME
);

-- Crea la tabella 'post'
CREATE TABLE post (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id INTEGER,
    title TEXT NOT NULL UNIQUE CHECK(length(title) <= 25),
    content TEXT NOT NULL CHECK(length(content) <= 50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crea la tabella 'foto'
CREATE TABLE foto (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id INTEGER,
    filename TEXT NOT NULL UNIQUE CHECK(length(filename) <= 25),
    file_size TEXT NOT NULL CHECK(length(file_size) <= 10),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crea i trigger per aggiornare updated_at
CREATE TRIGGER update_accounts_updated_at
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
    UPDATE accounts
    SET updated_at = CURRENT_TIMESTAMP
    WHERE id = OLD.id;
END;

CREATE TRIGGER update_post_updated_at
AFTER UPDATE ON post
FOR EACH ROW
BEGIN
    UPDATE post
    SET updated_at = CURRENT_TIMESTAMP
    WHERE id = OLD.id;
END;

CREATE TRIGGER update_foto_updated_at
AFTER UPDATE ON foto
FOR EACH ROW
BEGIN
    UPDATE foto
    SET updated_at = CURRENT_TIMESTAMP
    WHERE id = OLD.id;
END;
