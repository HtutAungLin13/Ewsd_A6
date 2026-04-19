<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$existsStmt = $pdo->prepare("SELECT COUNT(*) AS cnt FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='ewsd1' AND TABLE_NAME='ideas' AND COLUMN_NAME='is_anonymous'");
$existsStmt->execute();
$exists = (int)$existsStmt->fetch(PDO::FETCH_ASSOC)['cnt'];
if ($exists === 0) {
  $pdo->exec("ALTER TABLE ideas ADD COLUMN is_anonymous TINYINT(1) NOT NULL DEFAULT 0");
  echo "ADDED\n";
} else {
  echo "EXISTS\n";
}
?>
