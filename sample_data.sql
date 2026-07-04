-- helpdesk-db: Sample data for testing queries
-- Run schema.sql first, then this file.

-- Departments
INSERT INTO departments (name) VALUES
    ('HR'),
    ('Engineering'),
    ('Sales'),
    ('Finance'),
    ('Marketing');

-- Users
INSERT INTO users (full_name, email, department_id) VALUES
    ('Alice Moore',    'alice.moore@company.com',    1),
    ('Bob Carter',     'bob.carter@company.com',     2),
    ('Carlos Rivera',  'carlos.rivera@company.com',  3),
    ('Diana Pham',     'diana.pham@company.com',     4),
    ('Ethan Brooks',   'ethan.brooks@company.com',   5),
    ('Fatima Malik',   'fatima.malik@company.com',   2),
    ('George Wu',      'george.wu@company.com',      1),
    ('Hannah Scott',   'hannah.scott@company.com',   3);

-- Technicians
INSERT INTO technicians (full_name, email, level) VALUES
    ('Marco Reyes',   'marco.reyes@it.company.com',   'L1'),
    ('Sara Kim',      'sara.kim@it.company.com',      'L2'),
    ('James Okafor',  'james.okafor@it.company.com',  'L3');

-- Categories
INSERT INTO categories (name) VALUES
    ('Hardware'),
    ('Software'),
    ('Network'),
    ('Account Access'),
    ('Email'),
    ('Printer');

-- Tickets
INSERT INTO tickets (title, description, status, priority, user_id, technician_id, category_id, created_at, resolved_at) VALUES
    ('Laptop won''t turn on',          'User reports pressing power button with no response.',         'open',        'high',     1, 1, 1, datetime('now', '-10 days'), NULL),
    ('Can''t access shared drive',     'Getting permission denied when trying to open S: drive.',      'in_progress', 'medium',   2, 2, 3, datetime('now', '-7 days'),  NULL),
    ('Outlook keeps crashing',         'Crashes every time user tries to open an attachment.',         'resolved',    'medium',   3, 1, 5, datetime('now', '-5 days'),  datetime('now', '-3 days')),
    ('Printer offline in Sales',       'HP LaserJet showing offline for entire Sales department.',     'open',        'high',     4, NULL, 6, datetime('now', '-2 days'), NULL),
    ('Password reset request',         'User locked out of account after too many failed attempts.',   'resolved',    'low',      5, 1, 4, datetime('now', '-8 days'),  datetime('now', '-7 days')),
    ('VPN not connecting',             'Unable to connect to VPN from home. Error code 800.',         'open',        'critical', 6, 2, 3, datetime('now', '-1 days'),  NULL),
    ('New laptop setup',               'New hire needs laptop configured with standard software.',     'in_progress', 'medium',   7, 3, 2, datetime('now', '-3 days'),  NULL),
    ('Monitor flickering',             'Second monitor flickers intermittently during video calls.',   'open',        'low',      8, NULL, 1, datetime('now', '-4 days'), NULL),
    ('Excel file won''t open',         'Getting "file format not supported" error on .xlsx file.',    'resolved',    'medium',   1, 1, 2, datetime('now', '-6 days'),  datetime('now', '-5 days')),
    ('No internet on docked laptop',   'Laptop has no internet when docked but works on Wi-Fi.',     'open',        'high',     2, 2, 3, datetime('now', '-12 days'), NULL);

-- Comments
INSERT INTO comments (ticket_id, author_name, body, created_at) VALUES
    (1, 'Marco Reyes',  'Checked power adapter — seems fine. Scheduling hardware inspection.', datetime('now', '-9 days')),
    (2, 'Sara Kim',     'Confirmed permissions issue. Escalated to network team.',              datetime('now', '-6 days')),
    (3, 'Marco Reyes',  'Repaired Outlook profile. Issue resolved.',                            datetime('now', '-3 days')),
    (6, 'Sara Kim',     'Checking firewall rules. May be a port block on user''s home router.', datetime('now', '-12 hours')),
    (7, 'James Okafor', 'Installed OS and core apps. Setting up domain join next.',            datetime('now', '-2 days')),
    (10, 'Sara Kim',    'Suspect driver issue with dock. Testing with different dock unit.',    datetime('now', '-10 days'));
