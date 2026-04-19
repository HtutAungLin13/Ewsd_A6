<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$stmt = $pdo->prepare('SELECT id, username, email, role, department FROM admin_users WHERE email = ?');
$stmt->execute(['staff1@example.com']);
$row = $stmt->fetch(PDO::FETCH_ASSOC);
if ($row) {
  echo $row['id'] . "\t" . $row['username'] . "\t" . $row['email'] . "\t" . $row['role'] . "\t" . $row['department'] . "\n";
} else {
  echo "NOT_FOUND\n";
}
?>
