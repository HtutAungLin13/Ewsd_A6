<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$pdo->exec("ALTER TABLE admin_users MODIFY role ENUM('Admin','QAManager','QACoordinator','Staff') DEFAULT 'Admin'");
$stmt = $pdo->prepare("UPDATE admin_users SET role = 'Staff' WHERE username = ?");
$stmt->execute(['staff2']);
$check = $pdo->prepare("SELECT id, username, role FROM admin_users WHERE username = ?");
$check->execute(['staff2']);
$row = $check->fetch(PDO::FETCH_ASSOC);
if ($row) { echo $row['id'] . "\t" . $row['username'] . "\t" . $row['role'] . "\n"; }
?>
