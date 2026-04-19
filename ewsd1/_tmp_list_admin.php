<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$stmt = $pdo->query('SELECT id, username, email, full_name, is_active FROM admin_users ORDER BY id');
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
foreach ($rows as $r) {
  echo $r['id'] . "\t" . $r['username'] . "\t" . $r['email'] . "\t" . $r['full_name'] . "\t" . $r['is_active'] . "\n";
}
?>
