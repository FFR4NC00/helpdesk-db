-- helpdesk-db: Useful queries for IT help desk reporting
-- Run schema.sql and sample_data.sql first.


-- 1. All open tickets, sorted by priority (critical first)
SELECT
    t.id,
    t.title,
    t.priority,
    t.status,
    u.full_name AS submitted_by,
    c.name AS category,
    t.created_at
FROM tickets t
JOIN users u ON t.user_id = u.id
JOIN categories c ON t.category_id = c.id
WHERE t.status IN ('open', 'in_progress')
ORDER BY
    CASE t.priority
        WHEN 'critical' THEN 1
        WHEN 'high'     THEN 2
        WHEN 'medium'   THEN 3
        WHEN 'low'      THEN 4
    END;


-- 2. Ticket count per technician (workload overview)
SELECT
    tech.full_name AS technician,
    tech.level,
    COUNT(t.id) AS total_assigned,
    SUM(CASE WHEN t.status = 'resolved' THEN 1 ELSE 0 END) AS resolved,
    SUM(CASE WHEN t.status IN ('open', 'in_progress') THEN 1 ELSE 0 END) AS still_open
FROM technicians tech
LEFT JOIN tickets t ON t.technician_id = tech.id
GROUP BY tech.id
ORDER BY total_assigned DESC;


-- 3. Unassigned open tickets (nobody is working on these yet)
SELECT
    t.id,
    t.title,
    t.priority,
    u.full_name AS submitted_by,
    c.name AS category,
    t.created_at
FROM tickets t
JOIN users u ON t.user_id = u.id
JOIN categories c ON t.category_id = c.id
WHERE t.technician_id IS NULL
  AND t.status = 'open'
ORDER BY t.created_at ASC;


-- 4. Tickets open for more than 5 days without resolution (overdue)
SELECT
    t.id,
    t.title,
    t.priority,
    t.status,
    u.full_name AS submitted_by,
    tech.full_name AS assigned_to,
    CAST(julianday('now') - julianday(t.created_at) AS INTEGER) AS days_open
FROM tickets t
JOIN users u ON t.user_id = u.id
LEFT JOIN technicians tech ON t.technician_id = tech.id
WHERE t.status IN ('open', 'in_progress')
  AND julianday('now') - julianday(t.created_at) > 5
ORDER BY days_open DESC;


-- 5. Average resolution time per category (in days)
SELECT
    c.name AS category,
    COUNT(t.id) AS resolved_tickets,
    ROUND(AVG(julianday(t.resolved_at) - julianday(t.created_at)), 1) AS avg_days_to_resolve
FROM tickets t
JOIN categories c ON t.category_id = c.id
WHERE t.status = 'resolved'
GROUP BY c.id
ORDER BY avg_days_to_resolve DESC;


-- 6. Tickets submitted per department
SELECT
    d.name AS department,
    COUNT(t.id) AS tickets_submitted
FROM tickets t
JOIN users u ON t.user_id = u.id
JOIN departments d ON u.department_id = d.id
GROUP BY d.id
ORDER BY tickets_submitted DESC;


-- 7. Full ticket detail view with all related info
SELECT
    t.id,
    t.title,
    t.description,
    t.status,
    t.priority,
    u.full_name AS submitted_by,
    d.name AS department,
    c.name AS category,
    tech.full_name AS assigned_to,
    tech.level AS tech_level,
    t.created_at,
    t.resolved_at
FROM tickets t
JOIN users u ON t.user_id = u.id
JOIN departments d ON u.department_id = d.id
JOIN categories c ON t.category_id = c.id
LEFT JOIN technicians tech ON t.technician_id = tech.id
ORDER BY t.id;
