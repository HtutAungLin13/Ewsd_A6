<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$stmt = $pdo->query("SELECT COLUMN_TYPE, COLUMN_DEFAULT, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='ewsd1' AND TABLE_NAME='admin_users' AND COLUMN_NAME='role'");
$row = $stmt->fetch(PDO::FETCH_ASSOC);
if ($row) { echo $row['COLUMN_TYPE'] . "\t" . $row['COLUMN_DEFAULT'] . "\t" . $row['IS_NULLABLE'] . "\n"; }
$stmt2 = $pdo->query("SELECT id, username, role, department FROM admin_users WHERE username='staff2'");
$row2 = $stmt2->fetch(PDO::FETCH_ASSOC);
if ($row2) { echo $row2['id'] . "\t" . $row2['username'] . "\t" . ($row2['role'] ?? 'NULL') . "\t" . ($row2['department'] ?? 'NULL') . "\n"; }
?>
