<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$tables = ['comments','comment_replies','contributors'];
foreach ($tables as $t) {
  echo "TABLE:$t\n";
  $stmt = $pdo->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='ewsd1' AND TABLE_NAME='".$t."' ORDER BY ORDINAL_POSITION");
  $cols = $stmt->fetchAll(PDO::FETCH_COLUMN);
  foreach ($cols as $c) { echo $c . "\n"; }
}
?>
