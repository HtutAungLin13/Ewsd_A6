<?php
require 'c:\\xampp\\htdocs\\ewsd1\\config\\db_connection.php';
$pdo = (new Database())->connect();
$username = 'staff1';
$email = 'staff1@example.com';
$fullName = 'Staff User One';
$department = 'Innovation';
$role = 'Staff';
$passwordPlain = 'staff123';
$passwordHash = password_hash($passwordPlain, PASSWORD_BCRYPT, ['cost' => 10]);

$pdo->beginTransaction();
$stmt = $pdo->prepare('SELECT id FROM admin_users WHERE username = ? OR email = ?');
$stmt->execute([$username, $email]);
if ($stmt->fetch()) {
  $pdo->rollBack();
  echo "EXISTS\n";
  exit;
}

$stmt = $pdo->prepare('INSERT INTO admin_users (username, email, password_hash, full_name, role, department, is_active) VALUES (?, ?, ?, ?, ?, ?, 1)');
$stmt->execute([$username, $email, $passwordHash, $fullName, $role, $department]);
$adminId = $pdo->lastInsertId();

$stmt = $pdo->prepare('INSERT INTO staff (id, name, email, role, department, phone, is_active) VALUES (?, ?, ?, ?, ?, ?, 1)');
$stmt->execute([$adminId, $fullName, $email, $role, $department, '']);

$pdo->commit();

echo "CREATED\t" . $username . "\t" . $passwordPlain . "\n";
?>
