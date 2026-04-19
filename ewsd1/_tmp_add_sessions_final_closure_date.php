<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$existsStmt = $pdo->prepare("SELECT COUNT(*) AS cnt FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='ewsd1' AND TABLE_NAME='sessions' AND COLUMN_NAME='final_closure_date'");
$existsStmt->execute();
$exists = (int)$existsStmt->fetch(PDO::FETCH_ASSOC)['cnt'];
if ($exists === 0) {
  $pdo->exec("ALTER TABLE sessions ADD COLUMN final_closure_date DATETIME NULL AFTER closes_at");
  $pdo->exec("UPDATE sessions SET final_closure_date = closes_at WHERE final_closure_date IS NULL");
  echo "ADDED_AND_BACKFILLED\n";
} else {
  $pdo->exec("UPDATE sessions SET final_closure_date = closes_at WHERE final_closure_date IS NULL");
  echo "EXISTS_BACKFILLED\n";
}
?>
