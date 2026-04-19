<?php
require __DIR__ . '/../config/db_connection.php';

$pdo = (new Database())->connect();

function table_count(PDO $pdo, string $table): int {
    return (int)$pdo->query("SELECT COUNT(*) FROM `$table`")->fetchColumn();
}

function pick_first(PDO $pdo, string $sql, array $params = []): ?array {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    return $row ?: null;
}

$inserted = [];

try {
    $pdo->beginTransaction();

    $admin = pick_first($pdo, "SELECT id FROM admin_users WHERE role = 'Admin' ORDER BY id LIMIT 1")
        ?? pick_first($pdo, "SELECT id FROM admin_users ORDER BY id LIMIT 1");
    $coordinator = pick_first($pdo, "SELECT id FROM admin_users WHERE role = 'QACoordinator' ORDER BY id LIMIT 1")
        ?? pick_first($pdo, "SELECT id FROM admin_users ORDER BY id LIMIT 1");
    $qaManager = pick_first($pdo, "SELECT id FROM admin_users WHERE role = 'QAManager' ORDER BY id LIMIT 1")
        ?? $admin;

    $cat1 = pick_first($pdo, "SELECT id, name, description FROM idea_categories ORDER BY id LIMIT 1");
    $cat2 = pick_first($pdo, "SELECT id, name, description FROM idea_categories ORDER BY id LIMIT 1 OFFSET 1");

    $ideaRows = $pdo->query("SELECT id, contributor_id, session_id, title, department FROM ideas ORDER BY id LIMIT 6")->fetchAll(PDO::FETCH_ASSOC);
    $commentRows = $pdo->query("SELECT id, idea_id, contributor_id, content FROM comments ORDER BY id LIMIT 6")->fetchAll(PDO::FETCH_ASSOC);
    $staffRows = $pdo->query("SELECT id, name, department FROM staff ORDER BY id LIMIT 6")->fetchAll(PDO::FETCH_ASSOC);
    $sessionRows = $pdo->query("SELECT id, session_name FROM sessions ORDER BY id LIMIT 6")->fetchAll(PDO::FETCH_ASSOC);
    $contribRows = $pdo->query("SELECT id, name, department FROM contributors ORDER BY id LIMIT 10")->fetchAll(PDO::FETCH_ASSOC);

    if (table_count($pdo, 'category_backups') === 0 && $admin && $cat1) {
        $snapshot = [];
        $allCats = $pdo->query("SELECT id, name, description, is_active FROM idea_categories ORDER BY id")->fetchAll(PDO::FETCH_ASSOC);
        foreach ($allCats as $c) {
            $snapshot[] = [
                'id' => (int)$c['id'],
                'name' => $c['name'],
                'description' => $c['description'],
                'is_active' => (int)$c['is_active']
            ];
        }
        $stmt = $pdo->prepare(
            "INSERT INTO category_backups (backup_name, category_snapshot, backup_note, created_by_admin_id, created_at)
             VALUES (?, ?, ?, ?, ?)"
        );
        $stmt->execute([
            'Quarterly Category Backup',
            json_encode($snapshot, JSON_UNESCAPED_UNICODE),
            'Initial seeded backup for dashboard testing',
            (int)$admin['id'],
            '2026-03-22 08:30:00'
        ]);
        $inserted['category_backups'] = 1;
    }

    if (table_count($pdo, 'comment_replies') === 0 && count($commentRows) >= 2 && count($contribRows) >= 2) {
        $stmt = $pdo->prepare(
            "INSERT INTO comment_replies
            (parent_comment_id, idea_id, contributor_id, content, mentioned_staff_id, is_anonymous, is_inappropriate, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        );

        $rows = [
            [
                (int)$commentRows[0]['id'],
                (int)$commentRows[0]['idea_id'],
                (int)$contribRows[1]['id'],
                "Good question. We can start with a pilot and measure impact before full rollout.",
                $staffRows[0]['id'] ?? null,
                0, 0, '2026-03-22 08:45:00'
            ],
            [
                (int)$commentRows[1]['id'],
                (int)$commentRows[1]['idea_id'],
                (int)$contribRows[0]['id'],
                "I can help draft the implementation checklist and timeline this week.",
                $staffRows[1]['id'] ?? null,
                0, 0, '2026-03-22 09:00:00'
            ],
            [
                (int)$commentRows[2]['id'],
                (int)$commentRows[2]['idea_id'],
                (int)$contribRows[2]['id'],
                "Let's include training materials so teams can adopt it consistently.",
                null,
                1, 0, '2026-03-22 09:20:00'
            ]
        ];
        foreach ($rows as $r) {
            $stmt->execute($r);
        }
        $inserted['comment_replies'] = count($rows);
    }

    if (table_count($pdo, 'contributor_account_history') === 0 && $admin && count($contribRows) >= 2) {
        $stmt = $pdo->prepare(
            "INSERT INTO contributor_account_history (contributor_id, admin_id, action, reason, created_at)
             VALUES (?, ?, ?, ?, ?)"
        );
        $rows = [
            [(int)$contribRows[3]['id'], (int)$admin['id'], 'Disabled', 'Repeated off-topic submissions in one session', '2026-02-10 10:30:00'],
            [(int)$contribRows[3]['id'], (int)$admin['id'], 'Re-enabled', 'Issue resolved after policy reminder', '2026-02-15 09:15:00'],
            [(int)$contribRows[4]['id'], (int)$admin['id'], 'Blocked', 'Multiple reports of inappropriate language', '2026-03-05 14:40:00']
        ];
        foreach ($rows as $r) {
            $stmt->execute($r);
        }
        $inserted['contributor_account_history'] = count($rows);
    }

    if (table_count($pdo, 'coordinator_content_reports') === 0 && $coordinator && count($ideaRows) >= 2 && count($commentRows) >= 1) {
        $stmt = $pdo->prepare(
            "INSERT INTO coordinator_content_reports
            (coordinator_id, content_type, content_id, report_reason, report_category, description, severity, status, escalated_to_admin, escalated_at, reported_at, resolved_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        $rows = [
            [(int)$coordinator['id'], 'Idea', (int)$ideaRows[0]['id'], 'Possible duplicate with existing proposal', 'Other', 'The scope appears similar to a previously approved idea.', 'Low', 'Dismissed', 0, null, '2026-03-18 09:10:00', '2026-03-18 10:00:00'],
            [(int)$coordinator['id'], 'Comment', (int)$commentRows[0]['id'], 'Contains borderline offensive tone', 'Offensive', 'Needs QA manager review before visible escalation.', 'Medium', 'Under_Review', 1, '2026-03-19 11:25:00', '2026-03-19 11:10:00', null],
            [(int)$coordinator['id'], 'Idea', (int)$ideaRows[1]['id'], 'Contains unsupported claims', 'Defamation', 'Statement references a team without evidence.', 'High', 'Flagged', 1, '2026-03-20 13:15:00', '2026-03-20 13:00:00', null]
        ];
        foreach ($rows as $r) {
            $stmt->execute($r);
        }
        $inserted['coordinator_content_reports'] = count($rows);
    }

    if (table_count($pdo, 'coordinator_reminders') === 0 && $coordinator && count($sessionRows) >= 1) {
        $stmt = $pdo->prepare(
            "INSERT INTO coordinator_reminders
            (coordinator_id, session_id, department, reminder_type, recipients_count, message, sent_at)
            VALUES (?, ?, ?, ?, ?, ?, ?)"
        );
        $rows = [
            [(int)$coordinator['id'], (int)$sessionRows[0]['id'], 'Innovation', 'Invitation', 4, 'You are invited to submit ideas before the submission window closes.', '2026-03-16 08:30:00'],
            [(int)$coordinator['id'], (int)$sessionRows[0]['id'], 'Innovation', 'Reminder', 3, 'Friendly reminder to post at least one idea and comment on peers.', '2026-03-18 08:45:00'],
            [(int)$coordinator['id'], (int)$sessionRows[0]['id'], 'Innovation', 'Final_Call', 2, 'Final call: submissions close tonight at 23:59.', '2026-03-21 18:00:00']
        ];
        foreach ($rows as $r) {
            $stmt->execute($r);
        }
        $inserted['coordinator_reminders'] = count($rows);
    }

    if (table_count($pdo, 'department_performance_stats') === 0 && count($sessionRows) >= 1) {
        $targetPairs = [];
        foreach ($ideaRows as $idea) {
            $key = $idea['session_id'] . '|' . $idea['department'];
            $targetPairs[$key] = ['session_id' => (int)$idea['session_id'], 'department' => (string)$idea['department']];
        }
        if (empty($targetPairs)) {
            $targetPairs['fallback'] = ['session_id' => (int)$sessionRows[0]['id'], 'department' => 'Innovation'];
        }

        $stmt = $pdo->prepare(
            "INSERT INTO department_performance_stats
            (session_id, department, total_staff, staff_submitted, staff_not_submitted, total_ideas, total_comments, unanswered_comments, total_reports, approval_rate, engagement_rate, last_updated)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );

        $rowCount = 0;
        foreach (array_values($targetPairs) as $pair) {
            if ($rowCount >= 4) {
                break;
            }
            $sid = (int)$pair['session_id'];
            $dept = $pair['department'];

            $totalStaff = (int)$pdo->prepare("SELECT COUNT(*) FROM staff WHERE department = ?")->execute([$dept]) ?: 0;
            $stmtStaff = $pdo->prepare("SELECT COUNT(*) FROM staff WHERE department = ?");
            $stmtStaff->execute([$dept]);
            $totalStaff = (int)$stmtStaff->fetchColumn();
            if ($totalStaff === 0) {
                $totalStaff = 3;
            }

            $stmtIdeas = $pdo->prepare("SELECT COUNT(*) FROM ideas WHERE session_id = ? AND department = ?");
            $stmtIdeas->execute([$sid, $dept]);
            $totalIdeas = (int)$stmtIdeas->fetchColumn();

            $stmtComments = $pdo->prepare("SELECT COUNT(*) FROM comments c JOIN ideas i ON i.id = c.idea_id WHERE i.session_id = ? AND i.department = ?");
            $stmtComments->execute([$sid, $dept]);
            $totalComments = (int)$stmtComments->fetchColumn();

            $staffSubmitted = min($totalStaff, max(1, $totalIdeas));
            $staffNotSubmitted = max(0, $totalStaff - $staffSubmitted);
            $unanswered = max(0, (int)floor($totalComments / 3));
            $totalReports = (int)floor(($totalIdeas + $totalComments) / 4);
            $approvalRate = $totalIdeas > 0 ? round((($totalIdeas - max(0, $totalReports - 1)) / $totalIdeas) * 100, 2) : 0.00;
            $engagementRate = round((($staffSubmitted + ($totalComments * 0.3)) / max(1, $totalStaff)) * 100, 2);
            if ($engagementRate > 100) {
                $engagementRate = 100.00;
            }

            $stmt->execute([
                $sid, $dept, $totalStaff, $staffSubmitted, $staffNotSubmitted,
                $totalIdeas, $totalComments, $unanswered, $totalReports,
                $approvalRate, $engagementRate, '2026-03-22 09:30:00'
            ]);
            $rowCount++;
        }
        $inserted['department_performance_stats'] = $rowCount;
    }

    if (table_count($pdo, 'idea_attachments') === 0 && count($ideaRows) >= 2) {
        $stmt = $pdo->prepare(
            "INSERT INTO idea_attachments
            (idea_id, file_name, file_path, file_type, file_size, uploaded_by_contributor_id, is_flagged, flagged_reason, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        $rows = [
            [(int)$ideaRows[0]['id'], 'dashboard-wireframe.pdf', '/uploads/ideas/dashboard-wireframe.pdf', 'application/pdf', 428512, (int)$ideaRows[0]['contributor_id'], 0, null, '2026-03-17 10:20:00'],
            [(int)$ideaRows[1]['id'], 'testing-checklist.xlsx', '/uploads/ideas/testing-checklist.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 132448, (int)$ideaRows[1]['contributor_id'], 0, null, '2026-03-17 11:05:00'],
            [(int)$ideaRows[0]['id'], 'mockup.png', '/uploads/ideas/mockup.png', 'image/png', 245981, (int)$ideaRows[0]['contributor_id'], 0, null, '2026-03-18 09:40:00']
        ];
        foreach ($rows as $r) {
            $stmt->execute($r);
        }
        $inserted['idea_attachments'] = count($rows);
    }

    if (table_count($pdo, 'inappropriate_content_log') === 0 && $qaManager && count($commentRows) >= 1 && count($ideaRows) >= 1) {
        $stmt = $pdo->prepare(
            "INSERT INTO inappropriate_content_log
            (admin_id, content_type, content_id, reason, action, notes, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?)"
        );
        $rows = [
            [(int)$qaManager['id'], 'Comment', (int)$commentRows[0]['id'], 'Contains unprofessional wording', 'Flagged', 'Flagged for moderation follow-up', '2026-03-19 11:30:00'],
            [(int)$qaManager['id'], 'Idea', (int)$ideaRows[1]['id'], 'Potentially defamatory claim', 'Hidden', 'Temporarily hidden pending review', '2026-03-20 13:20:00'],
            [(int)$qaManager['id'], 'Attachment', 1, 'Contains unrelated personal data', 'Removed', 'Attachment removed and uploader notified', '2026-03-21 09:55:00']
        ];
        foreach ($rows as $r) {
            $stmt->execute($r);
        }
        $inserted['inappropriate_content_log'] = count($rows);
    }

    if (table_count($pdo, 'qa_hidden_content_records') === 0 && $admin && count($ideaRows) >= 1 && count($commentRows) >= 1) {
        $stmt = $pdo->prepare(
            "INSERT INTO qa_hidden_content_records
            (contributor_id, content_type, content_id, previous_state_json, hidden_by_admin_id, hidden_at, is_restored, restored_by_admin_id, restored_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        $rows = [
            [
                (int)$ideaRows[0]['contributor_id'],
                'Idea',
                (int)$ideaRows[0]['id'],
                json_encode(['status' => 'Published', 'is_inappropriate' => 0, 'title' => $ideaRows[0]['title']], JSON_UNESCAPED_UNICODE),
                (int)$admin['id'],
                '2026-03-20 14:05:00',
                1,
                (int)$admin['id'],
                '2026-03-20 16:30:00'
            ],
            [
                (int)$commentRows[0]['contributor_id'],
                'Comment',
                (int)$commentRows[0]['id'],
                json_encode(['is_deleted' => 0, 'is_inappropriate' => 0, 'content' => $commentRows[0]['content']], JSON_UNESCAPED_UNICODE),
                (int)$admin['id'],
                '2026-03-21 09:20:00',
                0,
                null,
                null
            ],
            [
                (int)$contribRows[1]['id'],
                'Reply',
                1,
                json_encode(['is_deleted' => 0, 'is_inappropriate' => 0], JSON_UNESCAPED_UNICODE),
                (int)$admin['id'],
                '2026-03-21 10:05:00',
                0,
                null,
                null
            ]
        ];
        foreach ($rows as $r) {
            $stmt->execute($r);
        }
        $inserted['qa_hidden_content_records'] = count($rows);
    }

    if (table_count($pdo, 'staff_invitations') === 0 && $coordinator && count($staffRows) >= 2 && count($sessionRows) >= 1) {
        $stmt = $pdo->prepare(
            "INSERT INTO staff_invitations
            (coordinator_id, staff_id, session_id, message, sent_at, read_at)
            VALUES (?, ?, ?, ?, ?, ?)"
        );
        $rows = [
            [(int)$coordinator['id'], (int)$staffRows[0]['id'], (int)$sessionRows[0]['id'], 'Please share one improvement idea for this session.', '2026-03-16 08:35:00', '2026-03-16 09:10:00'],
            [(int)$coordinator['id'], (int)$staffRows[1]['id'], (int)$sessionRows[0]['id'], 'Your department input is needed for quality review planning.', '2026-03-16 08:36:00', null],
            [(int)$coordinator['id'], (int)$staffRows[2]['id'], (int)$sessionRows[0]['id'], 'Reminder: comment on at least one peer idea before close.', '2026-03-18 08:50:00', '2026-03-18 10:05:00']
        ];
        foreach ($rows as $r) {
            $stmt->execute($r);
        }
        $inserted['staff_invitations'] = count($rows);
    }

    $pdo->commit();

    echo "Seed complete.\n";
    if (empty($inserted)) {
        echo "No inserts were needed.\n";
    } else {
        foreach ($inserted as $table => $count) {
            echo $table . ": inserted " . $count . "\n";
        }
    }
} catch (Throwable $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    echo "Seeder failed: " . $e->getMessage() . "\n";
    exit(1);
}

