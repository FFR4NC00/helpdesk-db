-- helpdesk-db: Schema for a basic IT help desk ticketing system
-- Database: SQLite
-- Run this file first to create all tables.

-- Departments (e.g. HR, Engineering, Sales)
CREATE TABLE IF NOT EXISTS departments (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL UNIQUE
);

-- End users who submit tickets
CREATE TABLE IF NOT EXISTS users (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name       TEXT NOT NULL,
    email           TEXT NOT NULL UNIQUE,
    department_id   INTEGER REFERENCES departments(id),
    created_at      TEXT DEFAULT (datetime('now'))
);

-- IT technicians who resolve tickets
CREATE TABLE IF NOT EXISTS technicians (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name   TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE,
    level       TEXT CHECK(level IN ('L1', 'L2', 'L3')) DEFAULT 'L1'
);

-- Issue categories
CREATE TABLE IF NOT EXISTS categories (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name    TEXT NOT NULL UNIQUE
);

-- Tickets
CREATE TABLE IF NOT EXISTS tickets (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    title           TEXT NOT NULL,
    description     TEXT,
    status          TEXT CHECK(status IN ('open', 'in_progress', 'resolved', 'closed')) DEFAULT 'open',
    priority        TEXT CHECK(priority IN ('low', 'medium', 'high', 'critical')) DEFAULT 'medium',
    user_id         INTEGER REFERENCES users(id),
    technician_id   INTEGER REFERENCES technicians(id),
    category_id     INTEGER REFERENCES categories(id),
    created_at      TEXT DEFAULT (datetime('now')),
    updated_at      TEXT DEFAULT (datetime('now')),
    resolved_at     TEXT
);

-- Comments/notes added to a ticket over time
CREATE TABLE IF NOT EXISTS comments (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    ticket_id       INTEGER REFERENCES tickets(id),
    author_name     TEXT NOT NULL,
    body            TEXT NOT NULL,
    created_at      TEXT DEFAULT (datetime('now'))
);
