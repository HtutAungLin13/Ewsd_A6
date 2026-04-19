<?php
require __DIR__ . '/../config/db_connection.php';
$pdo=(new Database())->connect();
$targets=['category_backups','comment_replies','contributor_account_history','coordinator_content_reports','coordinator_reminders','department_performance_stats','idea_attachments','inappropriate_content_log','qa_hidden_content_records','staff_invitations'];
foreach($targets as $t){
  $row=$pdo->query("SHOW CREATE TABLE `$t`")->fetch(PDO::FETCH_ASSOC);
  echo "===== $t =====\n";
  echo $row['Create Table'] . "\n\n";
}
?>
