# helpdesk-db

A SQL database schema for a basic IT help desk ticketing system, built with SQLite.
Includes realistic sample data and a set of queries covering common IT reporting needs.

---

## Schema Overview

| Table | Description |
|---|---|
| `departments` | Company departments (HR, Engineering, etc.) |
| `users` | End users who submit tickets |
| `technicians` | IT staff, with support level (L1/L2/L3) |
| `categories` | Issue types (Hardware, Software, Network, etc.) |
| `tickets` | The core table — tracks every issue from open to resolved |
| `comments` | Notes and updates added to a ticket over time |

---

## Queries Included

1. All open tickets sorted by priority
2. Workload overview per technician
3. Unassigned open tickets
4. Overdue tickets (open longer than 5 days)
5. Average resolution time per category
6. Ticket volume per department
7. Full ticket detail view

---

## How to Run

**Option 1: SQLite CLI**
```bash
sqlite3 helpdesk.db < schema.sql
sqlite3 helpdesk.db < sample_data.sql
sqlite3 helpdesk.db < queries.sql
```

**Option 2: DB Browser for SQLite (GUI)**
1. Download [DB Browser for SQLite](https://sqlitebrowser.org/)
2. Open a new database
3. Run `schema.sql`, then `sample_data.sql`, then `queries.sql`

---

## About

Built to practice SQL in an IT support context — designing normalized schemas,
writing reporting queries, and understanding how ticketing systems store and surface data.
