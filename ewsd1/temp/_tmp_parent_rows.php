<?php
require __DIR__ . '/../config/db_connection.php';
$pdo=(new Database())->connect();
$queries=[
 'admin_users'=>'SELECT id,username,role,department FROM admin_users ORDER BY id',
 'contributors'=>'SELECT id,name,email,department FROM contributors ORDER BY id LIMIT 20',
 'ideas'=>'SELECT id,session_id,contributor_id,title,department FROM ideas ORDER BY id LIMIT 20',
 'comments'=>'SELECT id,idea_id,contributor_id,content FROM comments ORDER BY id LIMIT 20',
 'sessions'=>'SELECT id,session_name,category_id FROM sessions ORDER BY id',
 'staff'=>'SELECT id,name,email,department,role FROM staff ORDER BY id',
 'idea_categories'=>'SELECT id,name FROM idea_categories ORDER BY id',
 'departments'=>'SELECT id,name,qa_coordinator_id FROM departments ORDER BY id',
 'qa_coordinator_departments'=>'SELECT id,coordinator_id,department,is_active FROM qa_coordinator_departments ORDER BY id'
];
foreach($queries as $name=>$sql){
 echo "===== $name =====\n";
 $rows=$pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
 foreach($rows as $r){echo json_encode($r, JSON_UNESCAPED_UNICODE)."\n";}
 echo "\n";
}
?>
