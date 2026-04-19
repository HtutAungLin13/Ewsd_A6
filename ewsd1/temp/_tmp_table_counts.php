<?php
require __DIR__ . '/../config/db_connection.php';
$pdo = (new Database())->connect();
$tables = $pdo->query('SHOW TABLES')->fetchAll(PDO::FETCH_COLUMN);
foreach ($tables as $t) {
  $cnt = (int)$pdo->query("SELECT COUNT(*) FROM `$t`")->fetchColumn();
  echo $t . "\t" . $cnt . PHP_EOL;
}
?>
