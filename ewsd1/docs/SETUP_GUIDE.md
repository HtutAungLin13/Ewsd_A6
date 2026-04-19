# Admin Dashboard - Complete Setup Guide

## 📋 Table of Contents
1. [System Requirements](#system-requirements)
2. [XAMPP Setup](#xampp-setup)
3. [Database Setup](#database-setup)
4. [Backend (PHP) Setup](#backend-php-setup)
5. [Frontend (React) Setup](#frontend-react-setup)
6. [Running the Application](#running-the-application)
7. [Troubleshooting](#troubleshooting)
8. [Security Notes](#security-notes)

---

## 🖥️ System Requirements

### Minimum Requirements
- **Windows 10+** or **macOS 10.15+** or **Linux (Ubuntu 20.04+)**
- **XAMPP 8.0+** (includes PHP 8.0+, Apache, MySQL)
- **Node.js 16+** and **npm 8+**
- **Git** (optional, for version control)

### Recommended
- **XAMPP 8.2+** with PHP 8.2
- **Node.js 18 LTS**
- **VS Code** with extensions: ES7+ React/Redux/React-Native snippets, Tailwind CSS IntelliSense

---

## 🚀 XAMPP Setup

### 1. Install XAMPP
- Download from: https://www.apachefriends.org/
- Run installer (default path: `C:\xampp` on Windows)
- Install Apache, MySQL, PHP, PhpMyAdmin

### 2. Start Services
- Open XAMPP Control Panel
- Start **Apache** and **MySQL** modules
- Verify both show green indicators

### 3. Verify Installation
- Apache: Open http://localhost in browser (should show XAMPP welcome page)
- MySQL: Click "Admin" next to MySQL (opens PhpMyAdmin)

---

## 💾 Database Setup

### 1. Create Database Using PhpMyAdmin
```
1. Go to http://localhost/phpmyadmin
2. Click "New" to create new database
3. Database name: ewsd1
4. Collation: utf8mb4_unicode_ci
5. Click "Create"
```

### 2. Import Database Schema
```
1. Select the ewsd1 database
2. Click "Import" tab
3. Choose file: 01_database_schema.sql
4. Click "Go"
```

### 3. Verify Database
- In PhpMyAdmin, select `admin_system`
- Verify tables exist: admin_users, staff, academic_years, etc.
- Verify sample data is inserted

---

## 🔧 Backend (PHP) Setup

### 1. Create Project Directory
```bash
# Windows
cd C:\xampp\htdocs
mkdir ewsd1
cd ewsd1





## ⚛️ Frontend (React) Setup

### 1. Create React Project with Vite
```bash
# Navigate to xampp htdocs
cd C:\xampp\htdocs\admin-system

# Create React project with Vite
npm create vite@latest frontend -- --template react
cd frontend
```

### 2. Install Dependencies
```bash
# Install npm packages
npm install

# Install additional dependencies
npm install axios zustand react-router-dom
```

```
### 2. Install Tailwind CSS
```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

---

## ▶️ Running the Application

### 1. Start Backend (XAMPP)
```
1. Open XAMPP Control Panel
2. Click "Start" for Apache and MySQL
3. Verify both modules show green status
```

### 2. Start Frontend (React Dev Server)
```bash
cd C:\xampp\htdocs\admin-system\frontend

# Start development server
npm run dev

# Output will show:
# VITE v5.0.0  ready in 123 ms
# ➜  Local:   http://localhost:5173/
```

### 3. Open Application
```
Open browser and go to: http://localhost:5173

Login with:
Staff: staff2 / staff123
Staff: staff1 / staff123
Admin: admin / admin123
qamanager: qamanager/ qa123!@#
qacoordinator: QAc/ qac123!@#
```

---

## 🐛 Troubleshooting

### CORS Error: "Access to XMLHttpRequest has been blocked by CORS policy"

**Solution:**
Ensure your PHP files have CORS headers set:
```php
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
```

### 404 Error: "Cannot POST /api/staff.php"

**Check:**
1. Backend folder path is correct: `C:\xampp\htdocs\ewsd1\api\`
2. API URL in React matches: `http://localhost/ewsd1/api`
3. Apache is running

### Database Connection Error

**Check:**
1. MySQL is running (green in XAMPP)
2. Database name is `ewsd1`
3. Username is `root` with empty password
4. Database schema is imported

### "Token required or expired" Error

**Solution:**
1. Clear browser localStorage: F12 → Storage → Local Storage → Clear
2. Login again
3. Ensure token is being stored properly

### Module Not Found Errors

```bash
# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Port 5173 Already in Use

```bash
# Use different port
npm run dev -- --port 5174
```

---

## 🔒 Security Notes

### ⚠️ Important for Production

1. **Change Secret Key** in `api/auth.php`:
   ```php
   private $secret_key = 'your-secret-key-change-this-in-production';
   ```

2. **Change Database Password**:
   ```php
   private $user = 'root';
   private $pass = 'strong-password'; // Update from empty
   ```

3. **Update CORS Origin**:
   ```php
   // Instead of localhost:5173, use your production domain
   header("Access-Control-Allow-Origin: https://yourdomain.com");
   ```

4. **Use HTTPS** for production deployment

5. **Validate All Inputs** - Current code includes PDO prepared statements (safe from SQL injection)

6. **Rate Limiting** - Consider implementing rate limiting for login endpoint

7. **Environment Variables** - Use `.env` file for sensitive data:
   ```
   DB_HOST=localhost
   DB_NAME=ewsd1
   DB_USER=root
   DB_PASS=password
   SECRET_KEY=your-secret-key
   ```

---

**Last Updated**: March 2026
**Version**: 1.0.0
