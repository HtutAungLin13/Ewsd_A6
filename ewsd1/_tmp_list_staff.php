<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$stmt = $pdo->query('SELECT id, name, email FROM staff ORDER BY id');
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
foreach ($rows as $r) {
  echo $r['id'] . "\t" . $r['name'] . "\t" . $r['email'] . "\n";
}
?>
