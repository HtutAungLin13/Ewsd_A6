<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo=(new Database())->connect();
$stmt=$pdo->query("SELECT COLUMN_NAME, COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='ewsd1' AND TABLE_NAME='idea_attachments' ORDER BY ORDINAL_POSITION");
$rows=$stmt->fetchAll(PDO::FETCH_ASSOC);
foreach($rows as $r){echo $r['COLUMN_NAME']."\t".$r['COLUMN_TYPE']."\n";}
?>
