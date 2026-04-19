<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$checks = [
  ['ideas','is_anonymous'],
  ['sessions','final_closure_date']
];
foreach ($checks as $chk) {
  $stmt = $pdo->prepare("SELECT COUNT(*) AS cnt FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='ewsd1' AND TABLE_NAME=? AND COLUMN_NAME=?");
  $stmt->execute([$chk[0], $chk[1]]);
  $cnt = (int)$stmt->fetch(PDO::FETCH_ASSOC)['cnt'];
  echo $chk[0] . "." . $chk[1] . "=" . $cnt . "\n";
}
?>
