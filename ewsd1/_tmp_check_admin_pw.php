<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$stmt = $pdo->query('SELECT username, password_hash FROM admin_users ORDER BY id');
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
$tests = ['admin123','admin1','password','Password','Password123'];
foreach ($rows as $r) {
  $line = $r['username'];
  foreach ($tests as $t) {
    if (password_verify($t, $r['password_hash'])) {
      $line .= "\t" . $t;
    }
  }
  echo $line . "\n";
}
?>
