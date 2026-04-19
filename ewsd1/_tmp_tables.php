<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo=(new Database())->connect();
$tables=$pdo->query("SHOW TABLES")->fetchAll(PDO::FETCH_COLUMN);
foreach($tables as $t){echo $t."\n";}
?>
