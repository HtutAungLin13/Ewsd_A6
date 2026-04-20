-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2026 at 03:52 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ewsd1`
--

-- --------------------------------------------------------

--
-- Table structure for table `academic_years`
--

CREATE TABLE `academic_years` (
  `id` int(11) NOT NULL,
  `year_label` varchar(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `academic_years`
--

INSERT INTO `academic_years` (`id`, `year_label`, `start_date`, `end_date`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '2024-2025', '2024-09-01', '2025-08-31', 0, '2026-03-17 12:28:14', '2026-04-19 03:41:18'),
(2, '2025-2026', '2025-09-01', '2026-08-31', 1, '2026-03-17 12:28:14', '2026-04-19 03:41:14');

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `role` enum('Admin','QAManager','QACoordinator','Staff') DEFAULT 'Admin',
  `department` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `username`, `email`, `password_hash`, `full_name`, `role`, `department`, `is_active`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@ewsd.local', '$2y$10$2oynwjICRS53CIp.tBWMI.nhF.NhCL1xNdqeH4bwYRhRvO78s/ar6', 'System Admin', 'Admin', 'Administration', 1, '2026-04-20 08:52:18', '2026-03-20 10:41:31', '2026-04-20 08:52:18'),
(6, 'staff1', 'staff1@example.com', '$2y$10$mTw4BtoCgoyFCzU7wbU1POboes9U9VVCcwbaADWAAbGs346P3PMPS', 'Test Staff', 'Staff', 'Innovation', 1, '2026-04-19 07:13:11', '2026-03-20 10:41:31', '2026-04-19 07:13:11'),
(9, 'staff2', 'staff2@example.com', '$2y$10$GbafrNeX1FlkAyoj94vHYuxO6r6ipFZ3lBzTXFtP8AaNI9uau7VKO', 'Staff User Two', 'Staff', 'Innovation', 1, '2026-04-19 07:02:09', '2026-03-20 10:41:31', '2026-04-19 07:02:09'),
(12, 'QAc', '13halhtutalin@gmail.com', '$2y$10$8Ox92kYtKENDxH2M90aV3Od12bXmhWSCh6WAxVHRXdqEWdBJEa.oq', 'h', 'QACoordinator', 'innovation', 1, '2026-04-20 08:54:38', '2026-03-24 09:42:05', '2026-04-20 08:54:38'),
(13, 'AHO', 'andyoo553@gmail.com', '$2y$10$.lO7dz1xgSXf5EJ2lGnyQeWUMMsYQuJupHXoDYT4AeUGQY7rEQ26a', 'AHO', 'Staff', 'Innovation', 1, '2026-03-24 10:08:17', '2026-03-24 10:01:36', '2026-03-24 10:08:17'),
(14, 'qamanager1', 'manager@ewsd.local', '$2y$10$pxVDOtClLqPLzghUFDrdHe6Hw9/XEaPySDUHWAOtvwsteoB4G0kQS', 'QAm', 'QAManager', 'lab', 1, '2026-04-20 08:54:04', '2026-03-24 10:14:53', '2026-04-20 08:54:04'),
(15, 'staff3', 'staff3@gmail.com', '$2y$10$SI/QzVwZw8yL3p57uI5iaOL4uWf2ZDSk1Q6kKd.YN/d0zKxbZxekC', 'aaa', 'Staff', 'Administration', 1, '2026-04-19 07:23:31', '2026-03-25 09:24:51', '2026-04-19 07:23:31'),
(16, 'staff4', 'staff4@gmail.com', '$2y$10$IYZRqf.jlP/49WnOuh1cWeiFNmUd8WoaZ7yVE.7f/297RCLEQY.Ji', 'bbb', 'Staff', 'Marketing', 1, '2026-04-19 07:27:49', '2026-03-25 09:28:17', '2026-04-19 07:27:49'),
(17, 'Leon', 'leyonhal5@gmail.com', '$2y$10$ZNw/rBPcG16chRzCYwGjtuGnZc/BWkFglBo.dal7FxVmimfI7oEvi', 'Leon', 'Staff', 'Innovation', 1, '2026-04-20 08:53:17', '2026-04-19 06:53:29', '2026-04-20 08:53:17'),
(18, 'IMSAdmin01', 'imsadmin01@ewsd.local', '$2y$10$LMVDvniobTinxJQZOyTDM.1DAgE8p8WrrWNY5OC/GBybN.aofLu6y', 'IMS Admin 01', 'Admin', 'Administration', 1, '2026-04-20 13:30:29', '2026-04-20 13:28:42', '2026-04-20 13:30:29'),
(19, 'IMSQAManager01', 'imsqamanager01@ewsd.local', '$2y$10$hj4paMMMDFpLVPW/OhbRduuZg5.8RmcWMUIsaTup7oPi9t051y6YW', 'QA Manager', 'QAManager', 'IMS', 1, '2026-04-20 13:37:06', '2026-04-20 13:34:37', '2026-04-20 13:37:06'),
(20, 'IMSQACoordinator01', 'imsqacoordinator01@ewsd.local', '$2y$10$NIghfq.LHmYJhv8BRBc1YOlQzea6XCT9rkB1QYE5udF2lAaBp/h3C', 'QA Coordinator', 'QACoordinator', 'IMS', 1, '2026-04-20 13:37:22', '2026-04-20 13:34:37', '2026-04-20 13:37:22'),
(21, 'IMStaff01', 'imstaff01@ewsd.local', '$2y$10$ykwOaaJUu/utW2es7Y9QUuURlXLkcajl/b4vsrHS.RGLt.tKiGLsy', 'IMS Staff 01', 'Staff', 'IMS', 1, '2026-04-20 13:39:55', '2026-04-20 13:39:25', '2026-04-20 13:39:55'),
(22, 'IMStaff02', 'imstaff02@ewsd.local', '$2y$10$VC9yQYIFRJBIItRzqry60ea9zXLIe7r8bs9m572ApkX.Zgd/QEjTu', 'IMS Staff 02', 'Staff', 'IMS', 1, '2026-04-20 13:47:35', '2026-04-20 13:39:25', '2026-04-20 13:47:35');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `changes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`changes`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `admin_id`, `action`, `table_name`, `record_id`, `changes`, `ip_address`, `created_at`) VALUES
(1, 1, 'ADMIN_CREATE_USER', 'admin_users', 10, '{\"email\":\"13halhtutalin@gmail.com\",\"role\":\"QAManager\",\"department\":\".\"}', '::1', '2026-03-21 04:12:54'),
(2, 1, 'ADMIN_CREATE_USER', 'admin_users', 11, '{\"email\":\"lyon123@gmail.com\",\"role\":\"QACoordinator\",\"department\":\"Tech\"}', '::1', '2026-03-21 05:17:37'),
(3, 1, 'ADMIN_UPDATE_NOTIFICATION_SETTING', 'notification_settings', NULL, '{\"notification_key\":\"reply_added\",\"is_enabled\":0}', '::1', '2026-03-21 05:35:55'),
(4, 1, 'ADMIN_UPDATE_NOTIFICATION_SETTING', 'notification_settings', NULL, '{\"notification_key\":\"reply_added\",\"is_enabled\":1}', '::1', '2026-03-21 05:35:57'),
(5, 1, 'ADMIN_CREATE_BACKUP', 'system_backups', 1, '{\"scope\":[\"users\",\"departments\",\"settings\",\"categories\",\"notifications\",\"security\"]}', '::1', '2026-03-22 05:03:41'),
(6, 1, 'ADMIN_DELETE_USER', 'admin_users', 10, '{\"mode\":\"delete\"}', '::1', '2026-03-24 09:39:11'),
(7, 1, 'ADMIN_CREATE_USER', 'admin_users', 12, '{\"email\":\"13halhtutalin@gmail.com\",\"role\":\"QACoordinator\",\"department\":\"innovation\"}', '::1', '2026-03-24 09:42:05'),
(8, 1, 'ADMIN_DELETE_USER', 'admin_users', 11, '{\"mode\":\"delete\"}', '::1', '2026-03-24 09:47:55'),
(9, 1, 'ADMIN_RESET_PASSWORD', 'admin_users', 12, NULL, '::1', '2026-03-24 09:48:02'),
(10, 1, 'ADMIN_UPDATE_USER', 'admin_users', 12, '{\"user_id\":12,\"full_name\":\"h\",\"email\":\"13halhtutalin@gmail.com\",\"username\":\"QAc\",\"department\":\"innovation\",\"role\":\"QACoordinator\",\"is_active\":1,\"password\":\"\"}', '::1', '2026-03-24 09:48:41'),
(11, 1, 'ADMIN_CREATE_USER', 'admin_users', 13, '{\"email\":\"andyoo553@gmail.com\",\"role\":\"Staff\",\"department\":\"Innovation\"}', '::1', '2026-03-24 10:01:36'),
(12, 1, 'ADMIN_CREATE_USER', 'admin_users', 14, '{\"email\":\"manager@ewsd.local\",\"role\":\"QAManager\",\"department\":\".\"}', '::1', '2026-03-24 10:14:53'),
(13, 1, 'ADMIN_CREATE_USER', 'admin_users', 15, '{\"email\":\"staff3@gmail.com\",\"role\":\"Staff\",\"department\":\"Social Impact\"}', '::1', '2026-03-25 09:24:52'),
(14, 1, 'ADMIN_UPDATE_USER', 'admin_users', 15, '{\"user_id\":15,\"full_name\":\"aaa\",\"email\":\"staff3@gmail.com\",\"username\":\"staff3\",\"department\":\"Administration\",\"role\":\"Staff\",\"is_active\":1,\"password\":\"\"}', '::1', '2026-03-25 09:27:36'),
(15, 1, 'ADMIN_CREATE_USER', 'admin_users', 16, '{\"email\":\"staff4@gmail.com\",\"role\":\"Staff\",\"department\":\"Marketing\"}', '::1', '2026-03-25 09:28:17'),
(16, 1, 'ADMIN_CATEGORY_BACKUP', 'category_backups', 2, '{\"count\":5}', '::1', '2026-03-30 12:57:47'),
(17, 1, 'ADMIN_REVEAL_AUTHOR', 'idea', 7, NULL, '::1', '2026-03-30 13:00:12'),
(18, 1, 'ADMIN_UPDATE_DEPARTMENT', 'departments', 421, '{\"department_id\":421,\"name\":\"lab\",\"qa_coordinator_id\":0,\"is_active\":1}', '::1', '2026-04-19 03:40:09'),
(19, 1, 'ADMIN_REVEAL_AUTHOR', 'idea', 7, NULL, '::1', '2026-04-19 05:36:04'),
(20, 1, 'ADMIN_REVEAL_AUTHOR', 'idea', 7, NULL, '::1', '2026-04-19 05:54:00'),
(21, 1, 'ADMIN_REVEAL_AUTHOR', 'idea', 7, NULL, '::1', '2026-04-19 05:54:27'),
(22, 1, 'ADMIN_CREATE_USER', 'admin_users', 17, '{\"email\":\"leyonhal5@gmail.com\",\"role\":\"Staff\",\"department\":\"Innovation\"}', '::1', '2026-04-19 06:53:29'),
(23, 1, 'ADMIN_UPDATE_DEPARTMENT', 'departments', 2, '{\"department_id\":2,\"name\":\"Innovation\",\"qa_coordinator_id\":12,\"is_active\":1}', '::1', '2026-04-19 07:37:23'),
(24, 1, 'ADMIN_REVEAL_AUTHOR', 'idea', 32, NULL, '::1', '2026-04-19 08:14:34'),
(25, 1, 'ADMIN_REVEAL_AUTHOR', 'idea', 26, NULL, '::1', '2026-04-19 08:14:38');

-- --------------------------------------------------------

--
-- Table structure for table `category_backups`
--

CREATE TABLE `category_backups` (
  `id` int(11) NOT NULL,
  `backup_name` varchar(255) NOT NULL,
  `category_snapshot` longtext NOT NULL,
  `backup_note` varchar(255) DEFAULT NULL,
  `created_by_admin_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category_backups`
--

INSERT INTO `category_backups` (`id`, `backup_name`, `category_snapshot`, `backup_note`, `created_by_admin_id`, `created_at`) VALUES
(1, 'Quarterly Category Backup', '[{\"id\":1,\"name\":\"Technology\",\"description\":\"Technology and innovation ideas\",\"is_active\":1},{\"id\":2,\"name\":\"Social Impact\",\"description\":\"Ideas for social good\",\"is_active\":1},{\"id\":3,\"name\":\"Sustainability\",\"description\":\"Environmental and sustainability initiatives\",\"is_active\":1},{\"id\":4,\"name\":\"Business\",\"description\":\"Business and entrepreneurship ideas\",\"is_active\":1},{\"id\":6,\"name\":\"Test\",\"description\":\"Test\",\"is_active\":1}]', 'Initial seeded backup for dashboard testing', 1, '2026-03-22 01:30:00'),
(2, 'Category Backup 2026-03-30 14:57:47', '[{\"id\":1,\"name\":\"Technology\",\"description\":\"Technology and innovation ideas\",\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":2,\"name\":\"Social Impact\",\"description\":\"Ideas for social good\",\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":3,\"name\":\"Sustainability\",\"description\":\"Environmental and sustainability initiatives\",\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":4,\"name\":\"Business\",\"description\":\"Business and entrepreneurship ideas\",\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":6,\"name\":\"Test\",\"description\":\"Test\",\"is_active\":1,\"created_at\":\"2026-03-22 13:02:13\",\"updated_at\":\"2026-03-22 13:02:13\"}]', '', 1, '2026-03-30 12:57:47');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `idea_id` int(11) NOT NULL,
  `contributor_id` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `is_anonymous` tinyint(1) DEFAULT 0,
  `is_inappropriate` tinyint(1) DEFAULT 0,
  `inappropriate_reason` text DEFAULT NULL,
  `flagged_by_admin_id` int(11) DEFAULT NULL,
  `flagged_at` timestamp NULL DEFAULT NULL,
  `like_count` int(11) DEFAULT 0,
  `is_deleted` tinyint(1) DEFAULT 0,
  `deleted_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `idea_id`, `contributor_id`, `content`, `is_anonymous`, `is_inappropriate`, `inappropriate_reason`, `flagged_by_admin_id`, `flagged_at`, `like_count`, `is_deleted`, `deleted_by`, `deleted_at`, `deleted_reason`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Great idea! This would save us a lot of time.', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2024-02-01 05:00:00', '2026-03-18 08:20:10'),
(2, 1, 3, 'How much will this cost to implement?', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2024-02-02 03:30:00', '2026-03-18 08:20:10'),
(3, 2, 1, 'I agree, we need better testing practices.', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2024-02-06 08:00:00', '2026-03-18 08:20:10'),
(4, 3, 2, 'Excellent initiative! Count me in.', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2024-02-12 04:00:00', '2026-03-18 08:20:10'),
(5, 4, 1, 'This could really improve our feedback process.', 1, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2024-02-13 02:30:00', '2026-03-18 08:20:10'),
(6, 9, 13, '333', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-03-21 09:06:35', '2026-03-21 09:06:35'),
(7, 10, 13, 'test', 0, 0, NULL, NULL, NULL, 0, 1, 14, '2026-03-25 11:32:31', 'Inappropriate content', '2026-03-22 05:58:29', '2026-03-25 11:32:31'),
(8, 11, 13, 'test111', 0, 0, NULL, NULL, NULL, 0, 1, 12, '2026-03-25 10:27:07', 'Inappropriate content', '2026-03-22 06:05:09', '2026-03-25 10:27:07'),
(9, 12, 13, 'test', 1, 0, NULL, NULL, NULL, 0, 1, 14, '2026-03-25 10:41:26', 'Inappropriate content', '2026-03-22 13:53:04', '2026-03-25 10:41:26'),
(10, 14, 15, 'test2', 0, 1, 'Inappropriate content', 12, '2026-03-25 10:21:24', 0, 1, 12, '2026-03-25 10:27:29', 'Inappropriate content', '2026-03-24 10:10:56', '2026-03-25 10:27:29'),
(11, 25, 6, 'Recommends videos, readings, and quizzes tailored to individual learning styles (visual, auditory, kinesthetic)', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:09:58', '2026-04-19 07:09:58'),
(12, 26, 6, 'real-time progress, performance trends, and areas needing improvement', 1, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:10:40', '2026-04-19 07:10:40'),
(13, 20, 6, 'Identifies at-risk students and sends alerts to both students and instructors.', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:11:49', '2026-04-19 07:11:49'),
(14, 19, 6, 'improve student engagement, reduce dropout rates, and enhance overall academic performance', 1, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:12:29', '2026-04-19 07:12:29'),
(15, 28, 14, 'matches students with internships and job opportunities', 1, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:16:49', '2026-04-19 07:16:49'),
(16, 26, 14, 'Smart Content Suggestions', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:17:20', '2026-04-19 07:17:20'),
(17, 22, 14, 'dentifies at-risk students', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:17:49', '2026-04-19 07:17:49'),
(18, 29, 14, 'real-time progress, performance trends, and areas needing improvement', 1, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:20:17', '2026-04-19 07:20:17'),
(19, 30, 19, 'Offer short online courses with certifications in digital skills such as coding', 1, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:26:34', '2026-04-19 07:26:34'),
(20, 29, 20, 'analyze students’ learning behavior, performance, and engagement', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:27:20', '2026-04-19 07:27:20'),
(21, 19, 25, 'may create a hostile environment and violate community guidelines', 1, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 07:34:27', '2026-04-19 07:34:27'),
(22, 20, 15, 'reply', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 08:38:04', '2026-04-19 08:38:04'),
(23, 36, 15, 'This is a well-thought-out initiative that addresses a real need among students. Introducing a “Recharge Week” could have a positive impact on reducing stress and improving overall wellbeing. Before moving forward, we may need to assess how this will affect the academic calendar and ensure alignment across all departments.', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-04-19 15:05:26', '2026-04-19 15:05:26');

--
-- Triggers `comments`
--
DELIMITER $$
CREATE TRIGGER `tr_update_comment_response_on_insert` AFTER INSERT ON `comments` FOR EACH ROW BEGIN
  -- add tracking row for the new comment itself
  INSERT INTO comment_response_tracking
    (comment_id, idea_id, comment_author_id, comment_author_name, comment_author_email, has_responses, response_count, created_at, updated_at)
  SELECT
    NEW.id, NEW.idea_id, NEW.contributor_id, c.name, c.email, 0, 0, NOW(), NOW()
  FROM contributors c
  WHERE c.id = NEW.contributor_id
  ON DUPLICATE KEY UPDATE
    updated_at = NOW();

  -- this new comment is a response to previous comments on the same idea by other authors
  UPDATE comment_response_tracking
  SET response_count = response_count + 1,
      last_response_date = NOW(),
      has_responses = 1,
      updated_at = NOW()
  WHERE idea_id = NEW.idea_id
    AND comment_id <> NEW.id
    AND comment_author_id <> NEW.contributor_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `comment_replies`
--

CREATE TABLE `comment_replies` (
  `id` int(11) NOT NULL,
  `parent_comment_id` int(11) NOT NULL,
  `idea_id` int(11) NOT NULL,
  `contributor_id` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `mentioned_staff_id` int(11) DEFAULT NULL,
  `is_anonymous` tinyint(1) DEFAULT 0,
  `is_inappropriate` tinyint(1) DEFAULT 0,
  `inappropriate_reason` text DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comment_replies`
--

INSERT INTO `comment_replies` (`id`, `parent_comment_id`, `idea_id`, `contributor_id`, `content`, `mentioned_staff_id`, `is_anonymous`, `is_inappropriate`, `inappropriate_reason`, `is_deleted`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 'Good question. We can start with a pilot and measure impact before full rollout.', 1, 0, 0, NULL, 0, NULL, '2026-03-22 01:45:00', NULL),
(2, 2, 1, 1, 'I can help draft the implementation checklist and timeline this week.', 2, 0, 0, NULL, 0, NULL, '2026-03-22 02:00:00', NULL),
(3, 3, 2, 3, 'Let\'s include training materials so teams can adopt it consistently.', NULL, 1, 0, NULL, 0, NULL, '2026-03-22 02:20:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comment_response_tracking`
--

CREATE TABLE `comment_response_tracking` (
  `id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `idea_id` int(11) NOT NULL,
  `comment_author_id` int(11) NOT NULL,
  `comment_author_name` varchar(100) DEFAULT NULL,
  `comment_author_email` varchar(100) DEFAULT NULL,
  `has_responses` int(11) DEFAULT 0,
  `last_response_date` timestamp NULL DEFAULT NULL,
  `response_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comment_response_tracking`
--

INSERT INTO `comment_response_tracking` (`id`, `comment_id`, `idea_id`, `comment_author_id`, `comment_author_name`, `comment_author_email`, `has_responses`, `last_response_date`, `response_count`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 'Jane Smith', 'jane.smith@example.com', 1, NULL, 1, '2026-03-18 09:42:12', NULL),
(2, 3, 2, 3, 'Bob Johnson', 'bob.johnson@example.com', 0, NULL, 0, '2026-03-18 09:42:12', NULL),
(3, 5, 4, 1, 'John Doe', 'john.doe@example.com', 0, NULL, 0, '2026-03-18 09:42:12', NULL),
(4, 6, 9, 13, 'Leyon', 'lyon123@gmail.com', 0, NULL, 0, '2026-03-21 09:06:35', '2026-03-21 09:06:35'),
(5, 7, 10, 13, 'Leyon', 'lyon123@gmail.com', 0, NULL, 0, '2026-03-22 05:58:29', '2026-03-22 05:58:29'),
(6, 8, 11, 13, 'Leyon', 'lyon123@gmail.com', 0, NULL, 0, '2026-03-22 06:05:09', '2026-03-22 06:05:09'),
(7, 9, 12, 13, 'Leyon', 'lyon123@gmail.com', 0, NULL, 0, '2026-03-22 13:53:04', '2026-03-22 13:53:04'),
(8, 10, 14, 15, 'h', '13halhtutalin@gmail.com', 0, NULL, 0, '2026-03-24 10:10:56', '2026-03-24 10:10:56'),
(9, 11, 25, 6, 'Staff User Two', 'staff2@example.com', 0, NULL, 0, '2026-04-19 07:09:58', '2026-04-19 07:09:58'),
(10, 12, 26, 6, 'Staff User Two', 'staff2@example.com', 1, '2026-04-19 07:17:20', 1, '2026-04-19 07:10:40', '2026-04-19 07:17:20'),
(11, 13, 20, 6, 'Staff User Two', 'staff2@example.com', 1, '2026-04-19 08:38:04', 1, '2026-04-19 07:11:49', '2026-04-19 08:38:04'),
(12, 14, 19, 6, 'Staff User Two', 'staff2@example.com', 1, '2026-04-19 07:34:27', 1, '2026-04-19 07:12:29', '2026-04-19 07:34:27'),
(13, 15, 28, 14, 'Test Staff', 'staff1@example.com', 0, NULL, 0, '2026-04-19 07:16:49', '2026-04-19 07:16:49'),
(14, 16, 26, 14, 'Test Staff', 'staff1@example.com', 0, NULL, 0, '2026-04-19 07:17:20', '2026-04-19 07:17:20'),
(15, 17, 22, 14, 'Test Staff', 'staff1@example.com', 0, NULL, 0, '2026-04-19 07:17:49', '2026-04-19 07:17:49'),
(16, 18, 29, 14, 'Test Staff', 'staff1@example.com', 1, '2026-04-19 07:27:20', 1, '2026-04-19 07:20:17', '2026-04-19 07:27:20'),
(17, 19, 30, 19, NULL, NULL, 0, NULL, 0, '2026-04-19 07:26:34', '2026-04-19 07:26:34'),
(18, 20, 29, 20, NULL, NULL, 0, NULL, 0, '2026-04-19 07:27:20', '2026-04-19 07:27:20'),
(19, 21, 19, 25, NULL, NULL, 0, NULL, 0, '2026-04-19 07:34:27', '2026-04-19 07:34:27'),
(20, 22, 20, 15, 'h', '13halhtutalin@gmail.com', 0, NULL, 0, '2026-04-19 08:38:04', '2026-04-19 08:38:04'),
(21, 23, 36, 15, 'h', '13halhtutalin@gmail.com', 0, NULL, 0, '2026-04-19 15:05:26', '2026-04-19 15:05:26');

-- --------------------------------------------------------

--
-- Table structure for table `contributors`
--

CREATE TABLE `contributors` (
  `id` int(11) NOT NULL,
  `user_uuid` varchar(36) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `is_anonymous` tinyint(1) DEFAULT 0,
  `account_status` enum('Active','Disabled','Blocked') DEFAULT 'Active',
  `disabled_reason` text DEFAULT NULL,
  `disabled_by_admin_id` int(11) DEFAULT NULL,
  `disabled_at` timestamp NULL DEFAULT NULL,
  `re_enabled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contributors`
--

INSERT INTO `contributors` (`id`, `user_uuid`, `name`, `email`, `department`, `is_anonymous`, `account_status`, `disabled_reason`, `disabled_by_admin_id`, `disabled_at`, `re_enabled_at`, `created_at`, `updated_at`) VALUES
(1, '47a5cb9c-22a3-11f1-8e40-b07b2567aa8e', 'John Doe', 'john.doe@example.com', 'Technology', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10'),
(2, '47a5da15-22a3-11f1-8e40-b07b2567aa8e', 'Jane Smith', 'jane.smith@example.com', 'Innovation', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10'),
(3, '47a5dbf7-22a3-11f1-8e40-b07b2567aa8e', 'Bob Johnson', 'bob.johnson@example.com', 'Operations', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10'),
(4, '47a5dcaf-22a3-11f1-8e40-b07b2567aa8e', 'Alice Brown', NULL, NULL, 1, 'Active', NULL, NULL, NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10'),
(5, '47a5dd5b-22a3-11f1-8e40-b07b2567aa8e', 'Charlie White', 'charlie.white@example.com', 'Marketing', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10'),
(6, '', 'Staff User Two', 'staff2@example.com', 'Innovation', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-20 08:16:31', '2026-03-20 08:16:31'),
(13, '34e891d16c119b880c4536490b14ea2c', 'Leyon', 'lyon123@gmail.com', 'Tech', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-21 05:18:24', '2026-03-21 05:18:24'),
(14, '8a363037-e7c8-416d-ba99-2353a32ada9c', 'Test Staff', 'staff1@example.com', 'Innovation', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-21 05:24:39', '2026-03-21 05:24:39'),
(15, '797046646afdad1004b85945a9b552dc', 'h', '13halhtutalin@gmail.com', 'innovation', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-24 09:55:11', '2026-03-24 09:55:11'),
(16, '34a0564b-b260-40c3-b611-06201afc02f6', 'AHO', 'andyoo553@gmail.com', 'Innovation', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-24 10:08:41', '2026-03-24 10:08:41'),
(17, '39657c7e-7e75-4191-aa38-b25191ef8766', 'aaa', 'staff3@gmail.com', 'Administration', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-25 10:15:47', '2026-03-25 10:15:47'),
(18, '36de729c-2563-4aa3-9cd6-73f32b33eaea', 'Leon', 'leyonhal5@gmail.com', 'Innovation', 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 06:56:09', '2026-04-19 06:56:09'),
(19, 'be3b8a29-2db9-460a-9bd2-b9ca563e1f2a', NULL, NULL, NULL, 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 07:26:34', '2026-04-19 07:26:34'),
(20, '4909e2a4-57ba-4dd1-9002-607cafc4b69c', NULL, NULL, NULL, 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 07:27:20', '2026-04-19 07:27:20'),
(21, '92947725-06c1-48f0-bd5a-9ac67ebde561', 'bbb', 'staff4@gmail.com', 'Marketing', 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 07:27:53', '2026-04-19 07:27:53'),
(22, 'cd353e28-e43b-4ae9-8ffe-d8ddf3d652f8', NULL, NULL, NULL, 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 07:29:24', '2026-04-19 07:29:24'),
(23, 'cadd3f06-9dc3-4e6b-8f73-06ecd6a95e1a', NULL, NULL, NULL, 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 07:31:23', '2026-04-19 07:31:23'),
(24, '8eda6458-026a-48e0-b95c-07f60d336d49', NULL, NULL, NULL, 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 07:33:47', '2026-04-19 07:33:47'),
(25, 'c4db83eb-2f82-4564-9093-5a9582907f96', NULL, NULL, NULL, 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 07:34:27', '2026-04-19 07:34:27'),
(26, '43fb42e4-c8e9-47b0-8adb-f27f322817d4', NULL, NULL, NULL, 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 07:35:18', '2026-04-19 07:35:18'),
(27, 'b092c13e-8a1e-41b2-867f-55547e7d91d3', 'Innovation Staff 10', 'innovation10@example.com', 'Innovation', 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-19 14:52:20', '2026-04-19 14:52:20'),
(28, 'b380c4c0092c722d23f215411c5b896b', 'QA Coordinator', 'imsqacoordinator01@ewsd.local', 'IMS', 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-20 13:37:22', '2026-04-20 13:37:22'),
(29, '4ea08aa3-97b9-42ed-8d98-5beab18c725c', 'IMS Staff 01', 'imstaff01@ewsd.local', 'IMS', 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-20 13:41:39', '2026-04-20 13:41:39'),
(30, 'e54ab0f1-3654-4358-8833-f04267d93122', 'IMS Staff 02', 'imstaff02@ewsd.local', 'IMS', 0, 'Active', NULL, NULL, NULL, NULL, '2026-04-20 13:47:54', '2026-04-20 13:47:54');

-- --------------------------------------------------------

--
-- Table structure for table `contributor_account_history`
--

CREATE TABLE `contributor_account_history` (
  `id` int(11) NOT NULL,
  `contributor_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action` enum('Disabled','Re-enabled','Blocked','Unblocked') NOT NULL,
  `reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contributor_account_history`
--

INSERT INTO `contributor_account_history` (`id`, `contributor_id`, `admin_id`, `action`, `reason`, `created_at`) VALUES
(1, 4, 1, 'Disabled', 'Repeated off-topic submissions in one session', '2026-02-10 03:30:00'),
(2, 4, 1, 'Re-enabled', 'Issue resolved after policy reminder', '2026-02-15 02:15:00'),
(3, 5, 1, 'Blocked', 'Multiple reports of inappropriate language', '2026-03-05 07:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `coordinator_content_reports`
--

CREATE TABLE `coordinator_content_reports` (
  `id` int(11) NOT NULL,
  `coordinator_id` int(11) NOT NULL,
  `content_type` enum('Idea','Comment') NOT NULL,
  `content_id` int(11) NOT NULL,
  `report_reason` varchar(255) NOT NULL,
  `report_category` enum('Swearing','Libel','Defamation','Harassment','Offensive','Other') NOT NULL,
  `description` text DEFAULT NULL,
  `severity` enum('Low','Medium','High','Critical') DEFAULT 'Medium',
  `status` enum('Reported','Under_Review','Flagged','Dismissed') DEFAULT 'Reported',
  `escalated_to_admin` tinyint(1) DEFAULT 0,
  `escalated_at` timestamp NULL DEFAULT NULL,
  `reported_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolved_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coordinator_content_reports`
--

INSERT INTO `coordinator_content_reports` (`id`, `coordinator_id`, `content_type`, `content_id`, `report_reason`, `report_category`, `description`, `severity`, `status`, `escalated_to_admin`, `escalated_at`, `reported_at`, `resolved_at`) VALUES
(8, 12, 'Idea', 1023, 'Contains inappropriate language', 'Swearing', 'The submitted idea includes multiple offensive words directed at university staff, which violates the platform’s communication guidelines and creates an uncomfortable environment for reviewers.', 'Medium', 'Reported', 0, NULL, '2026-04-19 03:54:25', NULL),
(9, 12, 'Idea', 1023, 'Contains inappropriate language', 'Swearing', 'The submitted idea includes multiple offensive words directed at university staff, which violates the platform’s communication guidelines and creates an uncomfortable environment for reviewers.', 'Medium', 'Reported', 0, NULL, '2026-04-19 03:54:27', NULL),
(10, 12, 'Comment', 2045, 'Targeting another user', 'Harassment', 'The comment attacks another user personally, using insulting language and discouraging them from sharing ideas. This behavior is not acceptable in a collaborative academic environment.', 'High', 'Reported', 0, NULL, '2026-04-19 03:55:29', NULL),
(11, 12, 'Idea', 1187, 'Irrelevant promotional content', 'Offensive', 'The idea submission is unrelated to university improvement and instead promotes an external product/service with repeated links, indicating spam behavior.', 'Low', 'Reported', 0, NULL, '2026-04-19 03:56:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `coordinator_reminders`
--

CREATE TABLE `coordinator_reminders` (
  `id` int(11) NOT NULL,
  `coordinator_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `department` varchar(100) NOT NULL,
  `reminder_type` enum('Invitation','Reminder','Final_Call') NOT NULL,
  `recipients_count` int(11) DEFAULT 0,
  `message` text DEFAULT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `qa_coordinator_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `qa_coordinator_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Administration', NULL, 1, '2026-03-21 04:08:22', '2026-03-21 04:08:22'),
(2, 'Innovation', 12, 1, '2026-03-21 04:08:22', '2026-04-19 07:37:23'),
(4, 'Operations', NULL, 1, '2026-03-21 04:08:22', '2026-03-21 04:08:22'),
(7, 'Marketing', NULL, 1, '2026-03-21 04:08:22', '2026-03-21 04:08:22'),
(9, 'Technology', NULL, 1, '2026-03-21 04:08:22', '2026-03-21 04:08:22'),
(421, 'lab', NULL, 1, '2026-03-21 04:12:54', '2026-04-19 03:40:09'),
(526, 'Tech', NULL, 1, '2026-03-21 05:17:37', '2026-03-21 05:17:37'),
(4531, 'Testing Team', NULL, 1, '2026-03-22 06:02:26', '2026-04-19 03:49:07'),
(8364, 'Social Impact', NULL, 1, '2026-03-25 09:24:51', '2026-03-25 09:24:51'),
(20904, 'IMS', 20, 1, '2026-04-20 13:34:37', '2026-04-20 13:34:37');

-- --------------------------------------------------------

--
-- Table structure for table `department_performance_stats`
--

CREATE TABLE `department_performance_stats` (
  `id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `department` varchar(100) NOT NULL,
  `total_staff` int(11) DEFAULT 0,
  `staff_submitted` int(11) DEFAULT 0,
  `staff_not_submitted` int(11) DEFAULT 0,
  `total_ideas` int(11) DEFAULT 0,
  `total_comments` int(11) DEFAULT 0,
  `unanswered_comments` int(11) DEFAULT 0,
  `total_reports` int(11) DEFAULT 0,
  `approval_rate` decimal(5,2) DEFAULT 0.00,
  `engagement_rate` decimal(5,2) DEFAULT 0.00,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department_performance_stats`
--

INSERT INTO `department_performance_stats` (`id`, `session_id`, `department`, `total_staff`, `staff_submitted`, `staff_not_submitted`, `total_ideas`, `total_comments`, `unanswered_comments`, `total_reports`, `approval_rate`, `engagement_rate`, `last_updated`) VALUES
(1, 1, 'Technology', 3, 2, 1, 2, 3, 1, 1, 100.00, 96.67, '2026-03-22 02:30:00'),
(2, 2, 'Operations', 1, 1, 0, 1, 1, 0, 0, 100.00, 100.00, '2026-03-22 02:30:00'),
(3, 2, 'Innovation', 4, 1, 3, 1, 1, 0, 0, 100.00, 32.50, '2026-03-22 02:30:00'),
(4, 3, 'Technology', 3, 1, 2, 1, 0, 0, 0, 100.00, 33.33, '2026-03-22 02:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `email_notifications`
--

CREATE TABLE `email_notifications` (
  `id` int(11) NOT NULL,
  `recipient_email` varchar(100) NOT NULL,
  `recipient_type` enum('Coordinator','Staff') NOT NULL,
  `notification_type` enum('Idea_Submitted','Comment_Added','Session_Open','Session_Closing','Invitation_Sent') NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `idea_id` int(11) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL,
  `status` enum('Sent','Bounced','Failed') DEFAULT 'Sent'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_notifications`
--

INSERT INTO `email_notifications` (`id`, `recipient_email`, `recipient_type`, `notification_type`, `subject`, `message`, `idea_id`, `comment_id`, `session_id`, `sent_at`, `read_at`, `status`) VALUES
(1, 'coordinator.tech@example.com', 'Coordinator', 'Idea_Submitted', 'New Idea Submitted in Tech Ideas 2024', 'John Doe has submitted a new idea: AI-Powered Analytics Dashboard', 1, NULL, 1, '2026-03-18 09:40:58', NULL, 'Sent'),
(2, 'coordinator.innovation@example.com', 'Coordinator', 'Comment_Added', 'New Comment on Social Impact Idea', 'Jane Smith commented on your submission', 2, NULL, 2, '2026-03-18 09:40:58', NULL, 'Sent'),
(3, '13halhtutalin@gmail.com', '', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'A new anonymous idea was submitted in Innovation: testing2', 7, NULL, 4, '2026-03-21 00:50:02', NULL, 'Failed'),
(4, 'lyon123@gmail.com', 'Coordinator', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'A new anonymous idea was submitted in Innovation: testing3', 8, NULL, 4, '2026-03-21 00:58:09', NULL, 'Failed'),
(5, '13halhtutalin@gmail.com', '', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'A new anonymous idea was submitted in Innovation: testing3', 8, NULL, 4, '2026-03-21 00:58:09', NULL, 'Failed'),
(6, 'lyon123@gmail.com', 'Coordinator', '', 'New Content Report: Harassment', 'Idea reported: test', NULL, NULL, NULL, '2026-03-21 03:02:39', NULL, 'Failed'),
(7, 'lyon123@gmail.com', 'Coordinator', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'Staff User Two submitted a new idea in Innovation: 333', 9, NULL, 4, '2026-03-21 03:05:11', NULL, 'Failed'),
(8, '13halhtutalin@gmail.com', '', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'Staff User Two submitted a new idea in Innovation: 333', 9, NULL, 4, '2026-03-21 03:05:11', NULL, 'Failed'),
(9, 'lyon123@gmail.com', 'Coordinator', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'Staff User Two submitted a new idea in Innovation: 1', 10, NULL, 4, '2026-03-21 23:29:02', NULL, 'Failed'),
(10, '13halhtutalin@gmail.com', '', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'Staff User Two submitted a new idea in Innovation: 1', 10, NULL, 4, '2026-03-21 23:29:02', NULL, 'Failed'),
(11, 'staff2@example.com', 'Staff', '', 'New coordinator comment on your idea: 1', 'Leyon commented in sample: test', 10, 7, 4, '2026-03-21 23:58:29', NULL, 'Failed'),
(12, 'lyon123@gmail.com', 'Coordinator', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'A new anonymous idea was submitted in Innovation: t3', 11, NULL, 4, '2026-03-22 00:03:05', NULL, 'Failed'),
(13, '13halhtutalin@gmail.com', '', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'A new anonymous idea was submitted in Innovation: t3', 11, NULL, 4, '2026-03-22 00:03:05', NULL, 'Failed'),
(14, 'staff2@example.com', 'Staff', '', 'New coordinator comment on your idea: t3', 'Leyon commented in sample: test111', 11, 8, 4, '2026-03-22 00:05:09', NULL, 'Failed'),
(15, 'lyon123@gmail.com', 'Coordinator', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'Staff User Two submitted a new idea in Innovation: 4', 12, NULL, 4, '2026-03-22 07:46:16', NULL, 'Failed'),
(16, '13halhtutalin@gmail.com', '', 'Idea_Submitted', 'New Idea Submitted - Innovation sample', 'Staff User Two submitted a new idea in Innovation: 4', 12, NULL, 4, '2026-03-22 07:46:16', NULL, 'Failed'),
(17, 'staff2@example.com', 'Staff', '', 'New coordinator comment on your idea: 4', 'Leyon commented in sample: test', 12, 9, 4, '2026-03-22 07:53:04', NULL, 'Failed'),
(18, 'lyon123@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in sample campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: sample\nIdea Title: testing1\nAnonymous Submission: Yes\nIdea Preview: testing1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 13, NULL, 4, '2026-03-24 03:37:34', NULL, 'Sent'),
(19, '13halhtutalin@gmail.com', '', 'Idea_Submitted', 'New idea submitted in sample campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: sample\nIdea Title: testing1\nAnonymous Submission: Yes\nIdea Preview: testing1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 13, NULL, 4, '2026-03-24 03:37:37', NULL, 'Sent'),
(20, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in sample campaign', 'Hello Coordinator,\n\nStaff AHO from Innovation department has submitted a new idea.\n\nStaff Name: AHO\nDepartment: Innovation\nCampaign: sample\nIdea Title: TESTING2\nAnonymous Submission: No\nIdea Preview: tt1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 14, NULL, 4, '2026-03-24 04:08:45', NULL, 'Sent'),
(21, 'andyoo553@gmail.com', 'Staff', '', 'Coordinator reply in sample campaign: TESTING2', 'Hello AHO,\n\nCoordinator h from innovation department has replied back to your idea.\n\nIdea Title: TESTING2\nCampaign: sample\nCoordinator: h\nDepartment: innovation\nReply Preview: test2\n\nPlease sign in to the system to review the full feedback on your idea.\nThis is an automated notification from Ideas System', 14, 10, 4, '2026-03-24 04:10:59', NULL, 'Sent'),
(22, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in test2 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: test2\nIdea Title: test1\nAnonymous Submission: No\nIdea Preview: test1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 15, NULL, 6, '2026-03-24 04:50:50', NULL, 'Sent'),
(23, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in test2 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: test2\nIdea Title: test1\nAnonymous Submission: No\nIdea Preview: test1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 15, NULL, 6, '2026-03-24 04:50:54', NULL, 'Sent'),
(24, 'staff2@example.com', 'Staff', 'Invitation_Sent', 'Invitation to submit ideas', 'Hello Staff User Two,\n\nh has invited you to participate in an idea campaign.\n\nCampaign: sample\nCoordinator: h\nDepartment: innovation\nCoordinator Message: One of the most upvoted ideas this session is \"TESTING2\" with 3 upvotes. We\'d love your ideas too!\nClosing Date: 2026-03-23 12:42:00\n\nPlease sign in to the system and submit your ideas before the closing date.\nThis is an automated notification from Ideas System', NULL, NULL, 4, '2026-03-25 05:05:31', NULL, 'Sent'),
(25, 'emma.davis@example.com', 'Staff', 'Invitation_Sent', 'Invitation to submit ideas', 'Hello Emma Davis,\n\nh has invited you to participate in an idea campaign.\n\nCampaign: sample\nCoordinator: h\nDepartment: innovation\nCoordinator Message: One of the most upvoted ideas this session is \"TESTING2\" with 3 upvotes. We\'d love your ideas too!\nClosing Date: 2026-03-23 12:42:00\n\nPlease sign in to the system and submit your ideas before the closing date.\nThis is an automated notification from Ideas System', NULL, NULL, 4, '2026-03-25 05:05:45', NULL, 'Sent'),
(26, 'staff1@example.com', 'Staff', 'Invitation_Sent', 'Invitation to submit ideas', 'Hello Test Staff,\n\nh has invited you to participate in an idea campaign.\n\nCampaign: sample\nCoordinator: h\nDepartment: innovation\nCoordinator Message: One of the most upvoted ideas this session is \"TESTING2\" with 3 upvotes. We\'d love your ideas too!\nClosing Date: 2026-03-23 12:42:00\n\nPlease sign in to the system and submit your ideas before the closing date.\nThis is an automated notification from Ideas System', NULL, NULL, 4, '2026-03-25 05:06:53', NULL, 'Sent'),
(27, 'staff2@example.com', 'Staff', 'Invitation_Sent', 'Invitation to submit ideas', 'Hello Staff User Two,\n\nh has invited you to participate in an idea campaign.\n\nCampaign: sample\nCoordinator: h\nDepartment: innovation\nCoordinator Message: One of the most upvoted ideas this session is \"TESTING2\" with 3 upvotes. We\'d love your ideas too!\nClosing Date: 2026-03-23 12:42:00\n\nPlease sign in to the system and submit your ideas before the closing date.\nThis is an automated notification from Ideas System', NULL, NULL, 4, '2026-03-25 05:07:06', NULL, 'Sent'),
(28, 'staff2@example.com', 'Staff', 'Invitation_Sent', 'Invitation to submit ideas', 'Hello Staff User Two,\n\nh has invited you to participate in an idea campaign.\n\nCampaign: sample\nCoordinator: h\nDepartment: innovation\nCoordinator Message: We would love to hear your ideas! Please share your thoughts and suggestions for improvement.\nClosing Date: 2026-03-23 12:42:00\n\nPlease sign in to the system and submit your ideas before the closing date.\nThis is an automated notification from Ideas System', NULL, NULL, 4, '2026-03-25 05:21:35', NULL, 'Sent'),
(29, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in 111 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 111\nIdea Title: 111\nAnonymous Submission: Yes\nIdea Preview: 111\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 16, NULL, 9, '2026-04-17 23:48:12', NULL, 'Sent'),
(30, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in 111 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 111\nIdea Title: 111\nAnonymous Submission: Yes\nIdea Preview: 111\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 16, NULL, 9, '2026-04-17 23:48:16', NULL, 'Sent'),
(31, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in 111 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 111\nIdea Title: 222\nAnonymous Submission: Yes\nIdea Preview: 222\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 17, NULL, 9, '2026-04-17 23:48:48', NULL, 'Sent'),
(32, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in 111 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 111\nIdea Title: 222\nAnonymous Submission: Yes\nIdea Preview: 222\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 17, NULL, 9, '2026-04-17 23:48:53', NULL, 'Sent'),
(33, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in 222 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 222\nIdea Title: 222\nAnonymous Submission: No\nIdea Preview: 222\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 18, NULL, 10, '2026-04-18 01:50:27', NULL, 'Sent'),
(34, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in 222 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 222\nIdea Title: 222\nAnonymous Submission: No\nIdea Preview: 222\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 18, NULL, 10, '2026-04-18 01:50:31', NULL, 'Sent'),
(35, 'admin@example.com', 'Coordinator', '', 'Inappropriate content report: Swearing', 'Hello Admin,\n\nA QA coordinator has submitted a new inappropriate content report.\n\nCoordinator: h\nDepartment: innovation\nContent Type: Idea\nContent ID: 1023\nReport Category: Swearing\nReason: Contains inappropriate language\nDescription: The submitted idea includes multiple offensive words directed at university staff, which violates the platform’s communication guidelines and creates an uncomfortable environment for reviewers.\nSeverity: Medium\n\nPlease sign in to the system to review and moderate the reported content.\nThis is an automated notification from Ideas System', NULL, NULL, NULL, '2026-04-18 22:54:30', NULL, 'Sent'),
(36, 'admin@example.com', 'Coordinator', '', 'Inappropriate content report: Swearing', 'Hello Admin,\n\nA QA coordinator has submitted a new inappropriate content report.\n\nCoordinator: h\nDepartment: innovation\nContent Type: Idea\nContent ID: 1023\nReport Category: Swearing\nReason: Contains inappropriate language\nDescription: The submitted idea includes multiple offensive words directed at university staff, which violates the platform’s communication guidelines and creates an uncomfortable environment for reviewers.\nSeverity: Medium\n\nPlease sign in to the system to review and moderate the reported content.\nThis is an automated notification from Ideas System', NULL, NULL, NULL, '2026-04-18 22:54:32', NULL, 'Sent'),
(37, 'admin@example.com', 'Coordinator', '', 'Inappropriate content report: Harassment', 'Hello Admin,\n\nA QA coordinator has submitted a new inappropriate content report.\n\nCoordinator: h\nDepartment: innovation\nContent Type: Comment\nContent ID: 2045\nReport Category: Harassment\nReason: Targeting another user\nDescription: The comment attacks another user personally, using insulting language and discouraging them from sharing ideas. This behavior is not acceptable in a collaborative academic environment.\nSeverity: High\n\nPlease sign in to the system to review and moderate the reported content.\nThis is an automated notification from Ideas System', NULL, NULL, NULL, '2026-04-18 22:55:34', NULL, 'Sent'),
(38, 'admin@example.com', 'Coordinator', '', 'Inappropriate content report: Offensive', 'Hello Admin,\n\nA QA coordinator has submitted a new inappropriate content report.\n\nCoordinator: h\nDepartment: innovation\nContent Type: Idea\nContent ID: 1187\nReport Category: Offensive\nReason: Irrelevant promotional content\nDescription: The idea submission is unrelated to university improvement and instead promotes an external product/service with repeated links, indicating spam behavior.\nSeverity: Low\n\nPlease sign in to the system to review and moderate the reported content.\nThis is an automated notification from Ideas System', NULL, NULL, NULL, '2026-04-18 22:56:46', NULL, 'Sent'),
(39, 'andyoo553@gmail.com', 'Staff', 'Invitation_Sent', 'Invitation to submit ideas', 'Hello AHO,\n\nh has invited you to participate in an idea campaign.\n\nCampaign: Tech Ideas 2024\nCoordinator: h\nDepartment: innovation\nCoordinator Message: One of the most upvoted ideas this session is \"Automated Testing Framework\" with 2 upvotes. We\'d love your ideas too!\nClosing Date: 2024-03-31 23:59:59\n\nPlease sign in to the system and submit your ideas before the closing date.\nThis is an automated notification from Ideas System', NULL, NULL, 1, '2026-04-19 00:24:34', NULL, 'Sent'),
(40, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Counseling Hub for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes creating a combined peer-support and digital counseling platform to improve student mental health awareness and access to help. Many students experience stress, anxiety, and academic pressure but hesit\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 19, NULL, 11, '2026-04-19 01:56:14', NULL, 'Sent'),
(41, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Counseling Hub for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes creating a combined peer-support and digital counseling platform to improve student mental health awareness and access to help. Many students experience stress, anxiety, and academic pressure but hesit\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 19, NULL, 11, '2026-04-19 01:56:19', NULL, 'Sent'),
(42, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Campus Mental Wellness Break Program\nAnonymous Submission: No\nIdea Preview: This idea introduces a dedicated “Recharge Week” once per semester where students can step back from academic pressure and focus on their mental well-being. During this week, no major exams, deadlines, or heavy coursewor\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 20, NULL, 11, '2026-04-19 01:58:32', NULL, 'Sent'),
(43, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Campus Mental Wellness Break Program\nAnonymous Submission: No\nIdea Preview: This idea introduces a dedicated “Recharge Week” once per semester where students can step back from academic pressure and focus on their mental well-being. During this week, no major exams, deadlines, or heavy coursewor\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 20, NULL, 11, '2026-04-19 01:58:37', NULL, 'Sent'),
(44, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: AI-Powered Personalized Learning Dashboard for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes developing an AI-powered digital learning dashboard that personalizes each student’s learning experience based on their performance, behavior, and learning pace. Many students struggle with one-size-fi\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 21, NULL, 12, '2026-04-19 02:00:16', NULL, 'Sent'),
(45, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: AI-Powered Personalized Learning Dashboard for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes developing an AI-powered digital learning dashboard that personalizes each student’s learning experience based on their performance, behavior, and learning pace. Many students struggle with one-size-fi\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 21, NULL, 12, '2026-04-19 02:00:22', NULL, 'Sent'),
(46, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Offline-First Learning App for Low-Connectivity Students\nAnonymous Submission: No\nIdea Preview: This idea focuses on improving digital learning accessibility for students who face unstable or limited internet access. Many students struggle to attend live classes or access materials consistently due to poor connecti\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 22, NULL, 12, '2026-04-19 02:01:39', NULL, 'Sent'),
(47, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Offline-First Learning App for Low-Connectivity Students\nAnonymous Submission: No\nIdea Preview: This idea focuses on improving digital learning accessibility for students who face unstable or limited internet access. Many students struggle to attend live classes or access materials consistently due to poor connecti\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 22, NULL, 12, '2026-04-19 02:01:44', NULL, 'Sent'),
(48, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: 24/7 Mental Health Chatbot for Students\nAnonymous Submission: No\nIdea Preview: Develop an AI-powered chatbot available on the university website and mobile app to provide instant mental health support. The chatbot can answer common questions, guide students through breathing exercises, and direct t\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 23, NULL, 11, '2026-04-19 02:05:09', NULL, 'Sent'),
(49, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: 24/7 Mental Health Chatbot for Students\nAnonymous Submission: No\nIdea Preview: Develop an AI-powered chatbot available on the university website and mobile app to provide instant mental health support. The chatbot can answer common questions, guide students through breathing exercises, and direct t\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 23, NULL, 11, '2026-04-19 02:05:14', NULL, 'Sent'),
(50, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Weekly “No Stress” Campus Hour\nAnonymous Submission: Yes\nIdea Preview: Introduce a weekly one-hour break across campus where no classes, meetings, or deadlines are scheduled. During this time, students can join relaxing activities like yoga, meditation, music, or art sessions to reduce stre\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 24, NULL, 11, '2026-04-19 02:06:17', NULL, 'Sent'),
(51, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Weekly “No Stress” Campus Hour\nAnonymous Submission: Yes\nIdea Preview: Introduce a weekly one-hour break across campus where no classes, meetings, or deadlines are scheduled. During this time, students can join relaxing activities like yoga, meditation, music, or art sessions to reduce stre\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 24, NULL, 11, '2026-04-19 02:06:21', NULL, 'Sent'),
(52, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Virtual Reality (VR) Classrooms for Interactive Learning\nAnonymous Submission: Yes\nIdea Preview: Introduce VR-based classrooms where students can experience immersive learning environments. For example, medical students can practice surgeries virtually, while history students can explore ancient civilizations. This\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 25, NULL, 12, '2026-04-19 02:07:20', NULL, 'Sent'),
(53, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Virtual Reality (VR) Classrooms for Interactive Learning\nAnonymous Submission: Yes\nIdea Preview: Introduce VR-based classrooms where students can experience immersive learning environments. For example, medical students can practice surgeries virtually, while history students can explore ancient civilizations. This\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 25, NULL, 12, '2026-04-19 02:07:24', NULL, 'Sent'),
(54, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Smart Attendance System Using Facial Recognition\nAnonymous Submission: No\nIdea Preview: Implement a facial recognition system to automatically track attendance in classrooms. This reduces manual work, prevents proxy attendance, and ensures accurate records.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 26, NULL, 12, '2026-04-19 02:08:09', NULL, 'Sent'),
(55, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Smart Attendance System Using Facial Recognition\nAnonymous Submission: No\nIdea Preview: Implement a facial recognition system to automatically track attendance in classrooms. This reduces manual work, prevents proxy attendance, and ensures accurate records.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 26, NULL, 12, '2026-04-19 02:08:13', NULL, 'Sent'),
(56, 'staff2@example.com', 'Staff', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Virtual Reality (VR) Classrooms for Interactive Learning', 'Hello Staff User Two,\n\nA new comment has been posted on your idea.\n\nIdea Title: Virtual Reality (VR) Classrooms for Interactive Learning\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Staff User Two\nComment Preview: Recommends videos, readings, and quizzes tailored to individual learning styles (visual, auditory, kinesthetic)\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 25, 11, NULL, '2026-04-19 02:10:03', NULL, 'Sent'),
(57, 'staff2@example.com', 'Staff', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Smart Attendance System Using Facial Recognition', 'Hello Staff User Two,\n\nA new comment has been posted on your idea.\n\nIdea Title: Smart Attendance System Using Facial Recognition\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: real-time progress, performance trends, and areas needing improvement\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 26, 12, NULL, '2026-04-19 02:10:45', NULL, 'Sent'),
(58, 'leyonhal5@gmail.com', 'Staff', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Campus Mental Wellness Break Program', 'Hello Leon,\n\nA new comment has been posted on your idea.\n\nIdea Title: Campus Mental Wellness Break Program\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Staff User Two\nComment Preview: Identifies at-risk students and sends alerts to both students and instructors.\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 20, 13, NULL, '2026-04-19 02:11:54', NULL, 'Sent'),
(59, 'leyonhal5@gmail.com', 'Staff', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Peer Support & Digital Counseling Hub for Students', 'Hello Leon,\n\nA new comment has been posted on your idea.\n\nIdea Title: Peer Support & Digital Counseling Hub for Students\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: improve student engagement, reduce dropout rates, and enhance overall academic performance\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 19, 14, NULL, '2026-04-19 02:12:35', NULL, 'Sent'),
(60, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Eco-Friendly Paperless Assignment Submission System\nAnonymous Submission: No\nIdea Preview: Encourage digital submission and grading of assignments to reduce paper usage. The system will include annotation tools for lecturers and version tracking for students.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 27, NULL, 12, '2026-04-19 02:14:39', NULL, 'Sent'),
(61, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Eco-Friendly Paperless Assignment Submission System\nAnonymous Submission: No\nIdea Preview: Encourage digital submission and grading of assignments to reduce paper usage. The system will include annotation tools for lecturers and version tracking for students.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 27, NULL, 12, '2026-04-19 02:14:43', NULL, 'Sent'),
(62, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Centralized Internship and Job Matching Portal\nAnonymous Submission: Yes\nIdea Preview: Develop a portal that matches students with internships and job opportunities based on their skills, courses, and interests using AI recommendations.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 28, NULL, 12, '2026-04-19 02:15:46', NULL, 'Sent'),
(63, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Centralized Internship and Job Matching Portal\nAnonymous Submission: Yes\nIdea Preview: Develop a portal that matches students with internships and job opportunities based on their skills, courses, and interests using AI recommendations.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 28, NULL, 12, '2026-04-19 02:15:52', NULL, 'Sent'),
(64, 'staff1@example.com', 'Staff', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Centralized Internship and Job Matching Portal', 'Hello Test Staff,\n\nA new comment has been posted on your idea.\n\nIdea Title: Centralized Internship and Job Matching Portal\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: matches students with internships and job opportunities\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 28, 15, NULL, '2026-04-19 02:16:54', NULL, 'Sent'),
(65, 'staff2@example.com', 'Staff', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Smart Attendance System Using Facial Recognition', 'Hello Staff User Two,\n\nA new comment has been posted on your idea.\n\nIdea Title: Smart Attendance System Using Facial Recognition\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Test Staff\nComment Preview: Smart Content Suggestions\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 26, 16, NULL, '2026-04-19 02:17:26', NULL, 'Sent'),
(66, 'leyonhal5@gmail.com', 'Staff', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Offline-First Learning App for Low-Connectivity Students', 'Hello Leon,\n\nA new comment has been posted on your idea.\n\nIdea Title: Offline-First Learning App for Low-Connectivity Students\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Test Staff\nComment Preview: dentifies at-risk students\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 22, 17, NULL, '2026-04-19 02:17:54', NULL, 'Sent'),
(67, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mental Health Workshops Series\nAnonymous Submission: No\nIdea Preview: Organize monthly workshops on topics like anxiety management, time management, emotional resilience, and healthy lifestyle habits. These sessions can be led by professionals and open to all students.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 29, NULL, 11, '2026-04-19 02:19:38', NULL, 'Sent'),
(68, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mental Health Workshops Series\nAnonymous Submission: No\nIdea Preview: Organize monthly workshops on topics like anxiety management, time management, emotional resilience, and healthy lifestyle habits. These sessions can be led by professionals and open to all students.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 29, NULL, 11, '2026-04-19 02:19:43', NULL, 'Sent'),
(69, 'staff1@example.com', 'Staff', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Mental Health Workshops Series', 'Hello Test Staff,\n\nA new comment has been posted on your idea.\n\nIdea Title: Mental Health Workshops Series\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: real-time progress, performance trends, and areas needing improvement\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 29, 18, NULL, '2026-04-19 02:20:23', NULL, 'Sent'),
(70, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Feedback & Help Platform\nAnonymous Submission: No\nIdea Preview: Create an online platform where students can anonymously share concerns, report stress factors, or request help. The system can route issues to appropriate departments for quick response.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 30, NULL, 11, '2026-04-19 02:22:48', NULL, 'Sent'),
(71, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Feedback & Help Platform\nAnonymous Submission: No\nIdea Preview: Create an online platform where students can anonymously share concerns, report stress factors, or request help. The system can route issues to appropriate departments for quick response.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 30, NULL, 11, '2026-04-19 02:22:52', NULL, 'Sent'),
(72, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff aaa from Administration department has submitted a new idea.\n\nStaff Name: aaa\nDepartment: Administration\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Automated Feedback Collection System for Courses\nAnonymous Submission: No\nIdea Preview: Develop a system that collects real-time feedback from students during the semester instead of only at the end. This allows lecturers to improve teaching methods quickly.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 31, NULL, 12, '2026-04-19 02:24:37', NULL, 'Sent'),
(73, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: aaa\nDepartment: Administration\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Automated Feedback Collection System for Courses\nAnonymous Submission: No\nIdea Preview: Develop a system that collects real-time feedback from students during the semester instead of only at the end. This allows lecturers to improve teaching methods quickly.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 31, NULL, 12, '2026-04-19 02:24:42', NULL, 'Sent'),
(74, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff aaa from Administration department has submitted a new idea.\n\nStaff Name: aaa\nDepartment: Administration\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: “Buddy System” for New Students\nAnonymous Submission: No\nIdea Preview: Pair new students with senior student mentors who provide guidance, emotional support, and help them adjust to university life. This reduces loneliness and improves mental wellbeing.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 32, NULL, 11, '2026-04-19 02:25:27', NULL, 'Sent'),
(75, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: aaa\nDepartment: Administration\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: “Buddy System” for New Students\nAnonymous Submission: No\nIdea Preview: Pair new students with senior student mentors who provide guidance, emotional support, and help them adjust to university life. This reduces loneliness and improves mental wellbeing.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 32, NULL, 11, '2026-04-19 02:25:32', NULL, 'Sent'),
(76, 'staff1@example.com', 'Staff', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Anonymous Feedback & Help Platform', 'Hello Test Staff,\n\nA new comment has been posted on your idea.\n\nIdea Title: Anonymous Feedback & Help Platform\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: Offer short online courses with certifications in digital skills such as coding\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 30, 19, NULL, '2026-04-19 02:26:39', NULL, 'Sent'),
(77, 'staff1@example.com', 'Staff', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Mental Health Workshops Series', 'Hello Test Staff,\n\nA new comment has been posted on your idea.\n\nIdea Title: Mental Health Workshops Series\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Staff member\nComment Preview: analyze students’ learning behavior, performance, and engagement\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 29, 20, NULL, '2026-04-19 02:27:26', NULL, 'Sent'),
(78, '13halhtutalin@gmail.com', 'Coordinator', '', 'New content report: Offensive', 'Hello Coordinator,\n\nA new content report has been submitted and requires review.\n\nContent Type: Idea\nReport Category: Offensive\nReason: Contains insulting language toward a group of students\nDescription: The post includes derogatory remarks targeting international students, which may create a hostile environment and violate community guidelines.\n\nPlease sign in to the system to review the reported content.\nThis is an automated notification from Ideas System', NULL, NULL, NULL, '2026-04-19 02:29:29', NULL, 'Sent'),
(79, '13halhtutalin@gmail.com', 'Coordinator', '', 'New content report: Other', 'Hello Coordinator,\n\nA new content report has been submitted and requires review.\n\nContent Type: Idea\nReport Category: Other\nReason: Uses inappropriate and disrespectful words\nDescription: The content contains offensive slang and rude expressions directed at classmates. This may negatively impact student wellbeing and respectful communication.\n\nPlease sign in to the system to review the reported content.\nThis is an automated notification from Ideas System', NULL, NULL, NULL, '2026-04-19 02:31:28', NULL, 'Sent'),
(80, '13halhtutalin@gmail.com', 'Coordinator', '', 'New content report: Swearing', 'Hello Coordinator,\n\nA new content report has been submitted and requires review.\n\nContent Type: Idea\nReport Category: Swearing\nReason: Contains personal attacks\nDescription: The content directly targets an individual with negative and abusive comments, which could lead to harassment concerns.\n\nPlease sign in to the system to review the reported content.\nThis is an automated notification from Ideas System', NULL, NULL, NULL, '2026-04-19 02:33:53', NULL, 'Sent'),
(81, 'leyonhal5@gmail.com', 'Staff', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Peer Support & Digital Counseling Hub for Students', 'Hello Leon,\n\nA new comment has been posted on your idea.\n\nIdea Title: Peer Support & Digital Counseling Hub for Students\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: may create a hostile environment and violate community guidelines\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 19, 21, NULL, '2026-04-19 02:34:33', NULL, 'Sent'),
(82, '13halhtutalin@gmail.com', 'Coordinator', '', 'New content report: Libel', 'Hello Coordinator,\n\nA new content report has been submitted and requires review.\n\nContent Type: Idea\nReport Category: Libel\nReason: Promotes harmful stereotypes\nDescription: The idea submission includes stereotypes about certain groups, which can be considered discriminatory and inappropriate for an academic environment.\n\nPlease sign in to the system to review the reported content.\nThis is an automated notification from Ideas System', NULL, NULL, NULL, '2026-04-19 02:35:23', NULL, 'Sent'),
(83, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff bbb from Marketing department has submitted a new idea.\n\nStaff Name: bbb\nDepartment: Marketing\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Exam Period Wellness Kits\nAnonymous Submission: No\nIdea Preview: Distribute wellness kits during exam seasons containing snacks, motivational notes, stress-relief items, and mental health resources. This supports students during high-pressure periods.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 33, NULL, 11, '2026-04-19 02:36:33', NULL, 'Sent'),
(84, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: bbb\nDepartment: Marketing\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Exam Period Wellness Kits\nAnonymous Submission: No\nIdea Preview: Distribute wellness kits during exam seasons containing snacks, motivational notes, stress-relief items, and mental health resources. This supports students during high-pressure periods.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 33, NULL, 11, '2026-04-19 02:36:37', NULL, 'Sent'),
(85, 'leyonhal5@gmail.com', 'Staff', '', 'Coordinator reply in Student Mental Health Awareness Campaign 2026 campaign: Campus Mental Wellness Break Program', 'Hello Leon,\n\nCoordinator h from innovation department has replied back to your idea.\n\nIdea Title: Campus Mental Wellness Break Program\nCampaign: Student Mental Health Awareness Campaign 2026\nCoordinator: h\nDepartment: innovation\nReply Preview: reply\n\nPlease sign in to the system to review the full feedback on your idea.\nThis is an automated notification from Ideas System', 20, 22, 11, '2026-04-19 03:38:08', NULL, 'Sent');
INSERT INTO `email_notifications` (`id`, `recipient_email`, `recipient_type`, `notification_type`, `subject`, `message`, `idea_id`, `comment_id`, `session_id`, `sent_at`, `read_at`, `status`) VALUES
(86, 'andyoo553@gmail.com', 'Staff', 'Invitation_Sent', 'Invitation to submit ideas', 'Hello AHO,\n\nh has invited you to participate in an idea campaign.\n\nCampaign: Student Mental Health Awareness Campaign 2026\nCoordinator: h\nDepartment: innovation\nCoordinator Message: Hi! Just a friendly reminder that we are looking for your innovative ideas. The submission window closes soon!\nClosing Date: 2026-05-09 10:46:00\n\nPlease sign in to the system and submit your ideas before the closing date.\nThis is an automated notification from Ideas System', NULL, NULL, 11, '2026-04-19 03:40:21', NULL, 'Sent'),
(87, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Wellbeing Program for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambas\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 34, NULL, 11, '2026-04-19 09:52:15', NULL, 'Sent'),
(88, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Wellbeing Program for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambas\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 34, NULL, 11, '2026-04-19 09:52:20', NULL, 'Sent'),
(89, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Wellbeing Program for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambas\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 35, NULL, 11, '2026-04-19 09:52:43', NULL, 'Sent'),
(90, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Wellbeing Program for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambas\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 35, NULL, 11, '2026-04-19 09:52:47', NULL, 'Sent'),
(91, '13halhtutalin@gmail.com', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: The Vent Tent\nAnonymous Submission: No\nIdea Preview: A weekly, informal pop-up station located in high-traffic campus areas where students can grab a free coffee and talk to trained student volunteers. Unlike formal counseling, this offers a low-pressure environment for st\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 36, NULL, 11, '2026-04-19 10:02:25', NULL, 'Sent'),
(92, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: The Vent Tent\nAnonymous Submission: No\nIdea Preview: A weekly, informal pop-up station located in high-traffic campus areas where students can grab a free coffee and talk to trained student volunteers. Unlike formal counseling, this offers a low-pressure environment for st\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 36, NULL, 11, '2026-04-19 10:02:29', NULL, 'Sent'),
(93, 'leyonhal5@gmail.com', 'Staff', '', 'Coordinator reply in Student Mental Health Awareness Campaign 2026 campaign: The Vent Tent', 'Hello Leon,\n\nCoordinator h from innovation department has replied back to your idea.\n\nIdea Title: The Vent Tent\nCampaign: Student Mental Health Awareness Campaign 2026\nCoordinator: h\nDepartment: innovation\nReply Preview: This is a well-thought-out initiative that addresses a real need among students. Introducing a “Recharge Week” could have a positive impact on reducing stress and improving overall wellbeing. Before moving forward, we ma\n\nPlease sign in to the system to review the full feedback on your idea.\nThis is an automated notification from Ideas System', 36, 23, 11, '2026-04-19 10:05:31', NULL, 'Sent'),
(94, 'andyoo553@gmail.com', 'Staff', 'Invitation_Sent', 'Invitation to submit ideas', 'Hello AHO,\n\nh has invited you to participate in an idea campaign.\n\nCampaign: Student Mental Health Awareness Campaign 2026\nCoordinator: h\nDepartment: innovation\nCoordinator Message: One of the most upvoted ideas this session is \"24/7 Mental Health Chatbot for Students\" with 5 upvotes. We\'d love your ideas too!\nClosing Date: 2026-05-09 10:46:00\n\nPlease sign in to the system and submit your ideas before the closing date.\nThis is an automated notification from Ideas System', NULL, NULL, 11, '2026-04-19 10:07:39', NULL, 'Sent'),
(95, 'imsqacoordinator01@ewsd.local', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 01 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mindful Mornings: Peer-Led Meditation Circles\nAnonymous Submission: No\nIdea Preview: A 15-minute guided mindfulness session held every Monday and Wednesday before first class. Students take turns leading simple breathing exercises, body scans, or gratitude journaling. Promotes calm and connection before\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 37, NULL, 11, '2026-04-20 08:41:45', NULL, 'Sent'),
(96, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mindful Mornings: Peer-Led Meditation Circles\nAnonymous Submission: No\nIdea Preview: A 15-minute guided mindfulness session held every Monday and Wednesday before first class. Students take turns leading simple breathing exercises, body scans, or gratitude journaling. Promotes calm and connection before\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 37, NULL, 11, '2026-04-20 08:41:50', NULL, 'Sent'),
(97, 'imsqamanager01@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mindful Mornings: Peer-Led Meditation Circles\nAnonymous Submission: No\nIdea Preview: A 15-minute guided mindfulness session held every Monday and Wednesday before first class. Students take turns leading simple breathing exercises, body scans, or gratitude journaling. Promotes calm and connection before\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 37, NULL, 11, '2026-04-20 08:41:56', NULL, 'Sent'),
(98, 'imsqacoordinator01@ewsd.local', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 01 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Stress Less Exam Kits\nAnonymous Submission: No\nIdea Preview: Distribute free kits during midterms and finals containing earplugs, herbal tea, a stress ball, a study schedule template, and a list of campus mental health resources. Designed to reduce last-minute panic and encourage\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 38, NULL, 11, '2026-04-20 08:42:41', NULL, 'Sent'),
(99, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Stress Less Exam Kits\nAnonymous Submission: No\nIdea Preview: Distribute free kits during midterms and finals containing earplugs, herbal tea, a stress ball, a study schedule template, and a list of campus mental health resources. Designed to reduce last-minute panic and encourage\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 38, NULL, 11, '2026-04-20 08:42:46', NULL, 'Sent'),
(100, 'imsqamanager01@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Stress Less Exam Kits\nAnonymous Submission: No\nIdea Preview: Distribute free kits during midterms and finals containing earplugs, herbal tea, a stress ball, a study schedule template, and a list of campus mental health resources. Designed to reduce last-minute panic and encourage\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 38, NULL, 11, '2026-04-20 08:42:51', NULL, 'Sent'),
(101, 'imsqacoordinator01@ewsd.local', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 01 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Story Wall\nAnonymous Submission: No\nIdea Preview: A physical and digital bulletin board where students can anonymously post short experiences about mental health struggles, recovery, or encouragement. Updated weekly. Reduces stigma by showing that no one is alone in the\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 39, NULL, 11, '2026-04-20 08:45:14', NULL, 'Sent'),
(102, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Story Wall\nAnonymous Submission: No\nIdea Preview: A physical and digital bulletin board where students can anonymously post short experiences about mental health struggles, recovery, or encouragement. Updated weekly. Reduces stigma by showing that no one is alone in the\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 39, NULL, 11, '2026-04-20 08:45:19', NULL, 'Sent'),
(103, 'imsqamanager01@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Story Wall\nAnonymous Submission: No\nIdea Preview: A physical and digital bulletin board where students can anonymously post short experiences about mental health struggles, recovery, or encouragement. Updated weekly. Reduces stigma by showing that no one is alone in the\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 39, NULL, 11, '2026-04-20 08:45:25', NULL, 'Sent'),
(104, 'imsqacoordinator01@ewsd.local', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 01 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Faculty–Student Mental Health First Aid Training\nAnonymous Submission: No\nIdea Preview: A 2-hour workshop for professors and TAs to recognize warning signs (e.g., withdrawal, sudden grade drops) and respond with empathy. Includes role-play scenarios and referral pathways. Builds a supportive academic enviro\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 40, NULL, 11, '2026-04-20 08:46:10', NULL, 'Sent'),
(105, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Faculty–Student Mental Health First Aid Training\nAnonymous Submission: No\nIdea Preview: A 2-hour workshop for professors and TAs to recognize warning signs (e.g., withdrawal, sudden grade drops) and respond with empathy. Includes role-play scenarios and referral pathways. Builds a supportive academic enviro\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 40, NULL, 11, '2026-04-20 08:46:14', NULL, 'Sent'),
(106, 'imsqamanager01@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Faculty–Student Mental Health First Aid Training\nAnonymous Submission: No\nIdea Preview: A 2-hour workshop for professors and TAs to recognize warning signs (e.g., withdrawal, sudden grade drops) and respond with empathy. Includes role-play scenarios and referral pathways. Builds a supportive academic enviro\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 40, NULL, 11, '2026-04-20 08:46:20', NULL, 'Sent'),
(107, 'imsqacoordinator01@ewsd.local', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 02 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Creative Coping: Art & Music Therapy Pop-Ups\nAnonymous Submission: No\nIdea Preview: Weekly drop-in sessions in the student lounge with coloring sheets, clay, collage materials, and a keyboard. No art skills needed. Students create while listening to lo-fi beats – proven to lower cortisol levels.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 41, NULL, 11, '2026-04-20 08:48:00', NULL, 'Sent'),
(108, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Creative Coping: Art & Music Therapy Pop-Ups\nAnonymous Submission: No\nIdea Preview: Weekly drop-in sessions in the student lounge with coloring sheets, clay, collage materials, and a keyboard. No art skills needed. Students create while listening to lo-fi beats – proven to lower cortisol levels.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 41, NULL, 11, '2026-04-20 08:48:05', NULL, 'Sent'),
(109, 'imsqamanager01@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Creative Coping: Art & Music Therapy Pop-Ups\nAnonymous Submission: No\nIdea Preview: Weekly drop-in sessions in the student lounge with coloring sheets, clay, collage materials, and a keyboard. No art skills needed. Students create while listening to lo-fi beats – proven to lower cortisol levels.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 41, NULL, 11, '2026-04-20 08:48:09', NULL, 'Sent'),
(110, 'imsqacoordinator01@ewsd.local', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 02 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Night Line: Student-Run Peer Listening Service\nAnonymous Submission: No\nIdea Preview: A confidential hotline (8 PM–12 AM) staffed by trained student volunteers. Offers non-judgmental listening, crisis resource referral, and “warm handoffs” to counseling services. Expands access for evening loneliness or p\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 42, NULL, 11, '2026-04-20 08:48:45', NULL, 'Sent'),
(111, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Night Line: Student-Run Peer Listening Service\nAnonymous Submission: No\nIdea Preview: A confidential hotline (8 PM–12 AM) staffed by trained student volunteers. Offers non-judgmental listening, crisis resource referral, and “warm handoffs” to counseling services. Expands access for evening loneliness or p\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 42, NULL, 11, '2026-04-20 08:48:50', NULL, 'Sent'),
(112, 'imsqamanager01@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Night Line: Student-Run Peer Listening Service\nAnonymous Submission: No\nIdea Preview: A confidential hotline (8 PM–12 AM) staffed by trained student volunteers. Offers non-judgmental listening, crisis resource referral, and “warm handoffs” to counseling services. Expands access for evening loneliness or p\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 42, NULL, 11, '2026-04-20 08:48:56', NULL, 'Sent'),
(113, 'imsqacoordinator01@ewsd.local', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 02 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mind & Body Walk & Talk\nAnonymous Submission: No\nIdea Preview: A guided 30-minute walk around campus followed by 30 minutes of open conversation under a tree. Combines light exercise (boosts endorphins) with organic social connection. No pressure to share – just walking together hel\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 43, NULL, 11, '2026-04-20 08:51:08', NULL, 'Sent'),
(114, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mind & Body Walk & Talk\nAnonymous Submission: No\nIdea Preview: A guided 30-minute walk around campus followed by 30 minutes of open conversation under a tree. Combines light exercise (boosts endorphins) with organic social connection. No pressure to share – just walking together hel\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 43, NULL, 11, '2026-04-20 08:51:13', NULL, 'Sent'),
(115, 'imsqamanager01@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mind & Body Walk & Talk\nAnonymous Submission: No\nIdea Preview: A guided 30-minute walk around campus followed by 30 minutes of open conversation under a tree. Combines light exercise (boosts endorphins) with organic social connection. No pressure to share – just walking together hel\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 43, NULL, 11, '2026-04-20 08:51:18', NULL, 'Sent'),
(116, 'imsqacoordinator01@ewsd.local', 'Coordinator', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 02 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Digital Detox Challenge\nAnonymous Submission: No\nIdea Preview: A 24-hour opt-in challenge where students put their phones on grayscale and log screen-free activities (reading, cooking, chatting). Participants get a small prize and a reflection sheet. Raises awareness of social media\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 44, NULL, 11, '2026-04-20 08:51:43', NULL, 'Sent'),
(117, 'manager@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Digital Detox Challenge\nAnonymous Submission: No\nIdea Preview: A 24-hour opt-in challenge where students put their phones on grayscale and log screen-free activities (reading, cooking, chatting). Participants get a small prize and a reflection sheet. Raises awareness of social media\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 44, NULL, 11, '2026-04-20 08:51:48', NULL, 'Sent'),
(118, 'imsqamanager01@ewsd.local', '', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Digital Detox Challenge\nAnonymous Submission: No\nIdea Preview: A 24-hour opt-in challenge where students put their phones on grayscale and log screen-free activities (reading, cooking, chatting). Participants get a small prize and a reflection sheet. Raises awareness of social media\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 44, NULL, 11, '2026-04-20 08:51:53', NULL, 'Sent');

-- --------------------------------------------------------

--
-- Table structure for table `ideas`
--

CREATE TABLE `ideas` (
  `id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `contributor_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `impact_level` enum('Low','Medium','High','Critical') DEFAULT 'Medium',
  `status` enum('Draft','Submitted','Under Review','Approved','Rejected') DEFAULT 'Draft',
  `approval_status` enum('Pending','Approved','Rejected','Flagged') DEFAULT 'Pending',
  `is_inappropriate` tinyint(1) DEFAULT 0,
  `inappropriate_reason` text DEFAULT NULL,
  `flagged_by_admin_id` int(11) DEFAULT NULL,
  `flagged_at` timestamp NULL DEFAULT NULL,
  `view_count` int(11) DEFAULT 0,
  `like_count` int(11) DEFAULT 0,
  `comment_count` int(11) DEFAULT 0,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `upvote_count` int(11) DEFAULT 0,
  `downvote_count` int(11) DEFAULT 0,
  `is_locked_for_submissions` tinyint(1) DEFAULT 0,
  `is_anonymous` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ideas`
--

INSERT INTO `ideas` (`id`, `session_id`, `contributor_id`, `title`, `description`, `department`, `impact_level`, `status`, `approval_status`, `is_inappropriate`, `inappropriate_reason`, `flagged_by_admin_id`, `flagged_at`, `view_count`, `like_count`, `comment_count`, `submitted_at`, `approved_at`, `rejected_at`, `created_at`, `updated_at`, `upvote_count`, `downvote_count`, `is_locked_for_submissions`, `is_anonymous`) VALUES
(1, 1, 1, 'AI-Powered Analytics Dashboard', 'Create an analytics dashboard using AI to provide insights', 'Technology', 'High', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 12, 0, 0, '2024-02-01 03:00:00', '2024-02-15 07:00:00', NULL, '2026-03-18 08:20:10', '2026-03-21 05:24:46', 1, 0, 0, 0),
(2, 1, 2, 'Automated Testing Framework', 'Implement automated testing to improve code quality', 'Technology', 'High', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 18, 1, 0, '2024-02-05 04:30:00', '2024-02-20 03:00:00', NULL, '2026-03-18 08:20:10', '2026-03-22 13:41:25', 2, 1, 0, 0),
(3, 2, 3, 'Community Outreach Program', 'Partner with local organizations for community impact', 'Operations', 'Medium', 'Submitted', 'Pending', 0, NULL, NULL, NULL, 0, 0, 0, '2024-02-10 02:15:00', NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10', 0, 0, 0, 0),
(4, 2, 4, 'Anonymous Suggestion Box', 'Digital suggestion box for employee feedback', 'Innovation', 'Medium', 'Submitted', 'Pending', 0, NULL, NULL, NULL, 1, 0, 0, '2024-02-12 07:45:00', NULL, NULL, '2026-03-18 08:20:10', '2026-03-25 10:54:36', 0, 0, 0, 0),
(5, 3, 5, 'Solar Panel Installation', 'Install solar panels in the office', 'Technology', 'High', 'Submitted', '', 0, NULL, NULL, NULL, 0, 0, 0, '2024-03-05 01:30:00', NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10', 0, 0, 0, 0),
(6, 4, 6, 'testing', 'testing', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 6, 0, 0, '2026-03-21 05:43:28', NULL, NULL, '2026-03-21 05:43:28', '2026-03-25 11:25:42', 0, 0, 0, 1),
(7, 4, 14, 'testing2', 'testing2', 'Innovation', 'Medium', '', '', 1, 'Inappropriate content', 14, '2026-03-25 12:54:39', 16, 0, 0, '2026-03-21 06:50:02', NULL, NULL, '2026-03-21 06:50:02', '2026-04-18 06:04:00', 1, 0, 0, 1),
(8, 4, 6, 'testing3', 'testing3', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, 'Inappropriate content', 14, '2026-03-25 12:46:32', 15, 0, 0, '2026-03-21 06:58:08', NULL, NULL, '2026-03-21 06:58:08', '2026-04-18 06:03:57', 0, 0, 0, 1),
(9, 4, 6, '333', '333', 'Innovation', 'Medium', 'Submitted', 'Flagged', 1, 'Inappropriate content', 12, '2026-03-25 10:26:56', 9, 0, 1, '2026-03-21 09:05:11', NULL, NULL, '2026-03-21 09:05:11', '2026-03-25 10:52:35', 0, 0, 0, 0),
(10, 4, 6, '1', '1', 'Innovation', 'Medium', '', '', 1, 'Inappropriate content', 14, '2026-03-25 10:41:43', 3, 1, 1, '2026-03-22 05:29:02', NULL, NULL, '2026-03-22 05:29:02', '2026-03-25 11:32:53', 2, 0, 0, 0),
(11, 4, 6, 't3', 't3', 'Innovation', 'Medium', 'Submitted', 'Flagged', 1, 'Inappropriate content', 12, '2026-03-25 10:27:13', 6, 0, 1, '2026-03-22 06:03:05', NULL, NULL, '2026-03-22 06:03:05', '2026-04-18 06:03:52', 0, 0, 0, 1),
(12, 4, 6, '4', '4', 'Innovation', 'Medium', '', '', 1, 'Inappropriate content', 14, '2026-03-25 10:41:29', 4, 0, 1, '2026-03-22 13:46:16', NULL, NULL, '2026-03-22 13:46:16', '2026-04-18 06:03:50', 0, 0, 0, 0),
(13, 4, 14, 'testing1', 'testing1', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 42, 0, 0, '2026-03-24 09:37:30', NULL, NULL, '2026-03-24 09:37:30', '2026-04-18 07:08:08', 1, 0, 0, 1),
(14, 4, 16, 'TESTING2', 'tt1', 'Innovation', 'Medium', 'Submitted', 'Flagged', 1, 'Inappropriate content', 12, '2026-03-25 10:27:19', 27, 1, 1, '2026-03-24 10:08:41', NULL, NULL, '2026-03-24 10:08:41', '2026-04-18 06:03:47', 3, 0, 0, 0),
(15, 6, 6, 'test1', 'test1', 'Innovation', 'Medium', '', '', 1, 'Inappropriate content', 14, '2026-03-25 12:49:45', 18, 0, 0, '2026-03-24 10:50:46', NULL, NULL, '2026-03-24 10:50:46', '2026-04-18 06:04:10', 0, 0, 0, 0),
(16, 9, 6, '111', '111', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 3, 0, 0, '2026-04-18 04:48:07', NULL, NULL, '2026-04-18 04:48:07', '2026-04-19 05:19:09', 0, 0, 0, 1),
(17, 9, 6, '222', '222', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 3, 0, 0, '2026-04-18 04:48:43', NULL, NULL, '2026-04-18 04:48:43', '2026-04-18 06:03:33', 0, 0, 0, 1),
(18, 10, 6, '222', '222', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 11, 0, 0, '2026-04-18 06:50:23', NULL, NULL, '2026-04-18 06:50:23', '2026-04-19 05:28:47', 1, 0, 0, 0),
(19, 11, 18, 'Peer Support & Digital Counseling Hub for Students', 'This idea proposes creating a combined peer-support and digital counseling platform to improve student mental health awareness and access to help. Many students experience stress, anxiety, and academic pressure but hesitate to seek professional support due to stigma or limited availability of counselors.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 18, 0, 2, '2026-04-19 06:56:09', NULL, NULL, '2026-04-19 06:56:09', '2026-04-19 07:34:36', 1, 2, 0, 0),
(20, 11, 18, 'Campus Mental Wellness Break Program', 'This idea introduces a dedicated “Recharge Week” once per semester where students can step back from academic pressure and focus on their mental well-being. During this week, no major exams, deadlines, or heavy coursework will be scheduled.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 16, 1, 2, '2026-04-19 06:58:28', NULL, NULL, '2026-04-19 06:58:28', '2026-04-19 13:44:09', 3, 2, 0, 0),
(21, 12, 18, 'AI-Powered Personalized Learning Dashboard for Students', 'This idea proposes developing an AI-powered digital learning dashboard that personalizes each student’s learning experience based on their performance, behavior, and learning pace. Many students struggle with one-size-fits-all teaching methods, especially in online or hybrid environments.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 8, 0, 0, '2026-04-19 07:00:11', NULL, NULL, '2026-04-19 07:00:11', '2026-04-19 07:30:08', 2, 1, 0, 0),
(22, 12, 18, 'Offline-First Learning App for Low-Connectivity Students', 'This idea focuses on improving digital learning accessibility for students who face unstable or limited internet access. Many students struggle to attend live classes or access materials consistently due to poor connectivity, which creates learning gaps.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 8, 0, 1, '2026-04-19 07:01:35', NULL, NULL, '2026-04-19 07:01:35', '2026-04-19 07:30:04', 3, 0, 0, 0),
(23, 11, 6, '24/7 Mental Health Chatbot for Students', 'Develop an AI-powered chatbot available on the university website and mobile app to provide instant mental health support. The chatbot can answer common questions, guide students through breathing exercises, and direct them to professional services when needed. It ensures support is always accessible, especially outside office hours.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 8, 1, 0, '2026-04-19 07:05:05', NULL, NULL, '2026-04-19 07:05:05', '2026-04-19 08:00:27', 5, 0, 0, 0),
(24, 11, 6, 'Weekly “No Stress” Campus Hour', 'Introduce a weekly one-hour break across campus where no classes, meetings, or deadlines are scheduled. During this time, students can join relaxing activities like yoga, meditation, music, or art sessions to reduce stress and improve focus.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 11, 1, 0, '2026-04-19 07:06:12', NULL, NULL, '2026-04-19 07:06:12', '2026-04-19 08:13:48', 4, 1, 0, 1),
(25, 12, 6, 'Virtual Reality (VR) Classrooms for Interactive Learning', 'Introduce VR-based classrooms where students can experience immersive learning environments. For example, medical students can practice surgeries virtually, while history students can explore ancient civilizations. This will improve understanding, engagement, and practical skills without physical limitations.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 10, 0, 1, '2026-04-19 07:07:15', NULL, NULL, '2026-04-19 07:07:15', '2026-04-19 07:29:41', 2, 1, 0, 1),
(26, 12, 6, 'Smart Attendance System Using Facial Recognition', 'Implement a facial recognition system to automatically track attendance in classrooms. This reduces manual work, prevents proxy attendance, and ensures accurate records.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 14, 0, 2, '2026-04-19 07:08:03', NULL, NULL, '2026-04-19 07:08:03', '2026-04-19 07:30:54', 1, 2, 0, 0),
(27, 12, 14, 'Eco-Friendly Paperless Assignment Submission System', 'Encourage digital submission and grading of assignments to reduce paper usage. The system will include annotation tools for lecturers and version tracking for students.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 10, 0, 0, '2026-04-19 07:14:34', NULL, NULL, '2026-04-19 07:14:34', '2026-04-19 07:30:49', 2, 0, 0, 0),
(28, 12, 14, 'Centralized Internship and Job Matching Portal', 'Develop a portal that matches students with internships and job opportunities based on their skills, courses, and interests using AI recommendations.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 10, 0, 1, '2026-04-19 07:15:42', NULL, NULL, '2026-04-19 07:15:42', '2026-04-19 08:03:07', 1, 3, 0, 1),
(29, 11, 14, 'Mental Health Workshops Series', 'Organize monthly workshops on topics like anxiety management, time management, emotional resilience, and healthy lifestyle habits. These sessions can be led by professionals and open to all students.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 6, 1, 2, '2026-04-19 07:19:33', NULL, NULL, '2026-04-19 07:19:33', '2026-04-19 08:00:25', 4, 0, 0, 0),
(30, 11, 14, 'Anonymous Feedback & Help Platform', 'Create an online platform where students can anonymously share concerns, report stress factors, or request help. The system can route issues to appropriate departments for quick response.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 13, 0, 1, '2026-04-19 07:22:43', NULL, NULL, '2026-04-19 07:22:43', '2026-04-19 08:13:35', 3, 0, 0, 0),
(31, 12, 17, 'Automated Feedback Collection System for Courses', 'Develop a system that collects real-time feedback from students during the semester instead of only at the end. This allows lecturers to improve teaching methods quickly.', 'Administration', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 10, 0, 0, '2026-04-19 07:24:32', NULL, NULL, '2026-04-19 07:24:32', '2026-04-19 08:03:01', 3, 0, 0, 0),
(32, 11, 17, '“Buddy System” for New Students', 'Pair new students with senior student mentors who provide guidance, emotional support, and help them adjust to university life. This reduces loneliness and improves mental wellbeing.', 'Administration', 'Medium', '', '', 1, 'Inappropriate content', 14, '2026-04-19 07:39:18', 6, 0, 0, '2026-04-19 07:25:22', NULL, NULL, '2026-04-19 07:25:22', '2026-04-19 07:39:18', 0, 2, 0, 0),
(33, 11, 21, 'Exam Period Wellness Kits', 'Distribute wellness kits during exam seasons containing snacks, motivational notes, stress-relief items, and mental health resources. This supports students during high-pressure periods.', 'Marketing', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-19 07:36:28', NULL, NULL, '2026-04-19 07:36:28', '2026-04-19 07:36:28', 0, 0, 0, 0),
(34, 11, 18, 'Peer Support & Digital Wellbeing Program for Students', 'This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambassadors” who can provide basic peer support, promote awareness, and guide students to professional services when needed.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-19 14:52:10', NULL, NULL, '2026-04-19 14:52:10', '2026-04-19 14:52:10', 0, 0, 0, 0),
(35, 11, 18, 'Peer Support & Digital Wellbeing Program for Students', 'This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambassadors” who can provide basic peer support, promote awareness, and guide students to professional services when needed.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-19 14:52:39', NULL, NULL, '2026-04-19 14:52:39', '2026-04-19 14:52:39', 0, 0, 0, 0),
(36, 11, 18, 'The Vent Tent', 'A weekly, informal pop-up station located in high-traffic campus areas where students can grab a free coffee and talk to trained student volunteers. Unlike formal counseling, this offers a low-pressure environment for students to \"vent\" about exam stress, social anxiety, or loneliness.', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 5, 1, 1, '2026-04-19 15:02:21', NULL, NULL, '2026-04-19 15:02:21', '2026-04-19 15:05:29', 3, 0, 0, 0),
(37, 11, 29, 'Mindful Mornings: Peer-Led Meditation Circles', 'A 15-minute guided mindfulness session held every Monday and Wednesday before first class. Students take turns leading simple breathing exercises, body scans, or gratitude journaling. Promotes calm and connection before academic stress begins.', 'IMS', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-20 13:41:39', NULL, NULL, '2026-04-20 13:41:39', '2026-04-20 13:41:39', 0, 0, 0, 0),
(38, 11, 29, 'Stress Less Exam Kits', 'Distribute free kits during midterms and finals containing earplugs, herbal tea, a stress ball, a study schedule template, and a list of campus mental health resources. Designed to reduce last-minute panic and encourage self-care.', 'IMS', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-20 13:42:36', NULL, NULL, '2026-04-20 13:42:36', '2026-04-20 13:42:36', 0, 0, 0, 0),
(39, 11, 29, 'Anonymous Story Wall', 'A physical and digital bulletin board where students can anonymously post short experiences about mental health struggles, recovery, or encouragement. Updated weekly. Reduces stigma by showing that no one is alone in their challenges.', 'IMS', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-20 13:45:09', NULL, NULL, '2026-04-20 13:45:09', '2026-04-20 13:45:09', 0, 0, 0, 0),
(40, 11, 29, 'Faculty–Student Mental Health First Aid Training', 'A 2-hour workshop for professors and TAs to recognize warning signs (e.g., withdrawal, sudden grade drops) and respond with empathy. Includes role-play scenarios and referral pathways. Builds a supportive academic environment.', 'IMS', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-20 13:46:04', NULL, NULL, '2026-04-20 13:46:04', '2026-04-20 13:46:04', 0, 0, 0, 0),
(41, 11, 30, 'Creative Coping: Art & Music Therapy Pop-Ups', 'Weekly drop-in sessions in the student lounge with coloring sheets, clay, collage materials, and a keyboard. No art skills needed. Students create while listening to lo-fi beats – proven to lower cortisol levels.', 'IMS', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-20 13:47:54', NULL, NULL, '2026-04-20 13:47:54', '2026-04-20 13:47:54', 0, 0, 0, 0),
(42, 11, 30, 'Night Line: Student-Run Peer Listening Service', 'A confidential hotline (8 PM–12 AM) staffed by trained student volunteers. Offers non-judgmental listening, crisis resource referral, and “warm handoffs” to counseling services. Expands access for evening loneliness or panic attacks.', 'IMS', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-20 13:48:40', NULL, NULL, '2026-04-20 13:48:40', '2026-04-20 13:48:40', 0, 0, 0, 0),
(43, 11, 30, 'Mind & Body Walk & Talk', 'A guided 30-minute walk around campus followed by 30 minutes of open conversation under a tree. Combines light exercise (boosts endorphins) with organic social connection. No pressure to share – just walking together helps.', 'IMS', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-20 13:51:02', NULL, NULL, '2026-04-20 13:51:02', '2026-04-20 13:51:02', 0, 0, 0, 0),
(44, 11, 30, 'Digital Detox Challenge', 'A 24-hour opt-in challenge where students put their phones on grayscale and log screen-free activities (reading, cooking, chatting). Participants get a small prize and a reflection sheet. Raises awareness of social media’s impact on mood.', 'IMS', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-04-20 13:51:38', NULL, NULL, '2026-04-20 13:51:38', '2026-04-20 13:51:38', 0, 0, 0, 0);

--
-- Triggers `ideas`
--
DELIMITER $$
CREATE TRIGGER `tr_update_staff_submission_on_idea_insert` AFTER INSERT ON `ideas` FOR EACH ROW BEGIN
  DECLARE v_department VARCHAR(100);
  DECLARE v_staff_id INT;

  -- ideas.contributor_id points to contributors.id (not staff.id)
  -- map contributor -> staff by email
  SELECT c.department, s.id
    INTO v_department, v_staff_id
  FROM contributors c
  JOIN staff s ON s.email = c.email
  WHERE c.id = NEW.contributor_id
  LIMIT 1;

  -- if no matching staff row, skip tracking
  IF v_staff_id IS NOT NULL THEN
    INSERT INTO staff_submission_tracking
      (session_id, department, staff_id, has_submitted, first_submission_date, idea_count, last_idea_date)
    VALUES
      (NEW.session_id, COALESCE(v_department, 'Unknown'), v_staff_id, TRUE, NOW(), 1, NOW())
    ON DUPLICATE KEY UPDATE
      has_submitted = TRUE,
      idea_count = idea_count + 1,
      last_idea_date = NOW();
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `idea_attachments`
--

CREATE TABLE `idea_attachments` (
  `id` int(11) NOT NULL,
  `idea_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_by_contributor_id` int(11) DEFAULT NULL,
  `is_flagged` tinyint(1) DEFAULT 0,
  `flagged_reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `idea_attachments`
--

INSERT INTO `idea_attachments` (`id`, `idea_id`, `file_name`, `file_path`, `file_type`, `file_size`, `uploaded_by_contributor_id`, `is_flagged`, `flagged_reason`, `created_at`) VALUES
(1, 1, 'dashboard-wireframe.pdf', '/uploads/ideas/dashboard-wireframe.pdf', 'application/pdf', 428512, 1, 0, NULL, '2026-03-17 03:20:00'),
(2, 2, 'testing-checklist.xlsx', '/uploads/ideas/testing-checklist.xlsx', 'application/vnd.openxmlformats-officedocument.spre', 132448, 2, 0, NULL, '2026-03-17 04:05:00'),
(3, 1, 'mockup.png', '/uploads/ideas/mockup.png', 'image/png', 245981, 1, 0, NULL, '2026-03-18 02:40:00'),
(4, 14, 'download.jpg', 'uploads/ideas/14/1774346925_1e8863f3_download.jpg', 'jpg', 4919, 16, 0, NULL, '2026-03-24 10:08:45'),
(5, 15, 'test.xlsx', 'uploads/ideas/15/1774349454_45217c63_test.xlsx', 'xlsx', 8744, 6, 0, NULL, '2026-03-24 10:50:54'),
(6, 15, 'Test.docx', 'uploads/ideas/15/1774349454_ee48e904_Test.docx', 'docx', 13349, 6, 0, NULL, '2026-03-24 10:50:54'),
(7, 15, 'download.jpg', 'uploads/ideas/15/1774349454_c38cd92d_download.jpg', 'jpg', 4919, 6, 0, NULL, '2026-03-24 10:50:54'),
(8, 15, 'Individual Report 01 (1).pdf', 'uploads/ideas/15/1774349454_54f922f3_Individual_Report_01__1_.pdf', 'pdf', 1644763, 6, 0, NULL, '2026-03-24 10:50:54'),
(9, 17, 'csi.jpg', 'uploads/ideas/17/1776487733_827c1ff4_csi.jpg', 'jpg', 352664, 6, 0, NULL, '2026-04-18 04:48:53'),
(10, 17, 'test.xlsx', 'uploads/ideas/17/1776487733_b03ffca3_test.xlsx', 'xlsx', 8744, 6, 0, NULL, '2026-04-18 04:48:53'),
(11, 17, 'Test.docx', 'uploads/ideas/17/1776487733_3c0a9307_Test.docx', 'docx', 13349, 6, 0, NULL, '2026-04-18 04:48:53'),
(12, 17, 'download.jpg', 'uploads/ideas/17/1776487733_be5b0fe8_download.jpg', 'jpg', 4919, 6, 0, NULL, '2026-04-18 04:48:53'),
(13, 18, 'image.png', 'uploads/ideas/18/1776495031_ca822bcd_image.png', 'png', 68263, 6, 0, NULL, '2026-04-18 06:50:31'),
(14, 20, 'test.xlsx', 'uploads/ideas/20/1776581917_47438735_test.xlsx', 'xlsx', 8744, 18, 0, NULL, '2026-04-19 06:58:37'),
(15, 20, 'Test.docx', 'uploads/ideas/20/1776581917_225e2223_Test.docx', 'docx', 13349, 18, 0, NULL, '2026-04-19 06:58:37'),
(16, 20, 'download.jpg', 'uploads/ideas/20/1776581917_f4314423_download.jpg', 'jpg', 4919, 18, 0, NULL, '2026-04-19 06:58:37'),
(17, 20, 'Individual Report 01 (1).pdf', 'uploads/ideas/20/1776581917_b24a4847_Individual_Report_01__1_.pdf', 'pdf', 1644763, 18, 0, NULL, '2026-04-19 06:58:37'),
(18, 22, 'test.xlsx', 'uploads/ideas/22/1776582104_7ba76fb8_test.xlsx', 'xlsx', 8744, 18, 0, NULL, '2026-04-19 07:01:44'),
(19, 22, 'Test.docx', 'uploads/ideas/22/1776582104_eb97bd94_Test.docx', 'docx', 13349, 18, 0, NULL, '2026-04-19 07:01:44'),
(20, 22, 'download.jpg', 'uploads/ideas/22/1776582104_6def621b_download.jpg', 'jpg', 4919, 18, 0, NULL, '2026-04-19 07:01:44'),
(21, 24, 'test.xlsx', 'uploads/ideas/24/1776582381_f97faaa0_test.xlsx', 'xlsx', 8744, 6, 0, NULL, '2026-04-19 07:06:21'),
(22, 24, 'Test.docx', 'uploads/ideas/24/1776582381_9ce24203_Test.docx', 'docx', 13349, 6, 0, NULL, '2026-04-19 07:06:21'),
(23, 25, 'test.xlsx', 'uploads/ideas/25/1776582444_84e36789_test.xlsx', 'xlsx', 8744, 6, 0, NULL, '2026-04-19 07:07:24'),
(24, 25, 'Test.docx', 'uploads/ideas/25/1776582444_bc611aea_Test.docx', 'docx', 13349, 6, 0, NULL, '2026-04-19 07:07:24'),
(25, 26, 'test.xlsx', 'uploads/ideas/26/1776582493_cdd1be59_test.xlsx', 'xlsx', 8744, 6, 0, NULL, '2026-04-19 07:08:13'),
(26, 26, 'Test.docx', 'uploads/ideas/26/1776582493_76327f85_Test.docx', 'docx', 13349, 6, 0, NULL, '2026-04-19 07:08:13'),
(27, 26, 'download.jpg', 'uploads/ideas/26/1776582493_cedc08cf_download.jpg', 'jpg', 4919, 6, 0, NULL, '2026-04-19 07:08:13'),
(28, 28, 'test.xlsx', 'uploads/ideas/28/1776582952_e56dafd3_test.xlsx', 'xlsx', 8744, 14, 0, NULL, '2026-04-19 07:15:52'),
(29, 28, 'Test.docx', 'uploads/ideas/28/1776582952_4d23f763_Test.docx', 'docx', 13349, 14, 0, NULL, '2026-04-19 07:15:52'),
(30, 29, 'image.png', 'uploads/ideas/29/1776583183_bf4f37d7_image.png', 'png', 68263, 14, 0, NULL, '2026-04-19 07:19:43'),
(31, 29, 'download.jpg', 'uploads/ideas/29/1776583183_a5294dc4_download.jpg', 'jpg', 4919, 14, 0, NULL, '2026-04-19 07:19:43'),
(32, 31, 'test.xlsx', 'uploads/ideas/31/1776583482_6a997288_test.xlsx', 'xlsx', 8744, 17, 0, NULL, '2026-04-19 07:24:42'),
(33, 31, 'Test.docx', 'uploads/ideas/31/1776583482_920fb2de_Test.docx', 'docx', 13349, 17, 0, NULL, '2026-04-19 07:24:42'),
(34, 31, 'download.jpg', 'uploads/ideas/31/1776583482_c7b0a187_download.jpg', 'jpg', 4919, 17, 0, NULL, '2026-04-19 07:24:42');

-- --------------------------------------------------------

--
-- Table structure for table `idea_categories`
--

CREATE TABLE `idea_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `idea_categories`
--

INSERT INTO `idea_categories` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Technology', 'Technology and innovation ideas', 1, '2026-03-17 12:28:14', '2026-03-17 12:28:14'),
(2, 'Social Impact', 'Ideas for social good', 1, '2026-03-17 12:28:14', '2026-03-17 12:28:14'),
(3, 'Sustainability', 'Environmental and sustainability initiatives', 1, '2026-03-17 12:28:14', '2026-03-17 12:28:14'),
(4, 'Business', 'Business and entrepreneurship ideas', 1, '2026-03-17 12:28:14', '2026-03-17 12:28:14'),
(7, 'Education', 'Ideas related to improving education systems, learning methods, e-learning platforms, and student support.', 1, '2026-04-19 03:44:01', '2026-04-19 03:44:01'),
(8, 'Health', 'Ideas focused on physical health, mental health, fitness, healthcare services, and overall well-being.', 1, '2026-04-19 03:44:16', '2026-04-19 03:44:16');

-- --------------------------------------------------------

--
-- Table structure for table `idea_category_tags`
--

CREATE TABLE `idea_category_tags` (
  `id` int(11) NOT NULL,
  `idea_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `tagged_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `idea_category_tags`
--

INSERT INTO `idea_category_tags` (`id`, `idea_id`, `category_id`, `tagged_at`) VALUES
(1, 6, 4, '2026-03-21 05:43:28'),
(2, 7, 4, '2026-03-21 06:50:02'),
(3, 8, 3, '2026-03-21 06:58:08'),
(4, 9, 1, '2026-03-21 09:05:11'),
(5, 10, 2, '2026-03-22 05:29:02'),
(6, 11, 1, '2026-03-22 06:03:05'),
(7, 12, 2, '2026-03-22 13:46:16'),
(8, 13, 2, '2026-03-24 09:37:30'),
(9, 14, 4, '2026-03-24 10:08:41'),
(10, 15, 2, '2026-03-24 10:50:46'),
(11, 16, 2, '2026-04-18 04:48:07'),
(12, 17, 2, '2026-04-18 04:48:43'),
(13, 17, 3, '2026-04-18 04:48:43'),
(14, 18, 4, '2026-04-18 06:50:23'),
(15, 19, 8, '2026-04-19 06:56:09'),
(16, 19, 7, '2026-04-19 06:56:09'),
(17, 20, 8, '2026-04-19 06:58:28'),
(18, 20, 2, '2026-04-19 06:58:28'),
(19, 21, 7, '2026-04-19 07:00:11'),
(20, 21, 1, '2026-04-19 07:00:11'),
(21, 22, 7, '2026-04-19 07:01:35'),
(22, 22, 2, '2026-04-19 07:01:35'),
(23, 22, 1, '2026-04-19 07:01:35'),
(24, 23, 8, '2026-04-19 07:05:05'),
(25, 23, 1, '2026-04-19 07:05:05'),
(26, 24, 8, '2026-04-19 07:06:12'),
(27, 24, 2, '2026-04-19 07:06:12'),
(28, 25, 7, '2026-04-19 07:07:15'),
(29, 25, 1, '2026-04-19 07:07:15'),
(30, 26, 1, '2026-04-19 07:08:03'),
(31, 27, 3, '2026-04-19 07:14:34'),
(32, 27, 7, '2026-04-19 07:14:34'),
(33, 28, 4, '2026-04-19 07:15:42'),
(34, 28, 1, '2026-04-19 07:15:42'),
(35, 29, 8, '2026-04-19 07:19:33'),
(36, 29, 7, '2026-04-19 07:19:33'),
(37, 30, 2, '2026-04-19 07:22:43'),
(38, 30, 1, '2026-04-19 07:22:43'),
(39, 30, 8, '2026-04-19 07:22:43'),
(40, 31, 7, '2026-04-19 07:24:32'),
(41, 31, 1, '2026-04-19 07:24:32'),
(42, 32, 7, '2026-04-19 07:25:22'),
(43, 32, 2, '2026-04-19 07:25:22'),
(44, 33, 7, '2026-04-19 07:36:28'),
(45, 33, 8, '2026-04-19 07:36:28'),
(46, 33, 2, '2026-04-19 07:36:28'),
(47, 34, 2, '2026-04-19 14:52:10'),
(48, 34, 1, '2026-04-19 14:52:10'),
(49, 35, 2, '2026-04-19 14:52:39'),
(50, 35, 1, '2026-04-19 14:52:39'),
(51, 36, 7, '2026-04-19 15:02:21'),
(52, 36, 2, '2026-04-19 15:02:21'),
(53, 37, 3, '2026-04-20 13:41:39'),
(54, 37, 1, '2026-04-20 13:41:39'),
(55, 38, 8, '2026-04-20 13:42:36'),
(56, 38, 2, '2026-04-20 13:42:36'),
(57, 39, 2, '2026-04-20 13:45:09'),
(58, 39, 7, '2026-04-20 13:45:09'),
(59, 40, 7, '2026-04-20 13:46:04'),
(60, 40, 8, '2026-04-20 13:46:04'),
(61, 41, 8, '2026-04-20 13:47:54'),
(62, 41, 2, '2026-04-20 13:47:54'),
(63, 42, 8, '2026-04-20 13:48:40'),
(64, 42, 1, '2026-04-20 13:48:40'),
(65, 43, 8, '2026-04-20 13:51:02'),
(66, 43, 2, '2026-04-20 13:51:02'),
(67, 43, 7, '2026-04-20 13:51:02'),
(68, 44, 8, '2026-04-20 13:51:38'),
(69, 44, 7, '2026-04-20 13:51:38');

-- --------------------------------------------------------

--
-- Table structure for table `idea_views`
--

CREATE TABLE `idea_views` (
  `id` int(11) NOT NULL,
  `idea_id` int(11) NOT NULL,
  `viewer_id` int(11) DEFAULT NULL,
  `viewer_email` varchar(100) DEFAULT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `idea_views`
--

INSERT INTO `idea_views` (`id`, `idea_id`, `viewer_id`, `viewer_email`, `viewed_at`) VALUES
(1, 2, 6, NULL, '2026-03-20 08:16:31'),
(2, 2, 6, NULL, '2026-03-20 08:16:31'),
(3, 2, 6, NULL, '2026-03-20 08:16:34'),
(4, 2, 6, NULL, '2026-03-20 08:16:34'),
(5, 1, 6, NULL, '2026-03-20 08:16:42'),
(6, 1, 6, NULL, '2026-03-20 08:16:42'),
(7, 2, 6, NULL, '2026-03-20 10:44:44'),
(8, 2, 6, NULL, '2026-03-20 10:44:44'),
(9, 1, 6, NULL, '2026-03-20 10:45:08'),
(10, 1, 6, NULL, '2026-03-20 10:45:08'),
(11, 1, 6, NULL, '2026-03-20 10:45:24'),
(12, 1, 6, NULL, '2026-03-20 10:45:24'),
(13, 2, 6, NULL, '2026-03-20 10:45:54'),
(14, 2, 6, NULL, '2026-03-20 10:45:54'),
(15, 1, 6, NULL, '2026-03-20 10:46:02'),
(16, 1, 6, NULL, '2026-03-20 10:46:02'),
(17, 1, 6, NULL, '2026-03-20 10:46:06'),
(18, 1, 6, NULL, '2026-03-20 10:46:06'),
(19, 2, 14, NULL, '2026-03-21 05:24:39'),
(20, 2, 14, NULL, '2026-03-21 05:24:39'),
(21, 1, 14, NULL, '2026-03-21 05:24:46'),
(22, 1, 14, NULL, '2026-03-21 05:24:46'),
(23, 7, 13, NULL, '2026-03-21 06:51:07'),
(24, 8, 13, NULL, '2026-03-21 07:03:27'),
(25, 8, 14, NULL, '2026-03-21 08:41:10'),
(26, 8, 14, NULL, '2026-03-21 08:41:10'),
(27, 2, 13, NULL, '2026-03-21 08:59:00'),
(28, 8, 13, NULL, '2026-03-21 09:00:47'),
(29, 7, 6, NULL, '2026-03-21 09:02:15'),
(30, 7, 6, NULL, '2026-03-21 09:02:15'),
(31, 2, 6, NULL, '2026-03-21 09:04:06'),
(32, 2, 6, NULL, '2026-03-21 09:04:06'),
(33, 9, 13, NULL, '2026-03-21 09:06:09'),
(34, 9, 13, NULL, '2026-03-21 09:06:32'),
(35, 9, 13, NULL, '2026-03-21 09:06:35'),
(36, 9, 6, NULL, '2026-03-21 09:07:03'),
(37, 9, 6, NULL, '2026-03-21 09:07:03'),
(38, 9, 6, NULL, '2026-03-21 09:09:35'),
(39, 9, 6, NULL, '2026-03-21 09:09:35'),
(40, 2, 13, NULL, '2026-03-22 05:44:43'),
(41, 2, 13, NULL, '2026-03-22 05:44:54'),
(42, 2, 13, NULL, '2026-03-22 05:57:41'),
(43, 2, 13, NULL, '2026-03-22 05:58:02'),
(44, 10, 13, NULL, '2026-03-22 05:58:19'),
(45, 10, 13, NULL, '2026-03-22 05:58:27'),
(46, 10, 13, NULL, '2026-03-22 05:58:29'),
(47, 11, 13, NULL, '2026-03-22 06:03:27'),
(48, 11, 13, NULL, '2026-03-22 06:04:58'),
(49, 2, 13, NULL, '2026-03-22 13:41:25'),
(50, 12, 13, NULL, '2026-03-22 13:51:28'),
(51, 12, 13, NULL, '2026-03-22 13:52:33'),
(52, 12, 13, NULL, '2026-03-22 13:52:39'),
(53, 7, 14, NULL, '2026-03-23 05:37:26'),
(54, 7, 14, NULL, '2026-03-23 05:37:26'),
(55, 13, 14, NULL, '2026-03-24 09:37:47'),
(56, 13, 14, NULL, '2026-03-24 09:37:47'),
(57, 14, 15, NULL, '2026-03-24 10:10:35'),
(58, 15, 6, NULL, '2026-03-24 10:50:57'),
(59, 15, 6, NULL, '2026-03-24 10:50:57'),
(60, 14, 17, NULL, '2026-03-25 10:15:47'),
(61, 14, 17, NULL, '2026-03-25 10:15:47'),
(62, 15, 15, NULL, '2026-03-25 10:16:24'),
(63, 15, 15, NULL, '2026-03-25 10:16:40'),
(64, 15, 15, NULL, '2026-03-25 10:16:51'),
(65, 14, 15, NULL, '2026-03-25 10:18:24'),
(66, 14, 15, NULL, '2026-03-25 10:18:56'),
(67, 14, 15, NULL, '2026-03-25 10:21:08'),
(68, 14, 15, NULL, '2026-03-25 10:21:21'),
(69, 14, 15, NULL, '2026-03-25 10:21:24'),
(70, 14, 15, NULL, '2026-03-25 10:21:31'),
(71, 7, 14, NULL, '2026-03-25 10:22:05'),
(72, 7, 14, NULL, '2026-03-25 10:22:05'),
(73, 14, 15, NULL, '2026-03-25 10:22:46'),
(74, 13, 15, NULL, '2026-03-25 10:23:01'),
(75, 15, 15, NULL, '2026-03-25 10:23:11'),
(76, 15, 15, NULL, '2026-03-25 10:23:18'),
(77, 15, 15, NULL, '2026-03-25 10:23:30'),
(78, 14, 15, NULL, '2026-03-25 10:23:41'),
(79, 14, 15, NULL, '2026-03-25 10:23:47'),
(80, 14, 15, NULL, '2026-03-25 10:23:53'),
(81, 14, 15, NULL, '2026-03-25 10:24:14'),
(82, 14, 15, NULL, '2026-03-25 10:24:18'),
(83, 14, 15, NULL, '2026-03-25 10:24:21'),
(84, 14, 15, NULL, '2026-03-25 10:24:26'),
(85, 14, 15, NULL, '2026-03-25 10:25:09'),
(86, 14, 15, NULL, '2026-03-25 10:25:48'),
(87, 14, 15, NULL, '2026-03-25 10:25:51'),
(88, 15, 15, NULL, '2026-03-25 10:26:14'),
(89, 15, 15, NULL, '2026-03-25 10:26:18'),
(90, 15, 15, NULL, '2026-03-25 10:26:23'),
(91, 15, 15, NULL, '2026-03-25 10:26:26'),
(92, 15, 15, NULL, '2026-03-25 10:26:40'),
(93, 9, 15, NULL, '2026-03-25 10:26:54'),
(94, 9, 15, NULL, '2026-03-25 10:26:56'),
(95, 11, 15, NULL, '2026-03-25 10:27:03'),
(96, 11, 15, NULL, '2026-03-25 10:27:07'),
(97, 11, 15, NULL, '2026-03-25 10:27:13'),
(98, 14, 15, NULL, '2026-03-25 10:27:16'),
(99, 14, 15, NULL, '2026-03-25 10:27:19'),
(100, 14, 15, NULL, '2026-03-25 10:27:22'),
(101, 14, 15, NULL, '2026-03-25 10:27:29'),
(102, 15, 15, NULL, '2026-03-25 10:30:12'),
(103, 14, 15, NULL, '2026-03-25 10:30:25'),
(104, 14, 15, NULL, '2026-03-25 10:30:27'),
(105, 15, 15, NULL, '2026-03-25 10:34:07'),
(106, 4, 15, NULL, '2026-03-25 10:54:36'),
(107, 15, 15, NULL, '2026-03-25 10:58:08'),
(108, 7, 6, NULL, '2026-03-25 11:07:39'),
(109, 7, 6, NULL, '2026-03-25 11:07:39'),
(110, 13, 6, NULL, '2026-03-25 11:08:12'),
(111, 13, 6, NULL, '2026-03-25 11:08:12'),
(112, 13, 6, NULL, '2026-03-25 11:10:11'),
(113, 13, 6, NULL, '2026-03-25 11:10:11'),
(114, 8, 6, NULL, '2026-03-25 11:10:23'),
(115, 8, 6, NULL, '2026-03-25 11:10:23'),
(116, 13, 6, NULL, '2026-03-25 11:11:31'),
(117, 13, 6, NULL, '2026-03-25 11:11:31'),
(118, 13, 6, NULL, '2026-03-25 11:15:20'),
(119, 13, 6, NULL, '2026-03-25 11:15:20'),
(120, 13, 6, NULL, '2026-03-25 11:17:24'),
(121, 13, 6, NULL, '2026-03-25 11:17:24'),
(122, 8, 6, NULL, '2026-03-25 11:17:41'),
(123, 8, 6, NULL, '2026-03-25 11:17:41'),
(124, 7, 6, NULL, '2026-03-25 11:17:46'),
(125, 7, 6, NULL, '2026-03-25 11:17:46'),
(126, 6, 6, NULL, '2026-03-25 11:17:50'),
(127, 6, 6, NULL, '2026-03-25 11:17:50'),
(128, 13, 6, NULL, '2026-03-25 11:19:21'),
(129, 13, 6, NULL, '2026-03-25 11:19:21'),
(130, 8, 6, NULL, '2026-03-25 11:19:25'),
(131, 8, 6, NULL, '2026-03-25 11:19:25'),
(132, 13, 6, NULL, '2026-03-25 11:20:26'),
(133, 13, 6, NULL, '2026-03-25 11:20:26'),
(134, 8, 6, NULL, '2026-03-25 11:20:31'),
(135, 8, 6, NULL, '2026-03-25 11:20:31'),
(136, 7, 6, NULL, '2026-03-25 11:20:34'),
(137, 7, 6, NULL, '2026-03-25 11:20:34'),
(138, 6, 6, NULL, '2026-03-25 11:20:36'),
(139, 6, 6, NULL, '2026-03-25 11:20:36'),
(140, 13, 6, NULL, '2026-03-25 11:20:39'),
(141, 13, 6, NULL, '2026-03-25 11:20:39'),
(142, 13, 6, NULL, '2026-03-25 11:21:57'),
(143, 13, 6, NULL, '2026-03-25 11:21:57'),
(144, 8, 6, NULL, '2026-03-25 11:23:28'),
(145, 8, 6, NULL, '2026-03-25 11:23:28'),
(146, 13, 14, NULL, '2026-03-25 11:24:22'),
(147, 13, 14, NULL, '2026-03-25 11:24:22'),
(148, 13, 14, NULL, '2026-03-25 11:25:27'),
(149, 13, 14, NULL, '2026-03-25 11:25:27'),
(150, 13, 14, NULL, '2026-03-25 11:25:35'),
(151, 13, 14, NULL, '2026-03-25 11:25:35'),
(152, 7, 14, NULL, '2026-03-25 11:25:39'),
(153, 7, 14, NULL, '2026-03-25 11:25:39'),
(154, 6, 14, NULL, '2026-03-25 11:25:42'),
(155, 6, 14, NULL, '2026-03-25 11:25:42'),
(156, 13, 14, NULL, '2026-03-25 11:26:59'),
(157, 13, 14, NULL, '2026-03-25 11:26:59'),
(158, 13, 6, NULL, '2026-03-25 11:27:23'),
(159, 13, 6, NULL, '2026-03-25 11:27:23'),
(160, 13, 6, NULL, '2026-03-25 11:30:11'),
(161, 13, 6, NULL, '2026-03-25 11:30:11'),
(162, 13, 14, NULL, '2026-03-25 11:30:27'),
(163, 13, 14, NULL, '2026-03-25 11:30:27'),
(164, 13, 6, NULL, '2026-03-29 10:15:03'),
(165, 13, 6, NULL, '2026-03-29 10:15:03'),
(166, 13, 6, NULL, '2026-04-18 04:41:36'),
(167, 13, 6, NULL, '2026-04-18 04:41:36'),
(168, 17, 6, NULL, '2026-04-18 04:48:55'),
(169, 17, 6, NULL, '2026-04-18 04:48:55'),
(170, 17, 15, NULL, '2026-04-18 06:03:33'),
(171, 15, 15, NULL, '2026-04-18 06:03:41'),
(172, 14, 15, NULL, '2026-04-18 06:03:47'),
(173, 12, 15, NULL, '2026-04-18 06:03:50'),
(174, 11, 15, NULL, '2026-04-18 06:03:52'),
(175, 13, 15, NULL, '2026-04-18 06:03:54'),
(176, 8, 15, NULL, '2026-04-18 06:03:57'),
(177, 7, 15, NULL, '2026-04-18 06:04:00'),
(178, 15, 15, NULL, '2026-04-18 06:04:10'),
(179, 18, 6, NULL, '2026-04-18 07:05:30'),
(180, 18, 6, NULL, '2026-04-18 07:05:30'),
(181, 18, 6, NULL, '2026-04-18 07:07:53'),
(182, 18, 6, NULL, '2026-04-18 07:07:53'),
(183, 18, 6, NULL, '2026-04-18 07:08:00'),
(184, 18, 6, NULL, '2026-04-18 07:08:00'),
(185, 13, 6, NULL, '2026-04-18 07:08:08'),
(186, 13, 6, NULL, '2026-04-18 07:08:08'),
(187, 16, 6, NULL, '2026-04-18 07:08:23'),
(188, 16, 6, NULL, '2026-04-18 07:08:23'),
(189, 18, 15, NULL, '2026-04-19 03:50:00'),
(190, 18, 15, NULL, '2026-04-19 05:18:41'),
(191, 18, 15, NULL, '2026-04-19 05:19:06'),
(192, 16, 15, NULL, '2026-04-19 05:19:09'),
(193, 18, 15, NULL, '2026-04-19 05:28:06'),
(194, 18, 15, NULL, '2026-04-19 05:28:47'),
(195, 19, 18, NULL, '2026-04-19 06:56:24'),
(196, 19, 18, NULL, '2026-04-19 06:56:24'),
(197, 21, 18, NULL, '2026-04-19 07:00:27'),
(198, 21, 18, NULL, '2026-04-19 07:00:27'),
(199, 22, 6, NULL, '2026-04-19 07:02:14'),
(200, 22, 6, NULL, '2026-04-19 07:02:14'),
(201, 21, 6, NULL, '2026-04-19 07:02:20'),
(202, 21, 6, NULL, '2026-04-19 07:02:20'),
(203, 20, 6, NULL, '2026-04-19 07:02:25'),
(204, 20, 6, NULL, '2026-04-19 07:02:25'),
(205, 19, 6, NULL, '2026-04-19 07:02:30'),
(206, 19, 6, NULL, '2026-04-19 07:02:31'),
(207, 26, 6, NULL, '2026-04-19 07:08:23'),
(208, 26, 6, NULL, '2026-04-19 07:08:23'),
(209, 25, 6, NULL, '2026-04-19 07:08:28'),
(210, 25, 6, NULL, '2026-04-19 07:08:28'),
(211, 24, 6, NULL, '2026-04-19 07:08:34'),
(212, 24, 6, NULL, '2026-04-19 07:08:34'),
(213, 23, 6, NULL, '2026-04-19 07:08:37'),
(214, 23, 6, NULL, '2026-04-19 07:08:37'),
(215, 20, 6, NULL, '2026-04-19 07:08:42'),
(216, 20, 6, NULL, '2026-04-19 07:08:42'),
(217, 19, 6, NULL, '2026-04-19 07:08:45'),
(218, 19, 6, NULL, '2026-04-19 07:08:45'),
(219, 25, 6, NULL, '2026-04-19 07:09:54'),
(220, 25, 6, NULL, '2026-04-19 07:09:54'),
(221, 26, 6, NULL, '2026-04-19 07:10:34'),
(222, 26, 6, NULL, '2026-04-19 07:10:34'),
(223, 26, 6, NULL, '2026-04-19 07:11:22'),
(224, 26, 6, NULL, '2026-04-19 07:11:22'),
(225, 20, 6, NULL, '2026-04-19 07:11:35'),
(226, 20, 6, NULL, '2026-04-19 07:11:35'),
(227, 19, 6, NULL, '2026-04-19 07:12:04'),
(228, 19, 6, NULL, '2026-04-19 07:12:04'),
(229, 24, 6, NULL, '2026-04-19 07:12:47'),
(230, 24, 6, NULL, '2026-04-19 07:12:47'),
(231, 23, 6, NULL, '2026-04-19 07:12:50'),
(232, 23, 6, NULL, '2026-04-19 07:12:50'),
(233, 20, 6, NULL, '2026-04-19 07:12:52'),
(234, 20, 6, NULL, '2026-04-19 07:12:52'),
(235, 19, 6, NULL, '2026-04-19 07:12:55'),
(236, 19, 6, NULL, '2026-04-19 07:12:55'),
(237, 26, 14, NULL, '2026-04-19 07:13:15'),
(238, 26, 14, NULL, '2026-04-19 07:13:15'),
(239, 25, 14, NULL, '2026-04-19 07:13:20'),
(240, 25, 14, NULL, '2026-04-19 07:13:20'),
(241, 22, 14, NULL, '2026-04-19 07:13:24'),
(242, 22, 14, NULL, '2026-04-19 07:13:24'),
(243, 21, 14, NULL, '2026-04-19 07:13:27'),
(244, 21, 14, NULL, '2026-04-19 07:13:27'),
(245, 24, 14, NULL, '2026-04-19 07:13:34'),
(246, 24, 14, NULL, '2026-04-19 07:13:35'),
(247, 23, 14, NULL, '2026-04-19 07:13:37'),
(248, 23, 14, NULL, '2026-04-19 07:13:37'),
(249, 20, 14, NULL, '2026-04-19 07:13:40'),
(250, 20, 14, NULL, '2026-04-19 07:13:41'),
(251, 19, 14, NULL, '2026-04-19 07:13:45'),
(252, 19, 14, NULL, '2026-04-19 07:13:45'),
(253, 28, 14, NULL, '2026-04-19 07:16:06'),
(254, 28, 14, NULL, '2026-04-19 07:16:06'),
(255, 27, 14, NULL, '2026-04-19 07:16:13'),
(256, 27, 14, NULL, '2026-04-19 07:16:13'),
(257, 28, 14, NULL, '2026-04-19 07:16:41'),
(258, 28, 14, NULL, '2026-04-19 07:16:41'),
(259, 26, 14, NULL, '2026-04-19 07:17:15'),
(260, 26, 14, NULL, '2026-04-19 07:17:15'),
(261, 22, 14, NULL, '2026-04-19 07:17:43'),
(262, 22, 14, NULL, '2026-04-19 07:17:43'),
(263, 25, 14, NULL, '2026-04-19 07:18:20'),
(264, 25, 14, NULL, '2026-04-19 07:18:20'),
(265, 29, 14, NULL, '2026-04-19 07:19:57'),
(266, 29, 14, NULL, '2026-04-19 07:19:57'),
(267, 30, 14, NULL, '2026-04-19 07:23:15'),
(268, 30, 14, NULL, '2026-04-19 07:23:15'),
(269, 32, 17, NULL, '2026-04-19 07:25:43'),
(270, 32, 17, NULL, '2026-04-19 07:25:43'),
(271, 30, 17, NULL, '2026-04-19 07:25:46'),
(272, 30, 17, NULL, '2026-04-19 07:25:46'),
(273, 31, 17, NULL, '2026-04-19 07:25:56'),
(274, 31, 17, NULL, '2026-04-19 07:25:56'),
(275, 28, 17, NULL, '2026-04-19 07:26:01'),
(276, 28, 17, NULL, '2026-04-19 07:26:01'),
(277, 27, 17, NULL, '2026-04-19 07:26:05'),
(278, 27, 17, NULL, '2026-04-19 07:26:06'),
(279, 30, 17, NULL, '2026-04-19 07:26:22'),
(280, 30, 17, NULL, '2026-04-19 07:26:22'),
(281, 29, 17, NULL, '2026-04-19 07:26:53'),
(282, 29, 17, NULL, '2026-04-19 07:26:53'),
(283, 31, 21, NULL, '2026-04-19 07:27:53'),
(284, 31, 21, NULL, '2026-04-19 07:27:53'),
(285, 25, 21, NULL, '2026-04-19 07:29:38'),
(286, 25, 21, NULL, '2026-04-19 07:29:38'),
(287, 26, 21, NULL, '2026-04-19 07:29:42'),
(288, 26, 21, NULL, '2026-04-19 07:29:42'),
(289, 27, 21, NULL, '2026-04-19 07:29:47'),
(290, 27, 21, NULL, '2026-04-19 07:29:47'),
(291, 27, 21, NULL, '2026-04-19 07:29:50'),
(292, 27, 21, NULL, '2026-04-19 07:29:51'),
(293, 28, 21, NULL, '2026-04-19 07:29:53'),
(294, 28, 21, NULL, '2026-04-19 07:29:54'),
(295, 31, 21, NULL, '2026-04-19 07:29:57'),
(296, 31, 21, NULL, '2026-04-19 07:29:58'),
(297, 22, 21, NULL, '2026-04-19 07:30:03'),
(298, 22, 21, NULL, '2026-04-19 07:30:03'),
(299, 21, 21, NULL, '2026-04-19 07:30:07'),
(300, 21, 21, NULL, '2026-04-19 07:30:07'),
(301, 32, 21, NULL, '2026-04-19 07:30:14'),
(302, 32, 21, NULL, '2026-04-19 07:30:14'),
(303, 30, 21, NULL, '2026-04-19 07:30:17'),
(304, 30, 21, NULL, '2026-04-19 07:30:17'),
(305, 29, 21, NULL, '2026-04-19 07:30:20'),
(306, 29, 21, NULL, '2026-04-19 07:30:20'),
(307, 24, 21, NULL, '2026-04-19 07:30:23'),
(308, 24, 21, NULL, '2026-04-19 07:30:23'),
(309, 23, 21, NULL, '2026-04-19 07:30:26'),
(310, 23, 21, NULL, '2026-04-19 07:30:26'),
(311, 20, 21, NULL, '2026-04-19 07:30:32'),
(312, 20, 21, NULL, '2026-04-19 07:30:32'),
(313, 19, 21, NULL, '2026-04-19 07:30:36'),
(314, 19, 21, NULL, '2026-04-19 07:30:36'),
(315, 27, 21, NULL, '2026-04-19 07:30:49'),
(316, 27, 21, NULL, '2026-04-19 07:30:49'),
(317, 26, 21, NULL, '2026-04-19 07:30:53'),
(318, 26, 21, NULL, '2026-04-19 07:30:54'),
(319, 32, 21, NULL, '2026-04-19 07:32:53'),
(320, 32, 21, NULL, '2026-04-19 07:32:53'),
(321, 19, 21, NULL, '2026-04-19 07:34:00'),
(322, 19, 21, NULL, '2026-04-19 07:34:00'),
(323, 19, 21, NULL, '2026-04-19 07:34:36'),
(324, 19, 21, NULL, '2026-04-19 07:34:36'),
(325, 30, 15, NULL, '2026-04-19 07:41:05'),
(326, 30, 15, NULL, '2026-04-19 08:00:06'),
(327, 24, 18, NULL, '2026-04-19 08:02:34'),
(328, 24, 18, NULL, '2026-04-19 08:02:34'),
(329, 31, 18, NULL, '2026-04-19 08:02:45'),
(330, 31, 18, NULL, '2026-04-19 08:02:45'),
(331, 31, 18, NULL, '2026-04-19 08:03:01'),
(332, 31, 18, NULL, '2026-04-19 08:03:01'),
(333, 28, 18, NULL, '2026-04-19 08:03:05'),
(334, 28, 18, NULL, '2026-04-19 08:03:05'),
(335, 30, 15, NULL, '2026-04-19 08:13:12'),
(336, 30, 15, NULL, '2026-04-19 08:13:23'),
(337, 30, 15, NULL, '2026-04-19 08:13:35'),
(338, 24, 15, NULL, '2026-04-19 08:13:48'),
(339, 20, 15, NULL, '2026-04-19 08:37:57'),
(340, 20, 15, NULL, '2026-04-19 08:38:08'),
(341, 20, 15, NULL, '2026-04-19 13:43:36'),
(342, 20, 15, NULL, '2026-04-19 13:44:09'),
(343, 36, 18, NULL, '2026-04-19 15:02:50'),
(344, 36, 18, NULL, '2026-04-19 15:02:50'),
(345, 36, 15, NULL, '2026-04-19 15:05:05'),
(346, 36, 15, NULL, '2026-04-19 15:05:21'),
(347, 36, 15, NULL, '2026-04-19 15:05:29');

--
-- Triggers `idea_views`
--
DELIMITER $$
CREATE TRIGGER `tr_increment_view_count` AFTER INSERT ON `idea_views` FOR EACH ROW BEGIN
  UPDATE ideas SET view_count = view_count + 1 WHERE id = NEW.idea_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `idea_votes`
--

CREATE TABLE `idea_votes` (
  `id` int(11) NOT NULL,
  `idea_id` int(11) NOT NULL,
  `contributor_id` int(11) NOT NULL,
  `vote_type` enum('up','down') NOT NULL,
  `voted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `idea_votes`
--

INSERT INTO `idea_votes` (`id`, `idea_id`, `contributor_id`, `vote_type`, `voted_at`) VALUES
(1, 2, 6, 'down', '2026-03-20 10:44:47'),
(2, 1, 6, 'up', '2026-03-20 10:45:13'),
(3, 7, 6, 'up', '2026-03-21 09:02:48'),
(4, 2, 13, 'up', '2026-03-22 05:44:39'),
(5, 10, 13, 'up', '2026-03-22 05:58:27'),
(6, 14, 17, 'up', '2026-03-25 10:15:50'),
(7, 14, 15, 'up', '2026-03-25 10:24:07'),
(8, 13, 6, 'up', '2026-03-29 10:15:15'),
(9, 18, 6, 'up', '2026-04-18 07:07:56'),
(10, 22, 6, 'up', '2026-04-19 07:02:16'),
(11, 21, 6, 'up', '2026-04-19 07:02:21'),
(12, 20, 6, 'up', '2026-04-19 07:02:27'),
(13, 19, 6, 'up', '2026-04-19 07:02:32'),
(14, 26, 6, 'up', '2026-04-19 07:08:25'),
(15, 25, 6, 'up', '2026-04-19 07:08:29'),
(16, 24, 6, 'up', '2026-04-19 07:08:35'),
(17, 23, 6, 'up', '2026-04-19 07:08:39'),
(18, 26, 14, 'down', '2026-04-19 07:13:17'),
(19, 25, 14, 'down', '2026-04-19 07:13:21'),
(20, 22, 14, 'up', '2026-04-19 07:13:25'),
(21, 21, 14, 'up', '2026-04-19 07:13:28'),
(22, 24, 14, 'up', '2026-04-19 07:13:36'),
(23, 23, 14, 'up', '2026-04-19 07:13:38'),
(24, 20, 14, 'down', '2026-04-19 07:13:42'),
(25, 19, 14, 'down', '2026-04-19 07:13:46'),
(26, 28, 14, 'down', '2026-04-19 07:16:09'),
(27, 27, 14, 'up', '2026-04-19 07:16:14'),
(28, 29, 14, 'up', '2026-04-19 07:20:00'),
(29, 30, 14, 'up', '2026-04-19 07:23:17'),
(30, 32, 17, 'down', '2026-04-19 07:25:44'),
(31, 30, 17, 'up', '2026-04-19 07:25:47'),
(32, 31, 17, 'up', '2026-04-19 07:25:57'),
(33, 28, 17, 'down', '2026-04-19 07:26:02'),
(34, 25, 21, 'up', '2026-04-19 07:29:41'),
(35, 26, 21, 'down', '2026-04-19 07:29:44'),
(36, 27, 21, 'up', '2026-04-19 07:29:48'),
(37, 28, 21, 'down', '2026-04-19 07:29:55'),
(38, 31, 21, 'up', '2026-04-19 07:29:59'),
(39, 22, 21, 'up', '2026-04-19 07:30:04'),
(40, 21, 21, 'down', '2026-04-19 07:30:08'),
(41, 32, 21, 'down', '2026-04-19 07:30:15'),
(42, 30, 21, 'up', '2026-04-19 07:30:18'),
(43, 29, 21, 'up', '2026-04-19 07:30:22'),
(44, 24, 21, 'down', '2026-04-19 07:30:24'),
(45, 23, 21, 'up', '2026-04-19 07:30:27'),
(46, 20, 21, 'down', '2026-04-19 07:30:35'),
(47, 19, 21, 'down', '2026-04-19 07:30:38'),
(48, 29, 15, 'up', '2026-04-19 08:00:25'),
(49, 23, 15, 'up', '2026-04-19 08:00:27'),
(50, 24, 15, 'up', '2026-04-19 08:00:32'),
(51, 31, 18, 'up', '2026-04-19 08:02:47'),
(52, 28, 18, 'up', '2026-04-19 08:03:07'),
(53, 20, 15, 'up', '2026-04-19 08:38:08'),
(54, 36, 18, 'up', '2026-04-19 15:03:06'),
(55, 36, 15, 'up', '2026-04-19 15:05:29');

--
-- Triggers `idea_votes`
--
DELIMITER $$
CREATE TRIGGER `tr_update_upvote_count` AFTER INSERT ON `idea_votes` FOR EACH ROW BEGIN
  IF NEW.vote_type = 'up' THEN
    UPDATE ideas SET upvote_count = upvote_count + 1 WHERE id = NEW.idea_id;
  ELSEIF NEW.vote_type = 'down' THEN
    UPDATE ideas SET downvote_count = downvote_count + 1 WHERE id = NEW.idea_id;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `inappropriate_content_log`
--

CREATE TABLE `inappropriate_content_log` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `content_type` enum('Idea','Comment','Attachment') NOT NULL,
  `content_id` int(11) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `action` enum('Flagged','Hidden','Removed','Contributor Blocked','Contributor Disabled') NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inappropriate_content_log`
--

INSERT INTO `inappropriate_content_log` (`id`, `admin_id`, `content_type`, `content_id`, `reason`, `action`, `notes`, `created_at`) VALUES
(4, 12, 'Comment', 10, 'Inappropriate content', 'Flagged', 'Flagged by QA Coordinator', '2026-03-25 10:21:24'),
(5, 12, 'Idea', 14, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:21:31'),
(6, 12, 'Idea', 15, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:23:30'),
(7, 12, 'Idea', 14, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:23:47'),
(8, 12, 'Idea', 14, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:23:53'),
(9, 12, 'Idea', 14, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:24:18'),
(10, 12, 'Idea', 14, 'Inappropriate content', 'Flagged', 'Flagged by QA Coordinator', '2026-03-25 10:24:21'),
(11, 12, 'Idea', 14, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:25:51'),
(12, 12, 'Idea', 15, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:26:18'),
(13, 12, 'Idea', 15, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:26:23'),
(14, 12, 'Idea', 15, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:26:40'),
(15, 12, 'Idea', 9, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:26:56'),
(16, 12, 'Comment', 8, 'Inappropriate content', 'Hidden', 'Hidden by QA Coordinator', '2026-03-25 10:27:07'),
(17, 12, 'Idea', 11, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:27:13'),
(18, 12, 'Idea', 14, 'Inappropriate content', 'Flagged', 'Hidden by QA Coordinator', '2026-03-25 10:27:19'),
(19, 12, 'Comment', 10, 'Inappropriate content', 'Hidden', 'Hidden by QA Coordinator', '2026-03-25 10:27:29'),
(20, 12, 'Idea', 15, 'Inappropriate content', 'Hidden', 'Hidden by QA Coordinator', '2026-03-25 10:30:19'),
(21, 14, 'Idea', 15, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 10:40:04'),
(22, 14, 'Idea', 15, 'Spam', 'Flagged', '', '2026-03-25 10:41:07'),
(23, 14, 'Idea', 12, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 10:41:29'),
(24, 14, 'Idea', 10, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 10:41:43'),
(25, 14, 'Idea', 9, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 10:47:27'),
(26, 14, 'Idea', 10, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 11:32:37'),
(27, 14, 'Idea', 14, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:41:42'),
(28, 14, 'Idea', 15, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:42:22'),
(29, 14, 'Idea', 15, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:43:07'),
(30, 14, 'Idea', 15, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:44:42'),
(31, 14, 'Idea', 8, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:46:32'),
(32, 14, 'Idea', 15, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:49:45'),
(33, 14, 'Idea', 15, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:52:54'),
(34, 14, 'Idea', 7, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:54:39'),
(35, 14, 'Idea', 8, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:55:13'),
(36, 14, 'Idea', 8, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-03-25 12:57:16'),
(37, 14, 'Idea', 32, 'Inappropriate content', 'Hidden', 'Hidden by QA Manager', '2026-04-19 07:39:18');

-- --------------------------------------------------------

--
-- Table structure for table `notification_settings`
--

CREATE TABLE `notification_settings` (
  `id` int(11) NOT NULL,
  `notification_key` varchar(120) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification_settings`
--

INSERT INTO `notification_settings` (`id`, `notification_key`, `is_enabled`, `updated_at`) VALUES
(1, 'idea_submitted', 1, '2026-03-21 04:08:22'),
(2, 'comment_added', 1, '2026-03-21 04:08:22'),
(3, 'reply_added', 1, '2026-03-21 05:35:57'),
(4, 'inappropriate_reported', 1, '2026-03-21 04:08:22'),
(5, 'session_closing', 1, '2026-03-21 04:08:22');

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` int(11) NOT NULL,
  `template_key` varchar(120) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `template_key`, `subject`, `body`, `is_active`, `updated_at`) VALUES
(1, 'idea_submitted', 'New Idea Submitted', 'A new idea has been submitted to your department.', 1, '2026-03-21 04:08:22'),
(2, 'comment_added', 'New Comment Received', 'A new comment has been added to your idea.', 1, '2026-03-21 04:08:22'),
(3, 'inappropriate_reported', 'Content Reported', 'A content item has been reported for review.', 1, '2026-03-21 04:08:22');

-- --------------------------------------------------------

--
-- Table structure for table `qa_content_action_audit`
--

CREATE TABLE `qa_content_action_audit` (
  `id` int(11) NOT NULL,
  `content_type` enum('Idea','Comment') NOT NULL,
  `content_id` int(11) NOT NULL,
  `action` enum('flag','hide','delete') NOT NULL,
  `previous_state_json` longtext NOT NULL,
  `admin_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_undone` tinyint(1) NOT NULL DEFAULT 0,
  `undone_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `qa_content_action_audit`
--

INSERT INTO `qa_content_action_audit` (`id`, `content_type`, `content_id`, `action`, `previous_state_json`, `admin_id`, `created_at`, `is_undone`, `undone_at`) VALUES
(1, 'Idea', 9, 'hide', '{\"status\":\"Submitted\",\"approval_status\":\"Flagged\",\"is_inappropriate\":1,\"inappropriate_reason\":\"Inappropriate content\",\"flagged_by_admin_id\":12,\"flagged_at\":\"2026-03-25 17:26:56\"}', 14, '2026-03-25 10:47:27', 1, '2026-03-25 10:52:35'),
(2, 'Comment', 7, 'delete', '{\"is_deleted\":0,\"deleted_by\":null,\"deleted_at\":null,\"deleted_reason\":null}', 14, '2026-03-25 11:32:31', 0, NULL),
(3, 'Idea', 10, 'hide', '{\"status\":\"\",\"approval_status\":\"\",\"is_inappropriate\":1,\"inappropriate_reason\":\"Inappropriate content\",\"flagged_by_admin_id\":14,\"flagged_at\":\"2026-03-25 17:41:43\"}', 14, '2026-03-25 11:32:37', 1, '2026-03-25 11:32:53'),
(4, 'Idea', 14, 'hide', '{\"status\":\"Submitted\",\"approval_status\":\"Flagged\",\"is_inappropriate\":1,\"inappropriate_reason\":\"Inappropriate content\",\"flagged_by_admin_id\":12,\"flagged_at\":\"2026-03-25 17:27:19\"}', 14, '2026-03-25 12:41:42', 1, '2026-03-25 12:41:47'),
(5, 'Idea', 15, 'hide', '{\"status\":\"\",\"approval_status\":\"\",\"is_inappropriate\":1,\"inappropriate_reason\":\"Spam\",\"flagged_by_admin_id\":14,\"flagged_at\":\"2026-03-25 17:41:07\"}', 14, '2026-03-25 12:42:22', 0, NULL),
(6, 'Idea', 15, 'hide', '{\"status\":\"\",\"approval_status\":\"\",\"is_inappropriate\":1,\"inappropriate_reason\":\"Inappropriate content\",\"flagged_by_admin_id\":14,\"flagged_at\":\"2026-03-25 19:42:22\"}', 14, '2026-03-25 12:43:07', 1, '2026-03-25 12:43:10'),
(7, 'Idea', 15, 'hide', '{\"status\":\"\",\"approval_status\":\"\",\"is_inappropriate\":1,\"inappropriate_reason\":\"Inappropriate content\",\"flagged_by_admin_id\":14,\"flagged_at\":\"2026-03-25 19:42:22\"}', 14, '2026-03-25 12:44:42', 1, '2026-03-25 12:45:17'),
(8, 'Idea', 8, 'hide', '{\"status\":\"Submitted\",\"approval_status\":\"Approved\",\"is_inappropriate\":0,\"inappropriate_reason\":null,\"flagged_by_admin_id\":null,\"flagged_at\":null}', 14, '2026-03-25 12:46:32', 1, '2026-03-25 12:46:35'),
(9, 'Idea', 15, 'hide', '{\"status\":\"\",\"approval_status\":\"\",\"is_inappropriate\":1,\"inappropriate_reason\":\"Inappropriate content\",\"flagged_by_admin_id\":14,\"flagged_at\":\"2026-03-25 19:42:22\"}', 14, '2026-03-25 12:49:45', 0, NULL),
(10, 'Idea', 15, 'hide', '{\"status\":\"\",\"approval_status\":\"\",\"is_inappropriate\":1,\"inappropriate_reason\":\"Inappropriate content\",\"flagged_by_admin_id\":14,\"flagged_at\":\"2026-03-25 19:49:45\"}', 14, '2026-03-25 12:52:54', 1, '2026-03-25 12:52:57'),
(11, 'Idea', 7, 'hide', '{\"status\":\"Submitted\",\"approval_status\":\"Approved\",\"is_inappropriate\":0,\"inappropriate_reason\":null,\"flagged_by_admin_id\":null,\"flagged_at\":null}', 14, '2026-03-25 12:54:39', 0, NULL),
(12, 'Idea', 8, 'hide', '{\"status\":\"Submitted\",\"approval_status\":\"Approved\",\"is_inappropriate\":0,\"inappropriate_reason\":\"Inappropriate content\",\"flagged_by_admin_id\":14,\"flagged_at\":\"2026-03-25 19:46:32\"}', 14, '2026-03-25 12:55:13', 1, '2026-03-25 12:57:08'),
(13, 'Idea', 8, 'hide', '{\"status\":\"Submitted\",\"approval_status\":\"Approved\",\"is_inappropriate\":0,\"inappropriate_reason\":\"Inappropriate content\",\"flagged_by_admin_id\":14,\"flagged_at\":\"2026-03-25 19:46:32\"}', 14, '2026-03-25 12:57:15', 1, '2026-03-25 12:58:20'),
(14, 'Idea', 32, 'hide', '{\"status\":\"Submitted\",\"approval_status\":\"Approved\",\"is_inappropriate\":0,\"inappropriate_reason\":null,\"flagged_by_admin_id\":null,\"flagged_at\":null}', 14, '2026-04-19 07:39:18', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `qa_coordinator_departments`
--

CREATE TABLE `qa_coordinator_departments` (
  `id` int(11) NOT NULL,
  `coordinator_id` int(11) NOT NULL,
  `department` varchar(100) NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `qa_coordinator_departments`
--

INSERT INTO `qa_coordinator_departments` (`id`, `coordinator_id`, `department`, `assigned_at`, `is_active`) VALUES
(6, 12, 'innovation', '2026-04-19 07:37:23', 1),
(9, 20, 'IMS', '2026-04-20 13:34:37', 1);

-- --------------------------------------------------------

--
-- Table structure for table `qa_hidden_content_records`
--

CREATE TABLE `qa_hidden_content_records` (
  `id` int(11) NOT NULL,
  `contributor_id` int(11) NOT NULL,
  `content_type` enum('Idea','Comment','Reply') NOT NULL,
  `content_id` int(11) NOT NULL,
  `previous_state_json` longtext NOT NULL,
  `hidden_by_admin_id` int(11) NOT NULL,
  `hidden_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_restored` tinyint(1) NOT NULL DEFAULT 0,
  `restored_by_admin_id` int(11) DEFAULT NULL,
  `restored_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `qa_hidden_content_records`
--

INSERT INTO `qa_hidden_content_records` (`id`, `contributor_id`, `content_type`, `content_id`, `previous_state_json`, `hidden_by_admin_id`, `hidden_at`, `is_restored`, `restored_by_admin_id`, `restored_at`) VALUES
(1, 1, 'Idea', 1, '{\"status\":\"Published\",\"is_inappropriate\":0,\"title\":\"AI-Powered Analytics Dashboard\"}', 1, '2026-03-20 07:05:00', 1, 1, '2026-03-20 09:30:00'),
(2, 2, 'Comment', 1, '{\"is_deleted\":0,\"is_inappropriate\":0,\"content\":\"Great idea! This would save us a lot of time.\"}', 1, '2026-03-21 02:20:00', 0, NULL, NULL),
(3, 2, 'Reply', 1, '{\"is_deleted\":0,\"is_inappropriate\":0}', 1, '2026-03-21 03:05:00', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `qa_managers`
--

CREATE TABLE `qa_managers` (
  `id` int(11) NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `qa_managers`
--

INSERT INTO `qa_managers` (`id`, `admin_user_id`, `department`, `is_active`, `created_at`, `updated_at`) VALUES
(3, 14, '.', 1, '2026-03-24 10:14:53', '2026-03-24 10:14:53'),
(4, 19, 'IMS', 1, '2026-04-20 13:34:37', '2026-04-20 13:34:37');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_key` varchar(60) NOT NULL,
  `permissions_json` longtext NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_key`, `permissions_json`, `updated_at`) VALUES
('Admin', '{\"manage_users\":true,\"manage_departments\":true,\"manage_config\":true,\"manage_backups\":true,\"view_audit_logs\":true,\"moderate_content\":true}', '2026-03-21 04:08:22'),
('QACoordinator', '{\"manage_department_engagement\":true,\"view_department_reports\":true,\"moderate_content\":true,\"manage_system_config\":false}', '2026-03-21 04:08:22'),
('QAManager', '{\"manage_categories\":true,\"manage_ideas\":true,\"view_reports\":true,\"moderate_content\":true,\"manage_users\":false}', '2026-03-21 04:08:22'),
('Staff', '{\"submit_ideas\":true,\"comment\":true,\"vote\":true,\"manage_users\":false}', '2026-03-21 04:08:22');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL,
  `academic_year_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `session_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `opens_at` datetime NOT NULL,
  `closes_at` datetime NOT NULL,
  `final_closure_date` datetime DEFAULT NULL,
  `status` enum('Draft','Active','Closed') DEFAULT 'Draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `academic_year_id`, `category_id`, `session_name`, `description`, `opens_at`, `closes_at`, `final_closure_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Tech Ideas 2024', 'Submit your technology innovation ideas', '2024-01-15 00:00:00', '2024-03-31 23:59:59', '2024-03-31 23:59:59', 'Closed', '2026-03-17 12:28:14', '2026-04-19 03:40:54'),
(2, 1, 2, 'Social Impact 2024', 'Ideas for social good initiatives', '2024-02-01 00:00:00', '2024-04-15 23:59:59', '2024-04-15 23:59:59', 'Closed', '2026-03-17 12:28:14', '2026-04-19 03:41:01'),
(3, 1, 3, 'Green Ideas', 'Sustainability and environmental ideas', '2024-03-01 00:00:00', '2024-05-31 23:59:59', '2024-05-31 23:59:59', 'Draft', '2026-03-17 12:28:14', '2026-03-20 07:53:10'),
(4, 2, 1, 'sample', 'sample', '2026-03-14 12:42:00', '2026-03-23 12:42:00', '2026-03-23 12:42:00', 'Closed', '2026-03-21 05:42:47', '2026-03-24 10:21:57'),
(5, 2, 4, 'Test', 'test1', '2026-03-23 17:41:00', '2026-04-03 17:41:00', '2026-04-11 17:41:00', 'Draft', '2026-03-24 10:41:22', '2026-03-24 10:41:39'),
(6, 2, 2, 'test2', 'test2', '2026-03-20 17:44:00', '2026-03-23 17:44:00', '2026-03-23 17:44:00', 'Closed', '2026-03-24 10:44:45', '2026-04-19 03:40:45'),
(7, 2, 1, '1', '1', '2026-03-30 16:56:00', '2026-03-31 16:56:00', '2026-04-01 16:56:00', 'Closed', '2026-03-29 09:56:28', '2026-04-19 03:40:37'),
(8, 2, 4, 'T1', 'T1', '2026-04-16 11:43:00', '2026-04-18 11:43:00', '2026-04-19 11:44:00', 'Active', '2026-04-18 04:44:22', '2026-04-18 04:44:22'),
(9, 2, 2, '111', '111', '2026-04-15 11:46:00', '2026-04-16 11:46:00', '2026-04-17 11:47:00', 'Closed', '2026-04-18 04:47:12', '2026-04-18 05:27:47'),
(10, 2, 2, '222', '222', '2026-04-17 13:49:00', '2026-04-21 13:49:00', '2026-04-22 13:49:00', 'Active', '2026-04-18 06:49:33', '2026-04-18 06:49:33'),
(11, 2, 8, 'Student Mental Health Awareness Campaign 2026', 'This session collects ideas to improve student mental health support services, including counseling accessibility, stress management programs, and awareness activities across campus.', '2026-04-18 10:46:00', '2026-05-02 10:46:00', '2026-05-09 10:46:00', 'Active', '2026-04-19 03:46:48', '2026-04-19 03:46:48'),
(12, 2, 7, 'Enhancing Digital Learning Experience 2026', 'This session invites ideas to improve online and blended learning, including better use of learning platforms, interactive teaching methods, digital resources, and student engagement in virtual classrooms.', '2026-04-11 10:47:00', '2026-04-15 10:48:00', '2026-04-18 10:48:00', 'Closed', '2026-04-19 03:48:17', '2026-04-19 07:58:23');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('Manager','Coordinator','Staff') DEFAULT 'Staff',
  `department` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `name`, `email`, `role`, `department`, `phone`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Sarah Johnson', 'sarah.johnson@example.com', 'Manager', 'Innovation', NULL, 1, '2026-03-17 12:28:14', '2026-03-17 12:28:14'),
(2, 'Mike Chen', 'mike.chen@example.com', 'Coordinator', 'Operations', NULL, 1, '2026-03-17 12:28:14', '2026-03-17 12:28:14'),
(3, 'Emma Davis', 'emma.davis@example.com', 'Coordinator', 'Innovation', NULL, 1, '2026-03-17 12:28:14', '2026-03-17 12:28:14'),
(4, 'John Smith', 'john.smith@example.com', 'Staff', 'Administration', NULL, 1, '2026-03-17 12:28:14', '2026-03-17 12:28:14'),
(6, 'Test Staff', 'staff1@example.com', 'Staff', 'Innovation', '0123456789', 1, '2026-03-20 07:32:30', '2026-03-20 07:32:30'),
(9, 'Staff User Two', 'staff2@example.com', 'Staff', 'Innovation', '', 1, '2026-03-20 07:35:27', '2026-03-20 07:35:27'),
(10, 'AHO', 'andyoo553@gmail.com', 'Staff', 'Innovation', NULL, 1, '2026-03-24 10:01:36', '2026-03-24 10:01:36'),
(11, 'aaa', 'staff3@gmail.com', 'Staff', 'Administration', NULL, 1, '2026-03-25 09:24:51', '2026-03-25 09:27:36'),
(12, 'bbb', 'staff4@gmail.com', 'Staff', 'Marketing', NULL, 1, '2026-03-25 09:28:17', '2026-03-25 09:28:17'),
(13, 'Leon', 'leyonhal5@gmail.com', 'Staff', 'Innovation', NULL, 1, '2026-04-19 06:53:29', '2026-04-19 06:53:29'),
(14, 'Innovation Staff 7', 'innovation7@example.com', 'Staff', 'Innovation', NULL, 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(15, 'Innovation Staff 8', 'innovation8@example.com', 'Staff', 'Innovation', NULL, 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(16, 'Innovation Staff 9', 'innovation9@example.com', 'Staff', 'Innovation', NULL, 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(17, 'Innovation Staff 10', 'innovation10@example.com', 'Staff', 'Innovation', NULL, 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(18, 'Innovation Staff 11', 'innovation11@example.com', 'Staff', 'Innovation', NULL, 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(19, 'Innovation Staff 12', 'innovation12@example.com', 'Staff', 'Innovation', NULL, 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(20, 'IMS Staff 01', 'imstaff01@ewsd.local', 'Staff', 'IMS', '', 1, '2026-04-20 13:39:25', '2026-04-20 13:39:25'),
(21, 'IMS Staff 02', 'imstaff02@ewsd.local', 'Staff', 'IMS', '', 1, '2026-04-20 13:39:25', '2026-04-20 13:39:25');

-- --------------------------------------------------------

--
-- Table structure for table `staff_idea_reports`
--

CREATE TABLE `staff_idea_reports` (
  `id` int(11) NOT NULL,
  `reporter_id` int(11) DEFAULT NULL,
  `content_type` enum('Idea','Comment','Reply') NOT NULL,
  `content_id` int(11) NOT NULL,
  `report_category` enum('Swearing','Libel','Harassment','Offensive','Other') NOT NULL,
  `reason` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `severity` enum('Low','Medium','High','Critical') DEFAULT 'Medium',
  `status` enum('Reported','Under_Review','Flagged','Dismissed') DEFAULT 'Reported',
  `reported_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolved_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_idea_reports`
--

INSERT INTO `staff_idea_reports` (`id`, `reporter_id`, `content_type`, `content_id`, `report_category`, `reason`, `description`, `severity`, `status`, `reported_at`, `resolved_at`) VALUES
(1, 6, 'Idea', 7, 'Harassment', 'test', 'test', 'Medium', 'Reported', '2026-03-21 09:02:39', NULL),
(2, 22, 'Idea', 31, 'Offensive', 'Contains insulting language toward a group of students', 'The post includes derogatory remarks targeting international students, which may create a hostile environment and violate community guidelines.', 'Medium', 'Reported', '2026-04-19 07:29:24', NULL),
(3, 23, 'Idea', 26, 'Other', 'Uses inappropriate and disrespectful words', 'The content contains offensive slang and rude expressions directed at classmates. This may negatively impact student wellbeing and respectful communication.', 'Medium', 'Reported', '2026-04-19 07:31:23', NULL),
(4, 24, 'Idea', 32, 'Swearing', 'Contains personal attacks', 'The content directly targets an individual with negative and abusive comments, which could lead to harassment concerns.', 'Medium', 'Reported', '2026-04-19 07:33:47', NULL),
(5, 26, 'Idea', 19, 'Libel', 'Promotes harmful stereotypes', 'The idea submission includes stereotypes about certain groups, which can be considered discriminatory and inappropriate for an academic environment.', 'Medium', 'Reported', '2026-04-19 07:35:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `staff_invitations`
--

CREATE TABLE `staff_invitations` (
  `id` int(11) NOT NULL,
  `coordinator_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `idea_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_invitations`
--

INSERT INTO `staff_invitations` (`id`, `coordinator_id`, `staff_id`, `session_id`, `idea_id`, `message`, `sent_at`, `read_at`) VALUES
(4, 12, 9, 4, NULL, 'One of the most upvoted ideas this session is \"TESTING2\" with 3 upvotes. We\'d love your ideas too!', '2026-03-25 11:05:27', NULL),
(5, 12, 3, 4, NULL, 'One of the most upvoted ideas this session is \"TESTING2\" with 3 upvotes. We\'d love your ideas too!', '2026-03-25 11:05:41', NULL),
(6, 12, 6, 4, NULL, 'One of the most upvoted ideas this session is \"TESTING2\" with 3 upvotes. We\'d love your ideas too!', '2026-03-25 11:06:49', NULL),
(7, 12, 9, 4, NULL, 'One of the most upvoted ideas this session is \"TESTING2\" with 3 upvotes. We\'d love your ideas too!', '2026-03-25 11:07:03', NULL),
(8, 12, 9, 4, 13, 'We would love to hear your ideas! Please share your thoughts and suggestions for improvement.', '2026-03-25 11:21:31', NULL),
(9, 12, 10, 1, 2, 'One of the most upvoted ideas this session is \"Automated Testing Framework\" with 2 upvotes. We\'d love your ideas too!', '2026-04-19 05:24:30', NULL),
(10, 12, 10, 11, 23, 'Hi! Just a friendly reminder that we are looking for your innovative ideas. The submission window closes soon!', '2026-04-19 08:40:16', NULL),
(11, 12, 10, 11, 23, 'One of the most upvoted ideas this session is \"24/7 Mental Health Chatbot for Students\" with 5 upvotes. We\'d love your ideas too!', '2026-04-19 15:07:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `staff_submission_tracking`
--

CREATE TABLE `staff_submission_tracking` (
  `id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `department` varchar(100) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `has_submitted` tinyint(1) DEFAULT 0,
  `first_submission_date` timestamp NULL DEFAULT NULL,
  `idea_count` int(11) DEFAULT 0,
  `last_idea_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_submission_tracking`
--

INSERT INTO `staff_submission_tracking` (`id`, `session_id`, `department`, `staff_id`, `has_submitted`, `first_submission_date`, `idea_count`, `last_idea_date`, `created_at`, `updated_at`) VALUES
(7, 1, 'Technology', 1, 1, '2024-02-01 03:00:00', 2, NULL, '2026-03-18 09:39:41', NULL),
(8, 1, 'Innovation', 2, 1, '2024-02-05 04:30:00', 1, NULL, '2026-03-18 09:39:41', NULL),
(9, 1, 'Innovation', 3, 1, '2024-02-10 02:15:00', 1, NULL, '2026-03-18 09:39:41', NULL),
(10, 1, 'Operations', 4, 0, NULL, 0, NULL, '2026-03-18 09:39:41', NULL),
(11, 4, 'Innovation', 9, 1, '2026-03-21 05:43:28', 12, '2026-03-22 13:46:16', '2026-03-21 05:43:28', '2026-03-22 13:46:16'),
(13, 4, 'Innovation', 6, 1, '2026-03-21 06:50:02', 4, '2026-03-24 09:37:38', '2026-03-21 06:50:02', '2026-03-24 09:37:38'),
(27, 4, 'Innovation', 10, 1, '2026-03-24 10:08:41', 2, '2026-03-24 10:08:45', '2026-03-24 10:08:41', '2026-03-24 10:08:45'),
(29, 6, 'Innovation', 9, 1, '2026-03-24 10:50:46', 2, '2026-03-24 10:50:54', '2026-03-24 10:50:46', '2026-03-24 10:50:54'),
(31, 9, 'Innovation', 9, 1, '2026-04-18 04:48:07', 4, '2026-04-18 04:48:53', '2026-04-18 04:48:07', '2026-04-18 04:48:53'),
(35, 10, 'Innovation', 9, 1, '2026-04-18 06:50:23', 2, '2026-04-18 06:50:31', '2026-04-18 06:50:23', '2026-04-18 06:50:31'),
(37, 11, 'Innovation', 13, 1, '2026-04-19 06:56:09', 10, '2026-04-19 15:02:29', '2026-04-19 06:56:09', '2026-04-19 15:02:29'),
(41, 12, 'Innovation', 13, 1, '2026-04-19 07:00:11', 4, '2026-04-19 07:01:44', '2026-04-19 07:00:11', '2026-04-19 07:01:44'),
(45, 11, 'Innovation', 9, 1, '2026-04-19 07:05:05', 4, '2026-04-19 07:06:21', '2026-04-19 07:05:05', '2026-04-19 07:06:21'),
(49, 12, 'Innovation', 9, 1, '2026-04-19 07:07:15', 4, '2026-04-19 07:08:13', '2026-04-19 07:07:15', '2026-04-19 07:08:13'),
(53, 12, 'Innovation', 6, 1, '2026-04-19 07:14:34', 4, '2026-04-19 07:15:52', '2026-04-19 07:14:34', '2026-04-19 07:15:52'),
(57, 11, 'Innovation', 6, 1, '2026-04-19 07:19:33', 4, '2026-04-19 07:22:52', '2026-04-19 07:19:33', '2026-04-19 07:22:52'),
(61, 12, 'Administration', 11, 1, '2026-04-19 07:24:32', 2, '2026-04-19 07:24:42', '2026-04-19 07:24:32', '2026-04-19 07:24:42'),
(63, 11, 'Administration', 11, 1, '2026-04-19 07:25:22', 2, '2026-04-19 07:25:32', '2026-04-19 07:25:22', '2026-04-19 07:25:32'),
(65, 11, 'Marketing', 12, 1, '2026-04-19 07:36:28', 2, '2026-04-19 07:36:37', '2026-04-19 07:36:28', '2026-04-19 07:36:37'),
(67, 11, 'Innovation', 17, 1, '2026-04-19 07:55:13', 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(68, 11, 'Innovation', 14, 1, '2026-04-19 07:55:13', 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(69, 11, 'Innovation', 15, 1, '2026-04-19 07:55:13', 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(70, 11, 'Innovation', 16, 1, '2026-04-19 07:55:13', 1, '2026-04-19 07:55:13', '2026-04-19 07:55:13', '2026-04-19 07:55:13'),
(77, 11, 'IMS', 20, 1, '2026-04-20 13:41:39', 8, '2026-04-20 13:46:20', '2026-04-20 13:41:39', '2026-04-20 13:46:20'),
(85, 11, 'IMS', 21, 1, '2026-04-20 13:47:54', 8, '2026-04-20 13:51:53', '2026-04-20 13:47:54', '2026-04-20 13:51:53');

-- --------------------------------------------------------

--
-- Table structure for table `staff_tc_acceptance`
--

CREATE TABLE `staff_tc_acceptance` (
  `id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `tc_version` int(11) NOT NULL,
  `accepted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_tc_acceptance`
--

INSERT INTO `staff_tc_acceptance` (`id`, `staff_id`, `tc_version`, `accepted_at`, `ip_address`) VALUES
(12, 9, 1, '2026-03-20 08:15:02', '::1'),
(13, 6, 1, '2026-03-21 06:48:05', '::1'),
(17, 10, 1, '2026-03-24 10:08:41', '::1'),
(18, 13, 1, '2026-04-19 06:56:09', '::1'),
(19, 11, 1, '2026-04-19 07:24:32', '::1'),
(20, 12, 1, '2026-04-19 07:36:28', '::1'),
(21, 20, 1, '2026-04-20 13:41:39', '::1'),
(22, 21, 1, '2026-04-20 13:47:54', '::1');

-- --------------------------------------------------------

--
-- Table structure for table `system_backups`
--

CREATE TABLE `system_backups` (
  `id` int(11) NOT NULL,
  `backup_name` varchar(255) NOT NULL,
  `backup_scope` varchar(255) NOT NULL,
  `backup_payload` longtext NOT NULL,
  `created_by_admin_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_backups`
--

INSERT INTO `system_backups` (`id`, `backup_name`, `backup_scope`, `backup_payload`, `created_by_admin_id`, `created_at`) VALUES
(1, 'System Backup 2026-03-22 06:03:41', 'users,departments,settings,categories,notifications,security', '{\"admin_users\":[{\"id\":1,\"username\":\"admin\",\"email\":\"admin@ewsd.local\",\"password_hash\":\"$2y$10$2oynwjICRS53CIp.tBWMI.nhF.NhCL1xNdqeH4bwYRhRvO78s\\/ar6\",\"full_name\":\"System Admin\",\"role\":\"Admin\",\"department\":\"Administration\",\"is_active\":1,\"last_login\":\"2026-03-22 12:03:24\",\"created_at\":\"2026-03-20 17:41:31\",\"updated_at\":\"2026-03-22 12:03:24\"},{\"id\":6,\"username\":\"staff1\",\"email\":\"staff1@example.com\",\"password_hash\":\"$2y$10$mTw4BtoCgoyFCzU7wbU1POboes9U9VVCcwbaADWAAbGs346P3PMPS\",\"full_name\":\"Test Staff\",\"role\":\"Staff\",\"department\":\"Innovation\",\"is_active\":1,\"last_login\":\"2026-03-21 15:41:07\",\"created_at\":\"2026-03-20 17:41:31\",\"updated_at\":\"2026-03-21 15:41:07\"},{\"id\":9,\"username\":\"staff2\",\"email\":\"staff2@example.com\",\"password_hash\":\"$2y$10$GbafrNeX1FlkAyoj94vHYuxO6r6ipFZ3lBzTXFtP8AaNI9uau7VKO\",\"full_name\":\"Staff User Two\",\"role\":\"Staff\",\"department\":\"Innovation\",\"is_active\":1,\"last_login\":\"2026-03-21 16:06:58\",\"created_at\":\"2026-03-20 17:41:31\",\"updated_at\":\"2026-03-21 16:06:58\"},{\"id\":10,\"username\":\"qamanager\",\"email\":\"13halhtutalin@gmail.com\",\"password_hash\":\"$2y$10$XeVjK0bksNL5TeiZyD2VCuN5U7MQAB6hR037CjeogYM9i0KEkTQx6\",\"full_name\":\"hlin\",\"role\":\"QAManager\",\"department\":\".\",\"is_active\":1,\"last_login\":\"2026-03-21 15:50:30\",\"created_at\":\"2026-03-21 11:12:54\",\"updated_at\":\"2026-03-21 15:50:30\"},{\"id\":11,\"username\":\"QAc\",\"email\":\"lyon123@gmail.com\",\"password_hash\":\"$2y$10$faKza9v7csg8PUNhP95FJuBnPhsu4J7wmhqPXGYAYm7ffZzgawe9i\",\"full_name\":\"Leyon\",\"role\":\"QACoordinator\",\"department\":\"Tech\",\"is_active\":1,\"last_login\":\"2026-03-21 16:05:53\",\"created_at\":\"2026-03-21 12:17:37\",\"updated_at\":\"2026-03-21 16:05:53\"}],\"staff\":[{\"id\":1,\"name\":\"Sarah Johnson\",\"email\":\"sarah.johnson@example.com\",\"role\":\"Manager\",\"department\":\"Innovation\",\"phone\":null,\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":2,\"name\":\"Mike Chen\",\"email\":\"mike.chen@example.com\",\"role\":\"Coordinator\",\"department\":\"Operations\",\"phone\":null,\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":3,\"name\":\"Emma Davis\",\"email\":\"emma.davis@example.com\",\"role\":\"Coordinator\",\"department\":\"Innovation\",\"phone\":null,\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":4,\"name\":\"John Smith\",\"email\":\"john.smith@example.com\",\"role\":\"Staff\",\"department\":\"Administration\",\"phone\":null,\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":6,\"name\":\"Test Staff\",\"email\":\"staff1@example.com\",\"role\":\"Staff\",\"department\":\"Innovation\",\"phone\":\"0123456789\",\"is_active\":1,\"created_at\":\"2026-03-20 14:32:30\",\"updated_at\":\"2026-03-20 14:32:30\"},{\"id\":9,\"name\":\"Staff User Two\",\"email\":\"staff2@example.com\",\"role\":\"Staff\",\"department\":\"Innovation\",\"phone\":\"\",\"is_active\":1,\"created_at\":\"2026-03-20 14:35:27\",\"updated_at\":\"2026-03-20 14:35:27\"}],\"qa_managers\":[{\"id\":2,\"admin_user_id\":10,\"department\":\".\",\"is_active\":1,\"created_at\":\"2026-03-21 11:12:54\",\"updated_at\":\"2026-03-21 11:12:54\"}],\"qa_coordinator_departments\":[{\"id\":4,\"coordinator_id\":11,\"department\":\"Tech\",\"assigned_at\":\"2026-03-21 12:17:37\",\"is_active\":1}],\"departments\":[{\"id\":1,\"name\":\"Administration\",\"qa_coordinator_id\":null,\"is_active\":1,\"created_at\":\"2026-03-21 11:08:22\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":2,\"name\":\"Innovation\",\"qa_coordinator_id\":null,\"is_active\":1,\"created_at\":\"2026-03-21 11:08:22\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":4,\"name\":\"Operations\",\"qa_coordinator_id\":null,\"is_active\":1,\"created_at\":\"2026-03-21 11:08:22\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":7,\"name\":\"Marketing\",\"qa_coordinator_id\":null,\"is_active\":1,\"created_at\":\"2026-03-21 11:08:22\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":9,\"name\":\"Technology\",\"qa_coordinator_id\":null,\"is_active\":1,\"created_at\":\"2026-03-21 11:08:22\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":421,\"name\":\".\",\"qa_coordinator_id\":null,\"is_active\":1,\"created_at\":\"2026-03-21 11:12:54\",\"updated_at\":\"2026-03-21 11:12:54\"},{\"id\":526,\"name\":\"Tech\",\"qa_coordinator_id\":null,\"is_active\":1,\"created_at\":\"2026-03-21 12:17:37\",\"updated_at\":\"2026-03-21 12:17:37\"}],\"system_settings\":[{\"id\":1,\"setting_key\":\"idea_submissions_enabled\",\"setting_value\":\"1\",\"value_type\":\"bool\",\"description\":\"Global switch for idea submissions\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":2,\"setting_key\":\"commenting_enabled\",\"setting_value\":\"1\",\"value_type\":\"bool\",\"description\":\"Global switch for comments and replies\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":3,\"setting_key\":\"default_ideas_per_page\",\"setting_value\":\"5\",\"value_type\":\"int\",\"description\":\"Default ideas pagination size\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":4,\"setting_key\":\"max_upload_size_mb\",\"setting_value\":\"10\",\"value_type\":\"int\",\"description\":\"Maximum upload size in MB\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":5,\"setting_key\":\"allowed_file_types\",\"setting_value\":\"[\\\"pdf\\\",\\\"doc\\\",\\\"docx\\\",\\\"xls\\\",\\\"xlsx\\\",\\\"jpg\\\",\\\"jpeg\\\",\\\"png\\\",\\\"gif\\\"]\",\"value_type\":\"json\",\"description\":\"Allowed attachment file extensions\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":6,\"setting_key\":\"session_timeout_minutes\",\"setting_value\":\"1440\",\"value_type\":\"int\",\"description\":\"Session timeout in minutes\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":7,\"setting_key\":\"password_policy\",\"setting_value\":\"{\\\"min_length\\\":8,\\\"require_uppercase\\\":true,\\\"require_number\\\":true,\\\"require_symbol\\\":false}\",\"value_type\":\"json\",\"description\":\"Password policy settings\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":8,\"setting_key\":\"smtp_settings\",\"setting_value\":\"{\\\"host\\\":\\\"\\\",\\\"port\\\":587,\\\"username\\\":\\\"\\\",\\\"password\\\":\\\"\\\",\\\"encryption\\\":\\\"tls\\\",\\\"from_email\\\":\\\"\\\",\\\"from_name\\\":\\\"Ideas System\\\"}\",\"value_type\":\"json\",\"description\":\"SMTP server settings\",\"updated_at\":\"2026-03-21 11:08:22\"}],\"idea_categories\":[{\"id\":1,\"name\":\"Technology\",\"description\":\"Technology and innovation ideas\",\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":2,\"name\":\"Social Impact\",\"description\":\"Ideas for social good\",\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":3,\"name\":\"Sustainability\",\"description\":\"Environmental and sustainability initiatives\",\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"},{\"id\":4,\"name\":\"Business\",\"description\":\"Business and entrepreneurship ideas\",\"is_active\":1,\"created_at\":\"2026-03-17 19:28:14\",\"updated_at\":\"2026-03-17 19:28:14\"}],\"notification_templates\":[{\"id\":1,\"template_key\":\"idea_submitted\",\"subject\":\"New Idea Submitted\",\"body\":\"A new idea has been submitted to your department.\",\"is_active\":1,\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":2,\"template_key\":\"comment_added\",\"subject\":\"New Comment Received\",\"body\":\"A new comment has been added to your idea.\",\"is_active\":1,\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":3,\"template_key\":\"inappropriate_reported\",\"subject\":\"Content Reported\",\"body\":\"A content item has been reported for review.\",\"is_active\":1,\"updated_at\":\"2026-03-21 11:08:22\"}],\"notification_settings\":[{\"id\":1,\"notification_key\":\"idea_submitted\",\"is_enabled\":1,\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":2,\"notification_key\":\"comment_added\",\"is_enabled\":1,\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":3,\"notification_key\":\"reply_added\",\"is_enabled\":1,\"updated_at\":\"2026-03-21 12:35:57\"},{\"id\":4,\"notification_key\":\"inappropriate_reported\",\"is_enabled\":1,\"updated_at\":\"2026-03-21 11:08:22\"},{\"id\":5,\"notification_key\":\"session_closing\",\"is_enabled\":1,\"updated_at\":\"2026-03-21 11:08:22\"}],\"role_permissions\":[{\"role_key\":\"Admin\",\"permissions_json\":\"{\\\"manage_users\\\":true,\\\"manage_departments\\\":true,\\\"manage_config\\\":true,\\\"manage_backups\\\":true,\\\"view_audit_logs\\\":true,\\\"moderate_content\\\":true}\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"role_key\":\"QACoordinator\",\"permissions_json\":\"{\\\"manage_department_engagement\\\":true,\\\"view_department_reports\\\":true,\\\"moderate_content\\\":true,\\\"manage_system_config\\\":false}\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"role_key\":\"QAManager\",\"permissions_json\":\"{\\\"manage_categories\\\":true,\\\"manage_ideas\\\":true,\\\"view_reports\\\":true,\\\"moderate_content\\\":true,\\\"manage_users\\\":false}\",\"updated_at\":\"2026-03-21 11:08:22\"},{\"role_key\":\"Staff\",\"permissions_json\":\"{\\\"submit_ideas\\\":true,\\\"comment\\\":true,\\\"vote\\\":true,\\\"manage_users\\\":false}\",\"updated_at\":\"2026-03-21 11:08:22\"}]}', 1, '2026-03-22 05:03:41');

-- --------------------------------------------------------

--
-- Table structure for table `system_notifications`
--

CREATE TABLE `system_notifications` (
  `id` int(11) NOT NULL,
  `recipient_type` enum('Staff','Coordinator') NOT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `recipient_email` varchar(100) DEFAULT NULL,
  `notification_type` enum('Idea_Submitted','Comment_Added','Reply_Added','Vote_Added','Inappropriate_Report') NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `idea_id` int(11) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_notifications`
--

INSERT INTO `system_notifications` (`id`, `recipient_type`, `recipient_id`, `recipient_email`, `notification_type`, `title`, `message`, `idea_id`, `comment_id`, `is_read`, `read_at`, `created_at`) VALUES
(1, '', 10, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New Idea: testing2', 'Anonymous staff submitted: testing2', 7, NULL, 0, NULL, '2026-03-21 06:50:02'),
(2, 'Coordinator', 11, 'lyon123@gmail.com', 'Idea_Submitted', 'New Idea: testing3', 'Anonymous staff submitted: testing3', 8, NULL, 0, NULL, '2026-03-21 06:58:09'),
(3, '', 10, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New Idea: testing3', 'Anonymous staff submitted: testing3', 8, NULL, 0, NULL, '2026-03-21 06:58:09'),
(4, 'Coordinator', 11, 'lyon123@gmail.com', 'Idea_Submitted', 'New Idea: 333', 'Staff User Two submitted: 333', 9, NULL, 0, NULL, '2026-03-21 09:05:11'),
(5, '', 10, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New Idea: 333', 'Staff User Two submitted: 333', 9, NULL, 0, NULL, '2026-03-21 09:05:11'),
(6, 'Coordinator', 11, 'lyon123@gmail.com', 'Idea_Submitted', 'New Idea: 1', 'Staff User Two submitted: 1', 10, NULL, 0, NULL, '2026-03-22 05:29:02'),
(7, '', 10, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New Idea: 1', 'Staff User Two submitted: 1', 10, NULL, 0, NULL, '2026-03-22 05:29:02'),
(8, 'Staff', NULL, 'staff2@example.com', '', 'Coordinator Comment on Your Idea', 'Leyon commented: test', 10, 7, 0, NULL, '2026-03-22 05:58:29'),
(9, 'Coordinator', 11, 'lyon123@gmail.com', 'Idea_Submitted', 'New Idea: t3', 'Anonymous staff submitted: t3', 11, NULL, 0, NULL, '2026-03-22 06:03:05'),
(10, '', 10, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New Idea: t3', 'Anonymous staff submitted: t3', 11, NULL, 0, NULL, '2026-03-22 06:03:05'),
(11, 'Staff', NULL, 'staff2@example.com', '', 'Coordinator Comment on Your Idea', 'Leyon commented: test111', 11, 8, 0, NULL, '2026-03-22 06:05:09'),
(12, 'Coordinator', 11, 'lyon123@gmail.com', 'Idea_Submitted', 'New Idea: 4', 'Staff User Two submitted: 4', 12, NULL, 0, NULL, '2026-03-22 13:46:16'),
(13, '', 10, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New Idea: 4', 'Staff User Two submitted: 4', 12, NULL, 0, NULL, '2026-03-22 13:46:16'),
(14, 'Staff', NULL, 'staff2@example.com', '', 'Coordinator Comment on Your Idea', 'Leyon commented: test', 12, 9, 0, NULL, '2026-03-22 13:53:04'),
(15, 'Coordinator', 11, 'lyon123@gmail.com', 'Idea_Submitted', 'New idea submitted in sample campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: sample\nIdea Title: testing1\nAnonymous Submission: Yes\nIdea Preview: testing1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 13, NULL, 0, NULL, '2026-03-24 09:37:34'),
(16, '', 10, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in sample campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: sample\nIdea Title: testing1\nAnonymous Submission: Yes\nIdea Preview: testing1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 13, NULL, 0, NULL, '2026-03-24 09:37:37'),
(17, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in sample campaign', 'Hello Coordinator,\n\nStaff AHO from Innovation department has submitted a new idea.\n\nStaff Name: AHO\nDepartment: Innovation\nCampaign: sample\nIdea Title: TESTING2\nAnonymous Submission: No\nIdea Preview: tt1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 14, NULL, 0, NULL, '2026-03-24 10:08:45'),
(18, 'Staff', NULL, 'andyoo553@gmail.com', '', 'Coordinator reply in sample campaign: TESTING2', 'Hello AHO,\n\nCoordinator h from innovation department has replied back to your idea.\n\nIdea Title: TESTING2\nCampaign: sample\nCoordinator: h\nDepartment: innovation\nReply Preview: test2\n\nPlease sign in to the system to review the full feedback on your idea.\nThis is an automated notification from Ideas System', 14, 10, 0, NULL, '2026-03-24 10:10:59'),
(19, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in test2 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: test2\nIdea Title: test1\nAnonymous Submission: No\nIdea Preview: test1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 15, NULL, 0, NULL, '2026-03-24 10:50:50'),
(20, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in test2 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: test2\nIdea Title: test1\nAnonymous Submission: No\nIdea Preview: test1\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 15, NULL, 0, NULL, '2026-03-24 10:50:54'),
(21, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in 111 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 111\nIdea Title: 111\nAnonymous Submission: Yes\nIdea Preview: 111\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 16, NULL, 0, NULL, '2026-04-18 04:48:12'),
(22, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in 111 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 111\nIdea Title: 111\nAnonymous Submission: Yes\nIdea Preview: 111\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 16, NULL, 0, NULL, '2026-04-18 04:48:16'),
(23, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in 111 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 111\nIdea Title: 222\nAnonymous Submission: Yes\nIdea Preview: 222\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 17, NULL, 0, NULL, '2026-04-18 04:48:48'),
(24, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in 111 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 111\nIdea Title: 222\nAnonymous Submission: Yes\nIdea Preview: 222\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 17, NULL, 0, NULL, '2026-04-18 04:48:53'),
(25, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in 222 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 222\nIdea Title: 222\nAnonymous Submission: No\nIdea Preview: 222\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 18, NULL, 0, NULL, '2026-04-18 06:50:27'),
(26, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in 222 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: 222\nIdea Title: 222\nAnonymous Submission: No\nIdea Preview: 222\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 18, NULL, 0, NULL, '2026-04-18 06:50:31'),
(27, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Counseling Hub for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes creating a combined peer-support and digital counseling platform to improve student mental health awareness and access to help. Many students experience stress, anxiety, and academic pressure but hesit\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 19, NULL, 0, NULL, '2026-04-19 06:56:14'),
(28, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Counseling Hub for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes creating a combined peer-support and digital counseling platform to improve student mental health awareness and access to help. Many students experience stress, anxiety, and academic pressure but hesit\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 19, NULL, 0, NULL, '2026-04-19 06:56:19'),
(29, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Campus Mental Wellness Break Program\nAnonymous Submission: No\nIdea Preview: This idea introduces a dedicated “Recharge Week” once per semester where students can step back from academic pressure and focus on their mental well-being. During this week, no major exams, deadlines, or heavy coursewor\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 20, NULL, 0, NULL, '2026-04-19 06:58:32'),
(30, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Campus Mental Wellness Break Program\nAnonymous Submission: No\nIdea Preview: This idea introduces a dedicated “Recharge Week” once per semester where students can step back from academic pressure and focus on their mental well-being. During this week, no major exams, deadlines, or heavy coursewor\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 20, NULL, 0, NULL, '2026-04-19 06:58:37'),
(31, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: AI-Powered Personalized Learning Dashboard for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes developing an AI-powered digital learning dashboard that personalizes each student’s learning experience based on their performance, behavior, and learning pace. Many students struggle with one-size-fi\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 21, NULL, 0, NULL, '2026-04-19 07:00:16'),
(32, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: AI-Powered Personalized Learning Dashboard for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes developing an AI-powered digital learning dashboard that personalizes each student’s learning experience based on their performance, behavior, and learning pace. Many students struggle with one-size-fi\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 21, NULL, 0, NULL, '2026-04-19 07:00:22'),
(33, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Offline-First Learning App for Low-Connectivity Students\nAnonymous Submission: No\nIdea Preview: This idea focuses on improving digital learning accessibility for students who face unstable or limited internet access. Many students struggle to attend live classes or access materials consistently due to poor connecti\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 22, NULL, 0, NULL, '2026-04-19 07:01:39'),
(34, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Offline-First Learning App for Low-Connectivity Students\nAnonymous Submission: No\nIdea Preview: This idea focuses on improving digital learning accessibility for students who face unstable or limited internet access. Many students struggle to attend live classes or access materials consistently due to poor connecti\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 22, NULL, 0, NULL, '2026-04-19 07:01:44'),
(35, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: 24/7 Mental Health Chatbot for Students\nAnonymous Submission: No\nIdea Preview: Develop an AI-powered chatbot available on the university website and mobile app to provide instant mental health support. The chatbot can answer common questions, guide students through breathing exercises, and direct t\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 23, NULL, 0, NULL, '2026-04-19 07:05:09'),
(36, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: 24/7 Mental Health Chatbot for Students\nAnonymous Submission: No\nIdea Preview: Develop an AI-powered chatbot available on the university website and mobile app to provide instant mental health support. The chatbot can answer common questions, guide students through breathing exercises, and direct t\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 23, NULL, 0, NULL, '2026-04-19 07:05:14'),
(37, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Weekly “No Stress” Campus Hour\nAnonymous Submission: Yes\nIdea Preview: Introduce a weekly one-hour break across campus where no classes, meetings, or deadlines are scheduled. During this time, students can join relaxing activities like yoga, meditation, music, or art sessions to reduce stre\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 24, NULL, 0, NULL, '2026-04-19 07:06:17'),
(38, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Weekly “No Stress” Campus Hour\nAnonymous Submission: Yes\nIdea Preview: Introduce a weekly one-hour break across campus where no classes, meetings, or deadlines are scheduled. During this time, students can join relaxing activities like yoga, meditation, music, or art sessions to reduce stre\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 24, NULL, 0, NULL, '2026-04-19 07:06:21'),
(39, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Virtual Reality (VR) Classrooms for Interactive Learning\nAnonymous Submission: Yes\nIdea Preview: Introduce VR-based classrooms where students can experience immersive learning environments. For example, medical students can practice surgeries virtually, while history students can explore ancient civilizations. This\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 25, NULL, 0, NULL, '2026-04-19 07:07:20'),
(40, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Virtual Reality (VR) Classrooms for Interactive Learning\nAnonymous Submission: Yes\nIdea Preview: Introduce VR-based classrooms where students can experience immersive learning environments. For example, medical students can practice surgeries virtually, while history students can explore ancient civilizations. This\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 25, NULL, 0, NULL, '2026-04-19 07:07:24'),
(41, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Staff User Two from Innovation department has submitted a new idea.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Smart Attendance System Using Facial Recognition\nAnonymous Submission: No\nIdea Preview: Implement a facial recognition system to automatically track attendance in classrooms. This reduces manual work, prevents proxy attendance, and ensures accurate records.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 26, NULL, 0, NULL, '2026-04-19 07:08:09'),
(42, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Staff User Two\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Smart Attendance System Using Facial Recognition\nAnonymous Submission: No\nIdea Preview: Implement a facial recognition system to automatically track attendance in classrooms. This reduces manual work, prevents proxy attendance, and ensures accurate records.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 26, NULL, 0, NULL, '2026-04-19 07:08:13'),
(43, 'Staff', NULL, 'staff2@example.com', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Virtual Reality (VR) Classrooms for Interactive Learning', 'Hello Staff User Two,\n\nA new comment has been posted on your idea.\n\nIdea Title: Virtual Reality (VR) Classrooms for Interactive Learning\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Staff User Two\nComment Preview: Recommends videos, readings, and quizzes tailored to individual learning styles (visual, auditory, kinesthetic)\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 25, 11, 0, NULL, '2026-04-19 07:10:03'),
(44, 'Staff', NULL, 'staff2@example.com', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Smart Attendance System Using Facial Recognition', 'Hello Staff User Two,\n\nA new comment has been posted on your idea.\n\nIdea Title: Smart Attendance System Using Facial Recognition\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: real-time progress, performance trends, and areas needing improvement\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 26, 12, 0, NULL, '2026-04-19 07:10:45'),
(45, 'Staff', NULL, 'leyonhal5@gmail.com', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Campus Mental Wellness Break Program', 'Hello Leon,\n\nA new comment has been posted on your idea.\n\nIdea Title: Campus Mental Wellness Break Program\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Staff User Two\nComment Preview: Identifies at-risk students and sends alerts to both students and instructors.\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 20, 13, 0, NULL, '2026-04-19 07:11:54'),
(46, 'Staff', NULL, 'leyonhal5@gmail.com', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Peer Support & Digital Counseling Hub for Students', 'Hello Leon,\n\nA new comment has been posted on your idea.\n\nIdea Title: Peer Support & Digital Counseling Hub for Students\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: improve student engagement, reduce dropout rates, and enhance overall academic performance\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 19, 14, 0, NULL, '2026-04-19 07:12:35'),
(47, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Eco-Friendly Paperless Assignment Submission System\nAnonymous Submission: No\nIdea Preview: Encourage digital submission and grading of assignments to reduce paper usage. The system will include annotation tools for lecturers and version tracking for students.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 27, NULL, 0, NULL, '2026-04-19 07:14:39'),
(48, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Eco-Friendly Paperless Assignment Submission System\nAnonymous Submission: No\nIdea Preview: Encourage digital submission and grading of assignments to reduce paper usage. The system will include annotation tools for lecturers and version tracking for students.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 27, NULL, 0, NULL, '2026-04-19 07:14:43'),
(49, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Centralized Internship and Job Matching Portal\nAnonymous Submission: Yes\nIdea Preview: Develop a portal that matches students with internships and job opportunities based on their skills, courses, and interests using AI recommendations.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 28, NULL, 0, NULL, '2026-04-19 07:15:46'),
(50, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Centralized Internship and Job Matching Portal\nAnonymous Submission: Yes\nIdea Preview: Develop a portal that matches students with internships and job opportunities based on their skills, courses, and interests using AI recommendations.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 28, NULL, 0, NULL, '2026-04-19 07:15:52'),
(51, 'Staff', NULL, 'staff1@example.com', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Centralized Internship and Job Matching Portal', 'Hello Test Staff,\n\nA new comment has been posted on your idea.\n\nIdea Title: Centralized Internship and Job Matching Portal\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: matches students with internships and job opportunities\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 28, 15, 0, NULL, '2026-04-19 07:16:54'),
(52, 'Staff', NULL, 'staff2@example.com', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Smart Attendance System Using Facial Recognition', 'Hello Staff User Two,\n\nA new comment has been posted on your idea.\n\nIdea Title: Smart Attendance System Using Facial Recognition\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Test Staff\nComment Preview: Smart Content Suggestions\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 26, 16, 0, NULL, '2026-04-19 07:17:26'),
(53, 'Staff', NULL, 'leyonhal5@gmail.com', 'Comment_Added', 'New comment on your idea in Enhancing Digital Learning Experience 2026: Offline-First Learning App for Low-Connectivity Students', 'Hello Leon,\n\nA new comment has been posted on your idea.\n\nIdea Title: Offline-First Learning App for Low-Connectivity Students\nCampaign: Enhancing Digital Learning Experience 2026\nDepartment: Innovation\nCommented By: Test Staff\nComment Preview: dentifies at-risk students\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 22, 17, 0, NULL, '2026-04-19 07:17:54'),
(54, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mental Health Workshops Series\nAnonymous Submission: No\nIdea Preview: Organize monthly workshops on topics like anxiety management, time management, emotional resilience, and healthy lifestyle habits. These sessions can be led by professionals and open to all students.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 29, NULL, 0, NULL, '2026-04-19 07:19:38'),
(55, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mental Health Workshops Series\nAnonymous Submission: No\nIdea Preview: Organize monthly workshops on topics like anxiety management, time management, emotional resilience, and healthy lifestyle habits. These sessions can be led by professionals and open to all students.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 29, NULL, 0, NULL, '2026-04-19 07:19:43'),
(56, 'Staff', NULL, 'staff1@example.com', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Mental Health Workshops Series', 'Hello Test Staff,\n\nA new comment has been posted on your idea.\n\nIdea Title: Mental Health Workshops Series\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: real-time progress, performance trends, and areas needing improvement\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 29, 18, 0, NULL, '2026-04-19 07:20:23'),
(57, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Test Staff from Innovation department has submitted a new idea.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Feedback & Help Platform\nAnonymous Submission: No\nIdea Preview: Create an online platform where students can anonymously share concerns, report stress factors, or request help. The system can route issues to appropriate departments for quick response.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 30, NULL, 0, NULL, '2026-04-19 07:22:48'),
(58, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Test Staff\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Feedback & Help Platform\nAnonymous Submission: No\nIdea Preview: Create an online platform where students can anonymously share concerns, report stress factors, or request help. The system can route issues to appropriate departments for quick response.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 30, NULL, 0, NULL, '2026-04-19 07:22:52'),
(59, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello Coordinator,\n\nStaff aaa from Administration department has submitted a new idea.\n\nStaff Name: aaa\nDepartment: Administration\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Automated Feedback Collection System for Courses\nAnonymous Submission: No\nIdea Preview: Develop a system that collects real-time feedback from students during the semester instead of only at the end. This allows lecturers to improve teaching methods quickly.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 31, NULL, 0, NULL, '2026-04-19 07:24:37'),
(60, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Enhancing Digital Learning Experience 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: aaa\nDepartment: Administration\nCampaign: Enhancing Digital Learning Experience 2026\nIdea Title: Automated Feedback Collection System for Courses\nAnonymous Submission: No\nIdea Preview: Develop a system that collects real-time feedback from students during the semester instead of only at the end. This allows lecturers to improve teaching methods quickly.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 31, NULL, 0, NULL, '2026-04-19 07:24:42'),
(61, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff aaa from Administration department has submitted a new idea.\n\nStaff Name: aaa\nDepartment: Administration\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: “Buddy System” for New Students\nAnonymous Submission: No\nIdea Preview: Pair new students with senior student mentors who provide guidance, emotional support, and help them adjust to university life. This reduces loneliness and improves mental wellbeing.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 32, NULL, 0, NULL, '2026-04-19 07:25:27'),
(62, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: aaa\nDepartment: Administration\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: “Buddy System” for New Students\nAnonymous Submission: No\nIdea Preview: Pair new students with senior student mentors who provide guidance, emotional support, and help them adjust to university life. This reduces loneliness and improves mental wellbeing.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 32, NULL, 0, NULL, '2026-04-19 07:25:32'),
(63, 'Staff', NULL, 'staff1@example.com', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Anonymous Feedback & Help Platform', 'Hello Test Staff,\n\nA new comment has been posted on your idea.\n\nIdea Title: Anonymous Feedback & Help Platform\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: Offer short online courses with certifications in digital skills such as coding\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 30, 19, 0, NULL, '2026-04-19 07:26:39'),
(64, 'Staff', NULL, 'staff1@example.com', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Mental Health Workshops Series', 'Hello Test Staff,\n\nA new comment has been posted on your idea.\n\nIdea Title: Mental Health Workshops Series\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Staff member\nComment Preview: analyze students’ learning behavior, performance, and engagement\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 29, 20, 0, NULL, '2026-04-19 07:27:26'),
(65, 'Staff', NULL, 'leyonhal5@gmail.com', 'Comment_Added', 'New comment on your idea in Student Mental Health Awareness Campaign 2026: Peer Support & Digital Counseling Hub for Students', 'Hello Leon,\n\nA new comment has been posted on your idea.\n\nIdea Title: Peer Support & Digital Counseling Hub for Students\nCampaign: Student Mental Health Awareness Campaign 2026\nDepartment: Innovation\nCommented By: Anonymous staff member\nComment Preview: may create a hostile environment and violate community guidelines\n\nPlease sign in to the system to read the full discussion and continue the conversation.\nThis is an automated notification from Ideas System', 19, 21, 0, NULL, '2026-04-19 07:34:33'),
(66, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff bbb from Marketing department has submitted a new idea.\n\nStaff Name: bbb\nDepartment: Marketing\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Exam Period Wellness Kits\nAnonymous Submission: No\nIdea Preview: Distribute wellness kits during exam seasons containing snacks, motivational notes, stress-relief items, and mental health resources. This supports students during high-pressure periods.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 33, NULL, 0, NULL, '2026-04-19 07:36:33'),
(67, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: bbb\nDepartment: Marketing\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Exam Period Wellness Kits\nAnonymous Submission: No\nIdea Preview: Distribute wellness kits during exam seasons containing snacks, motivational notes, stress-relief items, and mental health resources. This supports students during high-pressure periods.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 33, NULL, 0, NULL, '2026-04-19 07:36:37'),
(68, 'Staff', NULL, 'leyonhal5@gmail.com', '', 'Coordinator reply in Student Mental Health Awareness Campaign 2026 campaign: Campus Mental Wellness Break Program', 'Hello Leon,\n\nCoordinator h from innovation department has replied back to your idea.\n\nIdea Title: Campus Mental Wellness Break Program\nCampaign: Student Mental Health Awareness Campaign 2026\nCoordinator: h\nDepartment: innovation\nReply Preview: reply\n\nPlease sign in to the system to review the full feedback on your idea.\nThis is an automated notification from Ideas System', 20, 22, 0, NULL, '2026-04-19 08:38:08'),
(69, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Wellbeing Program for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambas\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 34, NULL, 0, NULL, '2026-04-19 14:52:15'),
(70, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Wellbeing Program for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambas\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 34, NULL, 0, NULL, '2026-04-19 14:52:20'),
(71, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Wellbeing Program for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambas\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 35, NULL, 0, NULL, '2026-04-19 14:52:43'),
(72, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Peer Support & Digital Wellbeing Program for Students\nAnonymous Submission: No\nIdea Preview: This idea proposes a combined peer-support and digital wellbeing initiative to improve student mental health awareness and support across campus. The program will train selected student volunteers as “Mental Health Ambas\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 35, NULL, 0, NULL, '2026-04-19 14:52:47'),
(73, 'Coordinator', 12, '13halhtutalin@gmail.com', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff Leon from Innovation department has submitted a new idea.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: The Vent Tent\nAnonymous Submission: No\nIdea Preview: A weekly, informal pop-up station located in high-traffic campus areas where students can grab a free coffee and talk to trained student volunteers. Unlike formal counseling, this offers a low-pressure environment for st\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 36, NULL, 0, NULL, '2026-04-19 15:02:25'),
(74, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: Leon\nDepartment: Innovation\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: The Vent Tent\nAnonymous Submission: No\nIdea Preview: A weekly, informal pop-up station located in high-traffic campus areas where students can grab a free coffee and talk to trained student volunteers. Unlike formal counseling, this offers a low-pressure environment for st\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 36, NULL, 0, NULL, '2026-04-19 15:02:29'),
(75, 'Staff', NULL, 'leyonhal5@gmail.com', '', 'Coordinator reply in Student Mental Health Awareness Campaign 2026 campaign: The Vent Tent', 'Hello Leon,\n\nCoordinator h from innovation department has replied back to your idea.\n\nIdea Title: The Vent Tent\nCampaign: Student Mental Health Awareness Campaign 2026\nCoordinator: h\nDepartment: innovation\nReply Preview: This is a well-thought-out initiative that addresses a real need among students. Introducing a “Recharge Week” could have a positive impact on reducing stress and improving overall wellbeing. Before moving forward, we ma\n\nPlease sign in to the system to review the full feedback on your idea.\nThis is an automated notification from Ideas System', 36, 23, 0, NULL, '2026-04-19 15:05:31'),
(76, 'Coordinator', 20, 'imsqacoordinator01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 01 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mindful Mornings: Peer-Led Meditation Circles\nAnonymous Submission: No\nIdea Preview: A 15-minute guided mindfulness session held every Monday and Wednesday before first class. Students take turns leading simple breathing exercises, body scans, or gratitude journaling. Promotes calm and connection before\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 37, NULL, 0, NULL, '2026-04-20 13:41:45'),
(77, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mindful Mornings: Peer-Led Meditation Circles\nAnonymous Submission: No\nIdea Preview: A 15-minute guided mindfulness session held every Monday and Wednesday before first class. Students take turns leading simple breathing exercises, body scans, or gratitude journaling. Promotes calm and connection before\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 37, NULL, 0, NULL, '2026-04-20 13:41:50'),
(78, '', 19, 'imsqamanager01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mindful Mornings: Peer-Led Meditation Circles\nAnonymous Submission: No\nIdea Preview: A 15-minute guided mindfulness session held every Monday and Wednesday before first class. Students take turns leading simple breathing exercises, body scans, or gratitude journaling. Promotes calm and connection before\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 37, NULL, 0, NULL, '2026-04-20 13:41:56'),
(79, 'Coordinator', 20, 'imsqacoordinator01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 01 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Stress Less Exam Kits\nAnonymous Submission: No\nIdea Preview: Distribute free kits during midterms and finals containing earplugs, herbal tea, a stress ball, a study schedule template, and a list of campus mental health resources. Designed to reduce last-minute panic and encourage\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 38, NULL, 0, NULL, '2026-04-20 13:42:41'),
(80, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Stress Less Exam Kits\nAnonymous Submission: No\nIdea Preview: Distribute free kits during midterms and finals containing earplugs, herbal tea, a stress ball, a study schedule template, and a list of campus mental health resources. Designed to reduce last-minute panic and encourage\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 38, NULL, 0, NULL, '2026-04-20 13:42:46'),
(81, '', 19, 'imsqamanager01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Stress Less Exam Kits\nAnonymous Submission: No\nIdea Preview: Distribute free kits during midterms and finals containing earplugs, herbal tea, a stress ball, a study schedule template, and a list of campus mental health resources. Designed to reduce last-minute panic and encourage\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 38, NULL, 0, NULL, '2026-04-20 13:42:51');
INSERT INTO `system_notifications` (`id`, `recipient_type`, `recipient_id`, `recipient_email`, `notification_type`, `title`, `message`, `idea_id`, `comment_id`, `is_read`, `read_at`, `created_at`) VALUES
(82, 'Coordinator', 20, 'imsqacoordinator01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 01 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Story Wall\nAnonymous Submission: No\nIdea Preview: A physical and digital bulletin board where students can anonymously post short experiences about mental health struggles, recovery, or encouragement. Updated weekly. Reduces stigma by showing that no one is alone in the\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 39, NULL, 0, NULL, '2026-04-20 13:45:14'),
(83, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Story Wall\nAnonymous Submission: No\nIdea Preview: A physical and digital bulletin board where students can anonymously post short experiences about mental health struggles, recovery, or encouragement. Updated weekly. Reduces stigma by showing that no one is alone in the\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 39, NULL, 0, NULL, '2026-04-20 13:45:19'),
(84, '', 19, 'imsqamanager01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Anonymous Story Wall\nAnonymous Submission: No\nIdea Preview: A physical and digital bulletin board where students can anonymously post short experiences about mental health struggles, recovery, or encouragement. Updated weekly. Reduces stigma by showing that no one is alone in the\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 39, NULL, 0, NULL, '2026-04-20 13:45:25'),
(85, 'Coordinator', 20, 'imsqacoordinator01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 01 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Faculty–Student Mental Health First Aid Training\nAnonymous Submission: No\nIdea Preview: A 2-hour workshop for professors and TAs to recognize warning signs (e.g., withdrawal, sudden grade drops) and respond with empathy. Includes role-play scenarios and referral pathways. Builds a supportive academic enviro\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 40, NULL, 0, NULL, '2026-04-20 13:46:10'),
(86, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Faculty–Student Mental Health First Aid Training\nAnonymous Submission: No\nIdea Preview: A 2-hour workshop for professors and TAs to recognize warning signs (e.g., withdrawal, sudden grade drops) and respond with empathy. Includes role-play scenarios and referral pathways. Builds a supportive academic enviro\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 40, NULL, 0, NULL, '2026-04-20 13:46:14'),
(87, '', 19, 'imsqamanager01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 01\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Faculty–Student Mental Health First Aid Training\nAnonymous Submission: No\nIdea Preview: A 2-hour workshop for professors and TAs to recognize warning signs (e.g., withdrawal, sudden grade drops) and respond with empathy. Includes role-play scenarios and referral pathways. Builds a supportive academic enviro\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 40, NULL, 0, NULL, '2026-04-20 13:46:20'),
(88, 'Coordinator', 20, 'imsqacoordinator01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 02 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Creative Coping: Art & Music Therapy Pop-Ups\nAnonymous Submission: No\nIdea Preview: Weekly drop-in sessions in the student lounge with coloring sheets, clay, collage materials, and a keyboard. No art skills needed. Students create while listening to lo-fi beats – proven to lower cortisol levels.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 41, NULL, 0, NULL, '2026-04-20 13:48:00'),
(89, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Creative Coping: Art & Music Therapy Pop-Ups\nAnonymous Submission: No\nIdea Preview: Weekly drop-in sessions in the student lounge with coloring sheets, clay, collage materials, and a keyboard. No art skills needed. Students create while listening to lo-fi beats – proven to lower cortisol levels.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 41, NULL, 0, NULL, '2026-04-20 13:48:05'),
(90, '', 19, 'imsqamanager01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Creative Coping: Art & Music Therapy Pop-Ups\nAnonymous Submission: No\nIdea Preview: Weekly drop-in sessions in the student lounge with coloring sheets, clay, collage materials, and a keyboard. No art skills needed. Students create while listening to lo-fi beats – proven to lower cortisol levels.\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 41, NULL, 0, NULL, '2026-04-20 13:48:09'),
(91, 'Coordinator', 20, 'imsqacoordinator01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 02 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Night Line: Student-Run Peer Listening Service\nAnonymous Submission: No\nIdea Preview: A confidential hotline (8 PM–12 AM) staffed by trained student volunteers. Offers non-judgmental listening, crisis resource referral, and “warm handoffs” to counseling services. Expands access for evening loneliness or p\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 42, NULL, 0, NULL, '2026-04-20 13:48:45'),
(92, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Night Line: Student-Run Peer Listening Service\nAnonymous Submission: No\nIdea Preview: A confidential hotline (8 PM–12 AM) staffed by trained student volunteers. Offers non-judgmental listening, crisis resource referral, and “warm handoffs” to counseling services. Expands access for evening loneliness or p\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 42, NULL, 0, NULL, '2026-04-20 13:48:50'),
(93, '', 19, 'imsqamanager01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Night Line: Student-Run Peer Listening Service\nAnonymous Submission: No\nIdea Preview: A confidential hotline (8 PM–12 AM) staffed by trained student volunteers. Offers non-judgmental listening, crisis resource referral, and “warm handoffs” to counseling services. Expands access for evening loneliness or p\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 42, NULL, 0, NULL, '2026-04-20 13:48:56'),
(94, 'Coordinator', 20, 'imsqacoordinator01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 02 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mind & Body Walk & Talk\nAnonymous Submission: No\nIdea Preview: A guided 30-minute walk around campus followed by 30 minutes of open conversation under a tree. Combines light exercise (boosts endorphins) with organic social connection. No pressure to share – just walking together hel\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 43, NULL, 0, NULL, '2026-04-20 13:51:08'),
(95, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mind & Body Walk & Talk\nAnonymous Submission: No\nIdea Preview: A guided 30-minute walk around campus followed by 30 minutes of open conversation under a tree. Combines light exercise (boosts endorphins) with organic social connection. No pressure to share – just walking together hel\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 43, NULL, 0, NULL, '2026-04-20 13:51:13'),
(96, '', 19, 'imsqamanager01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Mind & Body Walk & Talk\nAnonymous Submission: No\nIdea Preview: A guided 30-minute walk around campus followed by 30 minutes of open conversation under a tree. Combines light exercise (boosts endorphins) with organic social connection. No pressure to share – just walking together hel\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 43, NULL, 0, NULL, '2026-04-20 13:51:18'),
(97, 'Coordinator', 20, 'imsqacoordinator01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello Coordinator,\n\nStaff IMS Staff 02 from IMS department has submitted a new idea.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Digital Detox Challenge\nAnonymous Submission: No\nIdea Preview: A 24-hour opt-in challenge where students put their phones on grayscale and log screen-free activities (reading, cooking, chatting). Participants get a small prize and a reflection sheet. Raises awareness of social media\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 44, NULL, 0, NULL, '2026-04-20 13:51:43'),
(98, '', 14, 'manager@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Digital Detox Challenge\nAnonymous Submission: No\nIdea Preview: A 24-hour opt-in challenge where students put their phones on grayscale and log screen-free activities (reading, cooking, chatting). Participants get a small prize and a reflection sheet. Raises awareness of social media\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 44, NULL, 0, NULL, '2026-04-20 13:51:48'),
(99, '', 19, 'imsqamanager01@ewsd.local', 'Idea_Submitted', 'New idea submitted in Student Mental Health Awareness Campaign 2026 campaign', 'Hello QA Manager,\n\nA new idea has been submitted for review.\n\nStaff Name: IMS Staff 02\nDepartment: IMS\nCampaign: Student Mental Health Awareness Campaign 2026\nIdea Title: Digital Detox Challenge\nAnonymous Submission: No\nIdea Preview: A 24-hour opt-in challenge where students put their phones on grayscale and log screen-free activities (reading, cooking, chatting). Participants get a small prize and a reflection sheet. Raises awareness of social media\n\nPlease sign in to the system to review the full idea submission.\nThis is an automated notification from Ideas System', 44, NULL, 0, NULL, '2026-04-20 13:51:53');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(120) NOT NULL,
  `setting_value` longtext NOT NULL,
  `value_type` enum('string','int','bool','json') NOT NULL DEFAULT 'string',
  `description` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `value_type`, `description`, `updated_at`) VALUES
(1, 'idea_submissions_enabled', '1', 'bool', 'Global switch for idea submissions', '2026-03-21 04:08:22'),
(2, 'commenting_enabled', '1', 'bool', 'Global switch for comments and replies', '2026-03-21 04:08:22'),
(3, 'default_ideas_per_page', '5', 'int', 'Default ideas pagination size', '2026-03-21 04:08:22'),
(4, 'max_upload_size_mb', '10', 'int', 'Maximum upload size in MB', '2026-03-21 04:08:22'),
(5, 'allowed_file_types', '[\"pdf\",\"doc\",\"docx\",\"xls\",\"xlsx\",\"jpg\",\"jpeg\",\"png\",\"gif\"]', 'json', 'Allowed attachment file extensions', '2026-03-21 04:08:22'),
(6, 'session_timeout_minutes', '1440', 'int', 'Session timeout in minutes', '2026-03-21 04:08:22'),
(7, 'password_policy', '{\"min_length\":8,\"require_uppercase\":true,\"require_number\":true,\"require_symbol\":false}', 'json', 'Password policy settings', '2026-03-21 04:08:22'),
(8, 'smtp_settings', '{\"host\":\"\",\"port\":587,\"username\":\"\",\"password\":\"\",\"encryption\":\"tls\",\"from_email\":\"\",\"from_name\":\"Ideas System\"}', 'json', 'SMTP server settings', '2026-03-21 04:08:22');

-- --------------------------------------------------------

--
-- Table structure for table `terms_and_conditions`
--

CREATE TABLE `terms_and_conditions` (
  `id` int(11) NOT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `content` longtext NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `terms_and_conditions`
--

INSERT INTO `terms_and_conditions` (`id`, `version`, `content`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, '# Terms and Conditions for Idea Submission\r\n\r\n## 1. Intellectual Property Rights\r\nBy submitting an idea, you grant the organization a non-exclusive license to use your idea for internal purposes.\r\n\r\n## 2. Content Guidelines\r\n- No discriminatory, defamatory, or harassing content\r\n- No confidential or proprietary information of third parties\r\n- No spam or advertising\r\n- No illegal content\r\n\r\n## 3. Anonymity\r\nWhile you may submit ideas anonymously, the QA team can see the submitter for moderation purposes.\r\n\r\n## 4. Respect\r\n- Be respectful in comments\r\n- Constructive criticism only\r\n- No personal attacks or harassment\r\n\r\n## 5. Liability\r\nThe organization is not liable for any damages related to idea submission or discussion.\r\n\r\n## 6. Modifications\r\nThese terms may be updated at any time. Continued use implies acceptance.\r\n\r\nBy checking the box below, you agree to these Terms and Conditions.', 1, '2026-03-20 07:07:53', '2026-03-20 07:07:53');

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_sessions`
--

INSERT INTO `user_sessions` (`id`, `admin_id`, `session_token`, `ip_address`, `user_agent`, `expires_at`, `created_at`) VALUES
(74, 9, 'abf91c43406331ebd14cb149307c28c086bc2ba4763e4d554a27c2edf16cdf1c', '::1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.26100.7920', '2026-03-21 11:41:39', '2026-03-20 10:41:39'),
(75, 1, 'eaf500e88527397e0b9244c73cce2c757c90fb9670e94a85d11a0a8b9ca9c7a2', '::1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.26100.7920', '2026-03-21 11:41:39', '2026-03-20 10:41:39'),
(76, 6, 'ae5660cae57a0715204f65e18cb613112385ddf1e6d964d6540476b942a8bbb8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-21 11:42:22', '2026-03-20 10:42:22'),
(77, 9, '7b0b3c9c643b58527152f15688d044b21df7b3c3aa1fc153eacc0d56c96f48d7', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-21 11:44:42', '2026-03-20 10:44:42'),
(78, 1, 'fea1bfcf003efc11be7db4f02c426a3859491bf07d293e75816987e6b0bcafc6', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-21 11:46:24', '2026-03-20 10:46:24'),
(79, 1, '0858af46430d0c1e604035aa5ae70e51b1e3d0edea82855ae3139779d156da51', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-21 11:53:20', '2026-03-20 10:53:20'),
(80, 1, '17715cf9d8a5f0e61667847e602f82c5b9a460bb444664cd02fa71c3e1196158', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-21 11:53:48', '2026-03-20 10:53:48'),
(81, 1, 'fac3b3e095e1d013fe32dd3759ade4adc63901bd72cf833636f4a55fb4693bde', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-21 11:56:47', '2026-03-20 10:56:47'),
(82, 1, 'efdff0eb5873fb4a04d75e56f76f560bbde33ddf6c2dc4c5ed607ac038ee2ad7', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-21 12:01:10', '2026-03-20 11:01:10'),
(83, 1, '1a0f6393430b4103b2eb180ca9526b215a29228fd77be0e01401d93ac0d70b49', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-21 12:09:26', '2026-03-20 11:09:26'),
(84, 1, 'e4a84ca668267b59a9c158dc3f339875151c92dac4b3e409d1f9fa52e6c13512', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 05:08:22', '2026-03-21 04:08:22'),
(86, 1, 'dfe74228b55d9f2ec3f9794c9c2b58f2ad74da0a7499a9d15449b7341ad77a1f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:15:47', '2026-03-21 05:15:47'),
(88, 6, '4b642c9d6e21e7e6646f631b8cd361064e468eba9967a1a8e7350215f1be5447', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:24:36', '2026-03-21 05:24:36'),
(89, 1, '47beb70523bc06981dad1cd6c8f7ea5bdcce2ad6fb4e6d7a980eb4182e70f956', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:25:23', '2026-03-21 05:25:23'),
(92, 1, '4db640e1df5e508231d14d894bbdb449a04d0a212adbf0a5916701253b63cb4e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:35:06', '2026-03-21 05:35:06'),
(93, 9, '38187ec4439f0bf7961f968ebd6f434df00e2e59c3ab70e49b911e5ae1cb9a3d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:36:18', '2026-03-21 05:36:18'),
(95, 6, '1ab6e78c93cdb81dd1d6441860a765387848fc8a8146a69fc616f13f6763e0f4', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:38:44', '2026-03-21 05:38:44'),
(96, 1, 'f03a135f5aa0e123670a3ec85d07c7dbc1c8af10ffda19637edc06ca8fa3cf78', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:41:43', '2026-03-21 05:41:43'),
(97, 9, '4fdf7b7d1109c7430886d44e56a578092ee880053b5121eaaeec72a296314c7d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:43:01', '2026-03-21 05:43:01'),
(99, 1, 'c416dc7c4f9d5bab014d846ce4dcbe25a520f2c98f82e8303b59ca5135a473cf', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:46:07', '2026-03-21 05:46:07'),
(100, 1, '4564c9bd6da2eb3feaeabde9d9fbf950a36584d6b69cb483c4a62f409c6d4ccb', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:49:28', '2026-03-21 05:49:28'),
(104, 6, '15e0934d705c3cc845667887656977a1cc55931204aeba966efb476774c639ba', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 07:47:40', '2026-03-21 06:47:40'),
(106, 9, '0eb9e672acad70c601dc541b6fdab9fe63a72f4e656da27236dc6ace2b7742cd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 07:51:55', '2026-03-21 06:51:55'),
(107, 9, '45be0402c528c8ba22b2311e3136b6430c09299404789b74a605902fe2b6a624', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 07:57:50', '2026-03-21 06:57:50'),
(109, 1, 'b91e602419f9e596ac9a285eeb463e570b50b80117ef61485e171bb30d54e665', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 08:09:42', '2026-03-21 07:09:42'),
(110, 6, '265e9dd175cce037e77a97a688a5a557805b963295893030e2a08154914b09ac', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 09:41:07', '2026-03-21 08:41:07'),
(111, 1, 'fd18729559f2ff453e1440720f5aa94c968e5825416fdc903e02d25e21d5fab2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 09:42:49', '2026-03-21 08:42:49'),
(114, 9, 'b9bc7ed70715930a7a80cbbe3c3a662fc815c076eb4aad51944b0ac45881c75f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 10:02:03', '2026-03-21 09:02:03'),
(116, 9, 'c17b9449bf40cc2aa37ebca5d6b5825df5b7e1056608255816bdb9d97b52a2b9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 10:06:58', '2026-03-21 09:06:58'),
(117, 1, '0119fc76a75f1258d575201dcb5f49254fd7c30aa696a3e05285721fb301d4f0', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:03:24', '2026-03-22 05:03:24'),
(119, 1, 'b79344e6542e30dfc11b340c93fcfe361245894268bdc5f1868cc5e1c984e218', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:05:49', '2026-03-22 05:05:49'),
(121, 1, '188a79168773dddc72fb03793eb9839588f2de35a9179c74d279f8c764430a08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:08:48', '2026-03-22 05:08:48'),
(123, 1, '4145faedf40e81a4f0331deb16ae9fb877f15f128aec241f83b01eaccbbadf5d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:22:29', '2026-03-22 05:22:29'),
(125, 9, '8c19f0a814929332e1b5b2e0aedf1553e50a9d4d908df577b4fb4b4d97b203ef', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:26:21', '2026-03-22 05:26:21'),
(126, 9, 'acdc6e00723279789df9a531a3deea5a900055dfe9d704fa46fc5bec29bceebf', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:29:23', '2026-03-22 05:29:23'),
(127, 6, 'eccd8002aab0fb85dd1f3981208e2f6cd4a066c32fbab4943a93001f2bf3319c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:31:22', '2026-03-22 05:31:22'),
(132, 9, '9e44df98efae51b388cddb9cdd2f4b809ffbb27dd6ea614283ba8dca28403223', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:58:48', '2026-03-22 05:58:48'),
(133, 6, 'b91ef4e064e9744966c88f7e59593e2372fc351ece0bf955d017ea161244e448', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:59:09', '2026-03-22 05:59:09'),
(135, 9, '6c236a7cac2df04a8d28321ef78f3e5d2a0d366f6e43a01d62a39346fc7b7697', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 07:02:42', '2026-03-22 06:02:42'),
(139, 1, 'e3df1294ff795ad06e70229bb57a64226c332beaf77ae1e6c2025157fdc2d531', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 14:19:57', '2026-03-22 13:19:57'),
(142, 9, 'b873596ae1432d6b5b8e429ba5b77a7adc130e3fa5b0f36a8434ee190a6ce63d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 14:42:06', '2026-03-22 13:42:06'),
(144, 1, 'b6bf0134ad8bd978e381076710b3b521f0ecc66d5e519d9daf64358dc7552b5f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-24 05:49:57', '2026-03-23 04:49:57'),
(145, 1, '3a442aa0221f6007df8ebe49848087337dbf59305b874c9abfc9de83e0b378f3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-24 05:56:32', '2026-03-23 04:56:32'),
(151, 6, '07a1ef22dd84d2c43e8411628d2b657a401905d1b9ee2ffe63e0be28831aaecb', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-24 06:34:19', '2026-03-23 05:34:19'),
(152, 6, 'f22e82d431c3bdc1022fc260758e214e53828b186dc03abaa962e0fb4ec31055', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 10:33:41', '2026-03-24 09:33:41'),
(154, 6, '8b378b8bf41cb8ebf603f44051717deeb035148bf5474e3775073f782f42ccac', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 10:37:12', '2026-03-24 09:37:12'),
(155, 1, '3f4f8a57a14d1790dc218013cfd05b97caa05b99f1276cc22d63dd7b25938a78', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 10:38:53', '2026-03-24 09:38:53'),
(157, 1, '7f0aa3ad187922614034faa675122ff19b81045838f454bdb639b385f317767b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 10:47:49', '2026-03-24 09:47:49'),
(158, 12, 'fb9a35bcbd014b9d09f67f6f72ad2f9140f8e1cf7712ae036cc1f4bfd82c2861', '::1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.26100.7920', '2026-03-25 10:54:28', '2026-03-24 09:54:28'),
(159, 12, '6fbd3012b7bf51e69f2bc715d61349a5b7408aedb4a3f28f9174dcc6cbe8de6f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 10:55:11', '2026-03-24 09:55:11'),
(160, 1, '67ae8c3d45197af3cb721e3563f8ba97f535b021300788af91fc2001aaea4dd2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 10:59:46', '2026-03-24 09:59:46'),
(161, 13, 'a8e038d4633528c2f3d4ffc8452bb4da9b999a5aacb015b95e94d1c8f0d63e4d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:02:12', '2026-03-24 10:02:12'),
(162, 9, '593902f1df3251cba72ea20b88b8fa05c60fb206502690cf19e1de1ff9ff1ec7', '::1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.26100.7920', '2026-03-25 11:07:02', '2026-03-24 10:07:02'),
(163, 13, '086af79dde3687b9b5a4c7730f4bf64639eb220cd3d9641f5b6b73d7403f9dad', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:08:17', '2026-03-24 10:08:17'),
(164, 12, '534ccd900f19ba23396a062aa0adad491f01692421cbb2efdeffa0ba86348edf', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:10:23', '2026-03-24 10:10:23'),
(165, 1, 'bcbc1db8631ef67331d1be1bea6c300441d74dd1c9bf8e25dceeba19a8f9abd9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:12:31', '2026-03-24 10:12:31'),
(166, 14, '1a84773b8c0f366a405eb7e092c332f8c2a8a104789a38159402a8cd2490947e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:15:12', '2026-03-24 10:15:12'),
(167, 14, '7b3a5bad35737cd08e0adfc3e4e75c16fdb20daac778f4061a81aebd82ad5b0f', '::1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.26100.7920', '2026-03-25 11:18:36', '2026-03-24 10:18:36'),
(168, 1, '16db729f32c01777df8e0d92fa30df52d4c3aa5a8638fa121e113a0911a1cc1f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:20:44', '2026-03-24 10:20:44'),
(169, 14, 'c7dd5cbb2849cf2c3f3aea089f26d3cc73eb31910cd9aed63dd43073fdc254ca', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:22:35', '2026-03-24 10:22:35'),
(170, 14, '52fc40f8887e00efd00cb1b39fdcac34215dfc61c340820ea2700734633e1d41', '::1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.26100.7920', '2026-03-25 11:24:47', '2026-03-24 10:24:47'),
(171, 14, '998ff8d1fac00e0adea658651b8a677aa8393365475c0a371d354a1e6ff9e575', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:27:53', '2026-03-24 10:27:53'),
(172, 9, '0d100d0edf21f452f2582c0bdf995a0349546b71cc679e56057789ab50df0530', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:35:43', '2026-03-24 10:35:43'),
(173, 14, 'f6b083b2b0347d18a9c05f0fa14d603c668eb1e7f8485dc0e87fee56ad310820', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:36:28', '2026-03-24 10:36:28'),
(174, 1, '8e1db531fc61ab1653a2a3145863fe42ef3394920a85e8d3635519182e113ea9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:37:12', '2026-03-24 10:37:12'),
(175, 14, '2646f1bea7366fdcb04a02096002d1ce9ff5620d27df8ebfc0bbdd4ea078b148', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:40:13', '2026-03-24 10:40:13'),
(176, 9, '70d18bc305c2a471413f5fe050898062ea5268ec153ca5aa449e2d8721e879da', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:42:02', '2026-03-24 10:42:02'),
(177, 9, '32e2ea1cbf84b981b53f8f61f6fcc8f086fc3991f6296ef1ae1bab37096b6a5b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:43:09', '2026-03-24 10:43:09'),
(178, 14, '3bd7e29bff692e13b0b8f12608fa9fa336797e6704469d7d745a5bf1ce48df47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:44:09', '2026-03-24 10:44:09'),
(179, 9, '2b2c7c04592b1ddd612ac2247a034d0dcaa069df868f7e7c7c2f60cd5309e228', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:45:22', '2026-03-24 10:45:22'),
(180, 14, 'f7205e5f939ef8c5507d9cff630ba18972de5c59fc0ad5dd3f28042694064472', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:51:19', '2026-03-24 10:51:19'),
(181, 12, '009a3ec0367c2dd42de223d65091696f95e26a57150974a01dc37d668487cdaa', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 11:59:22', '2026-03-24 10:59:22'),
(182, 14, 'bbcc3eb1c6b5e8dddc91d9cf8c038b122d7b9e08733e3070a68757385db6c641', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-25 12:02:40', '2026-03-24 11:02:40'),
(183, 14, '48c118f6c81e61a6af8c8e0e82d333744b29d28864774383f6be9df3222d99d6', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 09:54:26', '2026-03-25 08:54:26'),
(184, 12, '3d9104b9f17117576cddff9987c816587a916b3ad9ce4261874ff475a382c877', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:11:02', '2026-03-25 09:11:02'),
(185, 9, '0046863f3486046d544b86d6d29a4f9c985e7a1822f1e3f53005e4a8f35c4069', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:11:39', '2026-03-25 09:11:39'),
(186, 14, 'd48d89c46826f5179d02d870402551e42e01fc97ecb8832a800d324567e7fa9d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:12:00', '2026-03-25 09:12:00'),
(187, 12, '532ce75fcc1a65700469f4f5af5be6f6a4027fb9d37b6c4eef31fd279c73b237', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:12:18', '2026-03-25 09:12:18'),
(188, 12, 'e186e714403b05ee7f0eede80e81bda937b6493683b45a606f0bfbaa66353c22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:17:57', '2026-03-25 09:17:57'),
(189, 1, '14321dd572b4dfc94d81dfb9029f0650b5747b4e6c865c62b4515946d6e669e4', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:23:52', '2026-03-25 09:23:52'),
(190, 15, '5431d79b871536b76fa627722a7cff10edf875ccda80b55b91a497bd4e394fac', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:28:33', '2026-03-25 09:28:33'),
(191, 16, '21117b8fd5036884bb44e0c71defae04b9bee75c2da0ee2895105c5ef7e8f835', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:28:58', '2026-03-25 09:28:58'),
(192, 12, 'b61415a744b29eac692feb422ce2051b848a1d2422345cf4d0482de34404b8f7', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:29:21', '2026-03-25 09:29:21'),
(193, 14, 'e26ba68a4d7048fc54357bdec53ec3675c1af62b3783b33f48331acae9e9fc99', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:55:48', '2026-03-25 09:55:48'),
(194, 14, 'ed84e9344369f0c17b67490cc7beb764a81a05a8027c2cd001c3e311cbe6cdbe', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:57:09', '2026-03-25 09:57:09'),
(195, 12, 'd009aeea070db16c65e74e18cfa73d99d1ebd864089274337425e26f04a61fed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 10:58:52', '2026-03-25 09:58:52'),
(196, 6, '35bf18e6f3c790cbe70b02aedb82be75620f0caf58b520227e4f26ac4c6bb78e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:00:52', '2026-03-25 10:00:52'),
(197, 14, 'fac57924da76a9f21612ed65faf4876aac52d8903d4d8d2dafeeec6011858d8c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:04:19', '2026-03-25 10:04:19'),
(198, 15, 'c10a5f4341030357594fd09abadab9f9f20be165511cc53b516f44a89069a24e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:15:42', '2026-03-25 10:15:42'),
(199, 12, '0d4e6feadc4015c79629af152d746e31e3d8326590587cdd97609dea7279b628', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:16:13', '2026-03-25 10:16:13'),
(200, 6, '61e61d587f2c94d954caafcaaf7b6650b55734123f0a20937b13a733bae9eea3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:21:57', '2026-03-25 10:21:57'),
(201, 12, 'a977efac0aa0ea2d485601afc00fcd23f5055b8ce24b6320a10e9b0aacc9ebc3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:22:38', '2026-03-25 10:22:38'),
(202, 14, '8c524bd0b71aa74674cc53fe96107fde3fff426f2804752b268b394ebefe8a03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:28:27', '2026-03-25 10:28:27'),
(203, 12, '822c7e17cded2d4614c89d78bc0a1e2b5a6cc3bd587a653a0f9dd14d2bc709eb', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:30:10', '2026-03-25 10:30:10'),
(204, 14, '69cfc19feb1d27a78f103b9fbfd28771ddfabaede8da16fd792251bbce0418fa', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:34:24', '2026-03-25 10:34:24'),
(205, 14, '2a6db4c2f74b1c5693baf231618d64e0ebe4972b8bb2789131107950d23e7828', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:40:59', '2026-03-25 10:40:59'),
(206, 9, '7906e669912a7a17f9ed89518aeb97a0829c48ba266be3ade6f65c134dc01138', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:42:22', '2026-03-25 10:42:22'),
(207, 14, '0cc93fcebb3a241d575aa527990ed3a8d631c45aea43a050748156916d793ff5', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:47:08', '2026-03-25 10:47:08'),
(208, 12, 'd7c2aa184695782af12e99a9e2dfcec47491dea3d0fd6cf7b1721384b95d9c50', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 11:54:28', '2026-03-25 10:54:28'),
(209, 9, 'f4f2f04e2951c456ba3ec875ebf3080d92610f080be23b42c1ccf00bae30edb3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:07:20', '2026-03-25 11:07:20'),
(210, 9, '4e153274b2ef42bf9e5f1fc622ea895668028681aa8e6079b70727a12b206357', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:12:14', '2026-03-25 11:12:14'),
(211, 12, '599766df30537506165a18a178202e44e382e68a580a41d7b757d91d60b666b2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:14:20', '2026-03-25 11:14:20'),
(212, 9, 'a83e63d447fddd758a076ef24f5cdaf5b413b12933a4cbed4139309534af0a5c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:15:15', '2026-03-25 11:15:15'),
(213, 12, '74bfb37a854b707cf4a4ec6c4399b187a14a2e96dc0969fccb883eecafbd7eb4', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:20:54', '2026-03-25 11:20:54'),
(214, 9, '950bbf46d46effbcc4c354b4f7e7cb72875dd8424ddc8b1f5c7d739db00fb847', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:21:52', '2026-03-25 11:21:52'),
(215, 6, 'c7ccf1df857f3ba4cde5ac1d7ff3579c610fe60c48dda85e0af242524959fd3f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:24:17', '2026-03-25 11:24:17'),
(216, 9, '7df61c06e605131502c553b2b865559d4dc92feef22a7c5b062094ee0a77c563', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:27:18', '2026-03-25 11:27:18'),
(217, 6, '3c56375c4eecc6832270f0434c4520e018bc34a1ba749e94f58e280332e059ad', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:30:23', '2026-03-25 11:30:23'),
(218, 14, '0f824dbfa24c3e457d6b9400934ef3d4497f4e86cec341e23e14eff2b5190527', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 12:31:17', '2026-03-25 11:31:17'),
(219, 14, '55aaf90e7196ee05939d7003f367e3822419189b4c36ce55c0c32a26d94a8053', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 13:37:39', '2026-03-25 12:37:39'),
(220, 14, '3a0863c29575405ede74c844052bcf5f36fb0e4a14486b862ab9ebfd4979a361', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 13:49:27', '2026-03-25 12:49:27'),
(221, 9, '6a5c09d499b63e984d0882435cc4071c6d42ac1967f3417c31e6aacd5ab5af74', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 13:57:31', '2026-03-25 12:57:31'),
(222, 14, '2f2bea9ffe5126f74562e7cf56cfacbf5de1383a629053bb1685a6b5096d7ed7', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 13:58:00', '2026-03-25 12:58:00'),
(223, 6, '9dd6ee46c06637a2940f471decc9ad2dd6e28c43af526a3650483a90882709fb', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-26 13:59:19', '2026-03-25 12:59:19'),
(224, 1, 'f6a59bd5f4361cb3a0bbf1ee02fb385e2284c56ded12a550298638909b419ff4', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-30 11:54:39', '2026-03-29 09:54:39'),
(225, 14, 'e08025803945a90b3bb872fa3336fbc744e1e0ebc8a1345a48103d9a6cab413e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-30 12:01:37', '2026-03-29 10:01:37'),
(226, 12, '7c719a460ca28f8f2d1e1f82afeeed0deaac964534483345df82da586247b1de', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-30 12:07:32', '2026-03-29 10:07:32'),
(227, 9, '4a07995074b7da1ced4d9ffea3491c66f960973eb68641b676df217e3ec02385', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-30 12:12:37', '2026-03-29 10:12:37'),
(228, 1, '9d1e63d3aab667a4cf5a6ba66cf18fc65c1b98f55a7d4af4d69cdeb15c264752', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 14:55:08', '2026-03-30 12:55:08'),
(229, 14, '9807b8b1f6855f632966af685c7a42969bc30bd5bb79cbd3a8de726b2210fa23', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 15:00:54', '2026-03-30 13:00:54'),
(230, 14, '95669a8e2ff6b5bf0245fc02510480c15f8e0c92e473a99a25a4b505f427e7d3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 15:13:55', '2026-03-30 13:13:55'),
(231, 9, 'bca9d1716efceb58b5c714c80ba5e9c7971819b5c8f757721937776bdfa3793e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 15:25:28', '2026-03-30 13:25:28'),
(232, 14, 'ae09001a11d08d09688266c976552b2f4870c2adde2e7e41d9dd9d9e31fd5a91', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 15:27:29', '2026-03-30 13:27:29'),
(233, 12, 'b0c6bc4e7e53493171a860f80c4d82ea698f03154c485458aa976d87c056b263', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 10:51:11', '2026-04-02 08:51:11'),
(234, 16, '6e88e2cd3888e5ddef98a3709e31755015fd61d63cb55ea207fa2fe36967860c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 10:53:39', '2026-04-02 08:53:39'),
(235, 14, '4717365a75739477e27bfc6d3478788f94346dda1d062ef27a7c2b8c4ad738ce', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 08:00:38', '2026-04-05 06:00:38'),
(236, 14, '4ed63568bd6b5726ba22a4a4a7f32dda590b1db2ba92fe80313c59b81fcd5719', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 15:00:26', '2026-04-11 13:00:26'),
(237, 12, 'f0bf41e7f352f9195cd8b26dae25fd7b3403388872b2af5a9651fec9e2661f5b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 15:00:55', '2026-04-11 13:00:55'),
(238, 1, 'd72f20ee2c4a097b409d63fd07deefbf3cf32f1f48e5029c52bf362667612b8a', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 15:01:26', '2026-04-11 13:01:26'),
(239, 9, '6afcae773f409a417c9cfbbabc3cb900eb2df0c08810722bf94f44721af8aaa3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 06:41:11', '2026-04-18 04:41:11'),
(240, 1, '75ee64f5c7f1457d65463d8b3a90c6d8166687c0061131e45402303f2e320cee', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 06:41:58', '2026-04-18 04:41:58'),
(241, 14, '624a2041dfdcaca48d71100a661c6d28aa695ec6ac839512d7a82658d916e9ce', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 06:42:25', '2026-04-18 04:42:25'),
(242, 9, 'c889cf0f8775b5617490cc59bb1532657bae4f1c6acd0a2b1a372a1b4c1d2f24', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 06:44:36', '2026-04-18 04:44:36'),
(243, 14, '58018b44cdc1cbdff4d223d60bcb1113deae8c7096c46d9a3c98ce3ed055ec4b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 06:45:56', '2026-04-18 04:45:56'),
(244, 9, 'a1dbfebd3955d0f493583759c473aba36b1585f33298aef51079c36950086d30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 06:47:36', '2026-04-18 04:47:36'),
(245, 14, '7806d91417f6b49a65f00b6b6451aa0bfe05a68729c2351406d00cd46583b59f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 06:50:39', '2026-04-18 04:50:39'),
(246, 1, 'e858c6732b5b5bf021a7587def6cf88e381f34cc5a52f5b718cb07c375f9242c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 07:14:48', '2026-04-18 05:14:48'),
(247, 1, 'bc3059aa5050788e565acc08bdf4b85044ce9d297fbf9ca271fbeaeee03f9d9c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 07:27:24', '2026-04-18 05:27:24'),
(248, 14, '427fdd4d23c89d1aeeb323425f3237750b062e6c891d35f0e5e23f19bf2a57bc', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 07:28:06', '2026-04-18 05:28:06'),
(249, 12, '690c73a97a6102d5cb0b64ee2e5db11990abd9d88f58adc305cfa4851744d849', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 07:53:05', '2026-04-18 05:53:05'),
(250, 12, 'c92b13854e4727067b6bb74f1c3395fd5a3d5d4278c333c47b53410403384774', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 07:54:57', '2026-04-18 05:54:57'),
(251, 1, '07609b6b2ccaf5ae2018c29f07cb76632fc8bbe020b755ed29e818528df0cec5', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 08:08:35', '2026-04-18 06:08:35'),
(252, 14, '849157b07768a2907db34dcd4d972534d102fcc8955f4d9c5d8aaa25556ceb8b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 08:13:29', '2026-04-18 06:13:29'),
(253, 1, '79e95e40a28dd6eb9bd6e08585fc3d07e5a47e85179eccf85228362aeba39641', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 08:30:04', '2026-04-18 06:30:04'),
(254, 12, 'e24d1ed3e21958114a38278bf173096401167921a563d16a03e5963957f4058d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 08:35:24', '2026-04-18 06:35:24'),
(255, 9, '96660074dee8847821e36de87b7aea118da733b035ded576e71068c05cd6b319', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 08:43:01', '2026-04-18 06:43:01'),
(256, 14, '7461b821c9d66339c308bfd5b9fc12c81899d6c47056b68bb8de7544f485dab1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 08:48:11', '2026-04-18 06:48:11'),
(257, 9, '418f6b3e2524764cc138774c199a1f3efb12ec732e0cd863dfbe9ab83e20403b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 08:49:50', '2026-04-18 06:49:50'),
(258, 14, '4f5f02d5cbbfb9ee24a48e9b68d891b1776fc9c97ccf24a453a551a163b773a1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 09:04:20', '2026-04-18 07:04:20'),
(259, 9, 'b52c64e931f9fc97049d6434d72b39d66d196cd1acb9b9786f2e22a357881514', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 09:05:25', '2026-04-18 07:05:25'),
(260, 14, 'b75732c9f5390e359bd14790260b85fc02ad50b7c766ad4f6bc761c0d20a7cf9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 09:06:10', '2026-04-18 07:06:10'),
(261, 9, '6ba57dd320aed1f1dd08f70a542ae5af68527aeec619bbe63ce7ac2d5c7f766c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 09:07:48', '2026-04-18 07:07:48'),
(262, 14, '5dc2db7c38b03cfd059a6f9ed9a020a81fbb2cb9532b1414ca4f70e413709eb8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 09:09:11', '2026-04-18 07:09:11'),
(263, 14, 'a414e506afaf5d191ff807b8c55cfe5e20380cb3114618c89257986b2e4520c0', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 09:12:37', '2026-04-18 07:12:37'),
(264, 1, 'ed9347a3d840733ad1ab13ac4ca2e2c7a3d5afa914f51a4dc7e3b495a45c9bcf', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 05:39:22', '2026-04-19 03:39:22'),
(265, 14, '1abfa57af4dd26a8c3fdaf2a49548d01cc8a15a0022db664bd2158fb19b7911b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 05:42:23', '2026-04-19 03:42:23'),
(266, 12, 'fb2ab9648f9d1f4df92baee2dd2037ea542f898c2fc512ea23e3134868e4bcba', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 05:49:54', '2026-04-19 03:49:54'),
(267, 9, '5ce2997070cee957342bb7f4285856c3297e052957c741cf6f08a53a698f250b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 05:57:11', '2026-04-19 03:57:11'),
(268, 12, '4c4fd208888bf43f7b549db3aa4f0d7e361ec62aaa51aeda12db8a1a2d5b3b5a', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 07:17:45', '2026-04-19 05:17:45'),
(269, 1, '3ed6d4003e12378c78d7bb8a06b7c0ddd05cd96126f94c81da6d61374b1eab6d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 07:30:23', '2026-04-19 05:30:23'),
(270, 14, 'ceae6dc8f7ef6ef4f3f84f3d18982fe0c9801d9c5508ec0bebf8460e92c5cb54', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 07:36:59', '2026-04-19 05:36:59'),
(271, 1, '06a9f668eac1dbf57156eaf17199784a4e9cec5d97a6edf9af9767b54e8c4952', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 07:53:16', '2026-04-19 05:53:16'),
(272, 14, '5f4c150cab237c9f162d791b9a05f88f75643ff54074988fa1f877570dd15128', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 07:56:46', '2026-04-19 05:56:46'),
(273, 12, '28709c7add68b9997696232743e78faea5531c32b8681f68f4075ddabc78cf37', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 07:57:46', '2026-04-19 05:57:46'),
(274, 1, 'd3b404d416e057cd508b13cbfc272d645d4d2e1c422a2338bb8f9cb170de2772', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 08:51:35', '2026-04-19 06:51:35'),
(275, 17, 'fe6fa106574bc81e08c6f4825632d4e2fb01177f2ccc3d65f7f043476bee029c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 08:54:31', '2026-04-19 06:54:31'),
(276, 9, 'c272324f97d331251cf21e17358fa2798e59124b0166ceaaba75bfbc9cd863a9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:02:09', '2026-04-19 07:02:09'),
(277, 6, '2b93155315c353c5d7f84456fea60fabca094374993e742990837626d3ebf1a4', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:13:11', '2026-04-19 07:13:11'),
(278, 15, '2312f28f23c3f3f83b9dcdc999c58d45a00557c9370911b452dd564bff2bf28d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:23:31', '2026-04-19 07:23:31'),
(279, 16, 'cbac83cb2a48294fd13441d21f9b07a9ac92dfe745b981893047e48dc52c5286', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:27:49', '2026-04-19 07:27:49'),
(280, 1, '5de94929d37ce67a5b71fbafafc3ae4e338703574d7d902a8940ee0ede183759', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:37:05', '2026-04-19 07:37:05'),
(281, 14, '948a20c35749489691675b64ccc27b3ab2b18eb366aaf4accfaface0fc2767dd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:38:43', '2026-04-19 07:38:43'),
(282, 12, '446c220b45c70193051dfbd6cd1ae4bc475fc139ba057bf29fbba0c4b0e68b82', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:41:02', '2026-04-19 07:41:02'),
(283, 1, 'd3427f7e80f9255ba97193eccdec656421fbeba335b90575f4a81fdf5504e725', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:57:16', '2026-04-19 07:57:16'),
(284, 14, '95fc92dc54c55b0a98b5e8e4d41bb02697eb874079ab359b397d7ab8577cbe18', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:58:38', '2026-04-19 07:58:38'),
(285, 12, 'a092aba92b4b0c392cd2ba9d2b604957c2ed1bd905127796863ec9a0dd83df70', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 09:59:55', '2026-04-19 07:59:55'),
(286, 17, '43b65ca9c28aeb18102f677c5f97071cc15a29c0a4dce68d5a487d2299df0b46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 10:02:29', '2026-04-19 08:02:29'),
(287, 12, '55f5c428a1efe9d7102b70d2c402b7a54450a1ef50a6a2fb58458c7e0c038ef1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 10:11:43', '2026-04-19 08:11:43'),
(288, 1, '5cd2e0f9f6c3af98a6bcbe226083838f3bc1d3d53ab37ad06a0875effe53c41c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 10:14:05', '2026-04-19 08:14:05'),
(289, 17, '8afde97a95136d6694155a3d550091ac6c831399baf867207399a42e42c4a499', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 10:15:04', '2026-04-19 08:15:04'),
(290, 1, '21402275fcd68d37eb4ccad7697edfaa2ca0b43eb82131094f46ea2421b13d86', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 10:18:04', '2026-04-19 08:18:04'),
(291, 1, 'ec513d4f620564b367b1b606232d9188d3373f3c97279e5fe9cad26fbab938e9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 10:22:00', '2026-04-19 08:22:00'),
(292, 14, '59eb69bef4ebd9121024f0324362d8820e00c787bea391190f908b3d7ed9c702', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 10:25:06', '2026-04-19 08:25:06'),
(293, 17, '84e16740fa49544c14674b761c116eca855c5d01d9a6c204015d8f6130372a40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 10:31:56', '2026-04-19 08:31:56'),
(294, 12, 'c160d737ce1bfcf495fd42a4da4c7985bdc08ba4e68d0dd5ac1f405ddf401a8e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 10:36:42', '2026-04-19 08:36:42'),
(295, 17, '4cfa3b367059c05bced2cbcaee9ace13b8e6388dba9ad00b50d3e122887cd54a', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 15:33:22', '2026-04-19 13:33:22'),
(296, 12, '751df1f9644978cd715f35b7b087f0b70ea4253ea44ab0d0ea455cf08c91a0e9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 15:43:26', '2026-04-19 13:43:26'),
(297, 17, 'b2bfa7022dd6a5be3b5bcb80fc48d16aa79e56b03c0dae5cf9d71595e9f206d4', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 15:44:29', '2026-04-19 13:44:29'),
(298, 1, 'd1460c4e8ac7fdc6ac72bbd6f52cdfe68489c951f4156ef232c47ae774f4070c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 16:37:36', '2026-04-19 14:37:36'),
(299, 1, 'ac9fc1d857960912b503232bd4a1032b91f8d4e4deee9d50f9c2865bbf39ed79', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 16:43:55', '2026-04-19 14:43:55'),
(300, 14, '7864f948750833f121d400f027c45d384b0ae7ad5e7bf6a8b4e81c1869dbbfb9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 16:46:22', '2026-04-19 14:46:22'),
(301, 17, 'efb2419c8d930b25c1c7884c94aa342fa518adc7ef47b6f97c2321f4fdd98b7d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 16:49:30', '2026-04-19 14:49:30'),
(302, 17, '7b21194bee821b3e86bebd5ee6eadd5ba0fdfaaca8d556efa65c0771f2599fb0', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 16:59:09', '2026-04-19 14:59:09'),
(303, 12, '265858d8f8499471e0fbe7a006eb72a94388716eed8061707ea53ef283c953d9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 17:03:54', '2026-04-19 15:03:54'),
(304, 1, '159aab87374da909deecfcb4268da5f5e1ee214a4fdc02c1e6051a2939bab9cc', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 10:52:18', '2026-04-20 08:52:18'),
(305, 17, 'f71eb7367cb4f5c3a00f05b57b7d5be1aa21f281794edfda0a40b89e7c3745e6', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 10:53:17', '2026-04-20 08:53:17'),
(306, 14, 'b42729443ab7fd33e0f0bc6c21bbeec9e54ff8d7b00b848d975d9bebda78d2c8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 10:54:04', '2026-04-20 08:54:04'),
(307, 12, 'a355b623dec7079d3cfacb2669bc709a7b6640b3d3de59649bfa7362b9634838', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 10:54:38', '2026-04-20 08:54:38'),
(308, 18, 'a4b10d936184f53935990d8aabbc5c803166d84f51a4bbedc67c284536904bd8', 'unknown', 'unknown', '2026-04-21 15:29:15', '2026-04-20 13:29:15'),
(309, 18, '57a44572f7897a88bd915853ea50ab6b989976a538f6e8b168a76d3c3900dbee', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:30:29', '2026-04-20 13:30:29'),
(310, 19, '7c2a35d104263addfcf2b1ca0bfff65ca9aae4ec133734d30fbeaa87faf3dfc9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:37:06', '2026-04-20 13:37:06'),
(311, 20, '8959a3e1ab033717da3fca73531c8d18020ad19ae3910d10fd77d72d6a69b018', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:37:22', '2026-04-20 13:37:22'),
(312, 21, 'ca89d949a8abdd0c73614ab523665087df847fee20ecc6c5214ba1cf1b5cdc45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:39:55', '2026-04-20 13:39:55'),
(313, 22, 'fc4ea14b49e66e696f7d5d3076baa4a83ccf1d32fbb72f284463545caab7c8cf', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:47:35', '2026-04-20 13:47:35');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_department_submission_summary`
-- (See below for the actual view)
--
CREATE TABLE `v_department_submission_summary` (
`session_id` int(11)
,`department` varchar(100)
,`total_staff` bigint(21)
,`staff_submitted` decimal(22,0)
,`staff_not_submitted` decimal(22,0)
,`total_ideas` bigint(21)
,`submission_rate` decimal(28,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_latest_comments`
-- (See below for the actual view)
--
CREATE TABLE `v_latest_comments` (
`id` int(11)
,`content` longtext
,`created_at` timestamp
,`contributor_name` varchar(100)
,`is_anonymous` tinyint(1)
,`idea_id` int(11)
,`idea_title` varchar(255)
,`session_name` varchar(100)
,`session_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_latest_ideas`
-- (See below for the actual view)
--
CREATE TABLE `v_latest_ideas` (
`id` int(11)
,`title` varchar(255)
,`description` longtext
,`department` varchar(100)
,`view_count` int(11)
,`net_votes` bigint(12)
,`upvote_count` int(11)
,`downvote_count` int(11)
,`comment_count` int(11)
,`submitted_at` timestamp
,`contributor_name` varchar(100)
,`is_anonymous` tinyint(1)
,`category_name` varchar(100)
,`session_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_least_popular_ideas`
-- (See below for the actual view)
--
CREATE TABLE `v_least_popular_ideas` (
`id` int(11)
,`title` varchar(255)
,`description` longtext
,`department` varchar(100)
,`net_votes` bigint(12)
,`upvote_count` int(11)
,`downvote_count` int(11)
,`view_count` int(11)
,`comment_count` int(11)
,`submitted_at` timestamp
,`contributor_name` varchar(100)
,`is_anonymous` tinyint(1)
,`category_name` varchar(100)
,`session_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_most_popular_ideas`
-- (See below for the actual view)
--
CREATE TABLE `v_most_popular_ideas` (
`id` int(11)
,`title` varchar(255)
,`description` longtext
,`department` varchar(100)
,`net_votes` bigint(12)
,`upvote_count` int(11)
,`downvote_count` int(11)
,`view_count` int(11)
,`comment_count` int(11)
,`submitted_at` timestamp
,`contributor_name` varchar(100)
,`is_anonymous` tinyint(1)
,`category_name` varchar(100)
,`session_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_most_viewed_ideas`
-- (See below for the actual view)
--
CREATE TABLE `v_most_viewed_ideas` (
`id` int(11)
,`title` varchar(255)
,`description` longtext
,`department` varchar(100)
,`view_count` int(11)
,`net_votes` bigint(12)
,`upvote_count` int(11)
,`downvote_count` int(11)
,`comment_count` int(11)
,`submitted_at` timestamp
,`contributor_name` varchar(100)
,`is_anonymous` tinyint(1)
,`category_name` varchar(100)
,`session_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_staff_not_submitted`
-- (See below for the actual view)
--
CREATE TABLE `v_staff_not_submitted` (
`session_id` int(11)
,`department` varchar(100)
,`staff_id` int(11)
,`staff_name` varchar(100)
,`email` varchar(100)
,`staff_department` varchar(100)
,`session_name` varchar(100)
,`closes_at` datetime
,`days_until_closure` int(7)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_unanswered_comments`
-- (See below for the actual view)
--
CREATE TABLE `v_unanswered_comments` (
`comment_id` int(11)
,`idea_id` int(11)
,`comment_author_name` varchar(100)
,`comment_author_email` varchar(100)
,`idea_title` varchar(255)
,`session_name` varchar(100)
,`content` longtext
,`created_at` timestamp
,`days_without_response` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `v_department_submission_summary`
--
DROP TABLE IF EXISTS `v_department_submission_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_department_submission_summary`  AS SELECT `sst`.`session_id` AS `session_id`, `sst`.`department` AS `department`, count(distinct `sst`.`staff_id`) AS `total_staff`, sum(case when `sst`.`has_submitted` = 1 then 1 else 0 end) AS `staff_submitted`, sum(case when `sst`.`has_submitted` = 0 then 1 else 0 end) AS `staff_not_submitted`, count(distinct `i`.`id`) AS `total_ideas`, round(sum(case when `sst`.`has_submitted` = 1 then 1 else 0 end) / count(distinct `sst`.`staff_id`) * 100,2) AS `submission_rate` FROM ((((`staff_submission_tracking` `sst` left join `staff` `st` on(`st`.`id` = `sst`.`staff_id`)) left join `contributors` `c` on(`c`.`email` = `st`.`email`)) left join `ideas` `i` on(`i`.`session_id` = `sst`.`session_id` and `i`.`contributor_id` = `c`.`id`)) join `sessions` `s` on(`sst`.`session_id` = `s`.`id`)) GROUP BY `sst`.`session_id`, `sst`.`department` ;

-- --------------------------------------------------------

--
-- Structure for view `v_latest_comments`
--
DROP TABLE IF EXISTS `v_latest_comments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_latest_comments`  AS SELECT `c`.`id` AS `id`, `c`.`content` AS `content`, `c`.`created_at` AS `created_at`, `con`.`name` AS `contributor_name`, `con`.`is_anonymous` AS `is_anonymous`, `i`.`id` AS `idea_id`, `i`.`title` AS `idea_title`, `s`.`session_name` AS `session_name`, `s`.`id` AS `session_id` FROM (((`comments` `c` join `ideas` `i` on(`c`.`idea_id` = `i`.`id`)) join `sessions` `s` on(`i`.`session_id` = `s`.`id`)) join `contributors` `con` on(`c`.`contributor_id` = `con`.`id`)) WHERE `c`.`is_deleted` = 0 AND `i`.`status` = 'Submitted' ORDER BY `c`.`created_at` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_latest_ideas`
--
DROP TABLE IF EXISTS `v_latest_ideas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_latest_ideas`  AS SELECT `i`.`id` AS `id`, `i`.`title` AS `title`, `i`.`description` AS `description`, `i`.`department` AS `department`, `i`.`view_count` AS `view_count`, coalesce(`i`.`upvote_count`,0) - coalesce(`i`.`downvote_count`,0) AS `net_votes`, `i`.`upvote_count` AS `upvote_count`, `i`.`downvote_count` AS `downvote_count`, `i`.`comment_count` AS `comment_count`, `i`.`submitted_at` AS `submitted_at`, `c`.`name` AS `contributor_name`, `c`.`is_anonymous` AS `is_anonymous`, `cat`.`name` AS `category_name`, `s`.`session_name` AS `session_name` FROM (((`ideas` `i` join `sessions` `s` on(`i`.`session_id` = `s`.`id`)) join `contributors` `c` on(`i`.`contributor_id` = `c`.`id`)) join `idea_categories` `cat` on(`s`.`category_id` = `cat`.`id`)) WHERE `i`.`status` = 'Submitted' AND `i`.`approval_status` = 'Approved' ORDER BY `i`.`submitted_at` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_least_popular_ideas`
--
DROP TABLE IF EXISTS `v_least_popular_ideas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_least_popular_ideas`  AS SELECT `i`.`id` AS `id`, `i`.`title` AS `title`, `i`.`description` AS `description`, `i`.`department` AS `department`, coalesce(`i`.`upvote_count`,0) - coalesce(`i`.`downvote_count`,0) AS `net_votes`, `i`.`upvote_count` AS `upvote_count`, `i`.`downvote_count` AS `downvote_count`, `i`.`view_count` AS `view_count`, `i`.`comment_count` AS `comment_count`, `i`.`submitted_at` AS `submitted_at`, `c`.`name` AS `contributor_name`, `c`.`is_anonymous` AS `is_anonymous`, `cat`.`name` AS `category_name`, `s`.`session_name` AS `session_name` FROM (((`ideas` `i` join `sessions` `s` on(`i`.`session_id` = `s`.`id`)) join `contributors` `c` on(`i`.`contributor_id` = `c`.`id`)) join `idea_categories` `cat` on(`s`.`category_id` = `cat`.`id`)) WHERE `i`.`status` = 'Submitted' AND `i`.`approval_status` = 'Approved' ORDER BY coalesce(`i`.`upvote_count`,0) - coalesce(`i`.`downvote_count`,0) ASC, `i`.`submitted_at` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_most_popular_ideas`
--
DROP TABLE IF EXISTS `v_most_popular_ideas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_most_popular_ideas`  AS SELECT `i`.`id` AS `id`, `i`.`title` AS `title`, `i`.`description` AS `description`, `i`.`department` AS `department`, coalesce(`i`.`upvote_count`,0) - coalesce(`i`.`downvote_count`,0) AS `net_votes`, `i`.`upvote_count` AS `upvote_count`, `i`.`downvote_count` AS `downvote_count`, `i`.`view_count` AS `view_count`, `i`.`comment_count` AS `comment_count`, `i`.`submitted_at` AS `submitted_at`, `c`.`name` AS `contributor_name`, `c`.`is_anonymous` AS `is_anonymous`, `cat`.`name` AS `category_name`, `s`.`session_name` AS `session_name` FROM (((`ideas` `i` join `sessions` `s` on(`i`.`session_id` = `s`.`id`)) join `contributors` `c` on(`i`.`contributor_id` = `c`.`id`)) join `idea_categories` `cat` on(`s`.`category_id` = `cat`.`id`)) WHERE `i`.`status` = 'Submitted' AND `i`.`approval_status` = 'Approved' ORDER BY coalesce(`i`.`upvote_count`,0) - coalesce(`i`.`downvote_count`,0) DESC, `i`.`submitted_at` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_most_viewed_ideas`
--
DROP TABLE IF EXISTS `v_most_viewed_ideas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_most_viewed_ideas`  AS SELECT `i`.`id` AS `id`, `i`.`title` AS `title`, `i`.`description` AS `description`, `i`.`department` AS `department`, `i`.`view_count` AS `view_count`, coalesce(`i`.`upvote_count`,0) - coalesce(`i`.`downvote_count`,0) AS `net_votes`, `i`.`upvote_count` AS `upvote_count`, `i`.`downvote_count` AS `downvote_count`, `i`.`comment_count` AS `comment_count`, `i`.`submitted_at` AS `submitted_at`, `c`.`name` AS `contributor_name`, `c`.`is_anonymous` AS `is_anonymous`, `cat`.`name` AS `category_name`, `s`.`session_name` AS `session_name` FROM (((`ideas` `i` join `sessions` `s` on(`i`.`session_id` = `s`.`id`)) join `contributors` `c` on(`i`.`contributor_id` = `c`.`id`)) join `idea_categories` `cat` on(`s`.`category_id` = `cat`.`id`)) WHERE `i`.`status` = 'Submitted' AND `i`.`approval_status` = 'Approved' ORDER BY `i`.`view_count` DESC, `i`.`submitted_at` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_staff_not_submitted`
--
DROP TABLE IF EXISTS `v_staff_not_submitted`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_staff_not_submitted`  AS SELECT `sst`.`session_id` AS `session_id`, `sst`.`department` AS `department`, `s`.`id` AS `staff_id`, `s`.`name` AS `staff_name`, `s`.`email` AS `email`, `s`.`department` AS `staff_department`, `ses`.`session_name` AS `session_name`, `ses`.`closes_at` AS `closes_at`, to_days(`ses`.`closes_at`) - to_days(current_timestamp()) AS `days_until_closure` FROM ((`staff_submission_tracking` `sst` join `staff` `s` on(`sst`.`staff_id` = `s`.`id`)) join `sessions` `ses` on(`sst`.`session_id` = `ses`.`id`)) WHERE `sst`.`has_submitted` = 0 AND `ses`.`status` = 'Active' AND `s`.`is_active` = 1 ORDER BY `ses`.`closes_at` ASC, `s`.`department` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `v_unanswered_comments`
--
DROP TABLE IF EXISTS `v_unanswered_comments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_unanswered_comments`  AS SELECT `crt`.`comment_id` AS `comment_id`, `crt`.`idea_id` AS `idea_id`, `crt`.`comment_author_name` AS `comment_author_name`, `crt`.`comment_author_email` AS `comment_author_email`, `i`.`title` AS `idea_title`, `s`.`session_name` AS `session_name`, `c`.`content` AS `content`, `c`.`created_at` AS `created_at`, timestampdiff(DAY,`c`.`created_at`,current_timestamp()) AS `days_without_response` FROM (((`comment_response_tracking` `crt` join `comments` `c` on(`crt`.`comment_id` = `c`.`id`)) join `ideas` `i` on(`crt`.`idea_id` = `i`.`id`)) join `sessions` `s` on(`i`.`session_id` = `s`.`id`)) WHERE `crt`.`has_responses` = 0 AND `c`.`is_deleted` = 0 ORDER BY `c`.`created_at` ASC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_years`
--
ALTER TABLE `academic_years`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `year_label` (`year_label`),
  ADD KEY `idx_year_label` (`year_label`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_is_active` (`is_active`),
  ADD KEY `idx_department` (`department`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `category_backups`
--
ALTER TABLE `category_backups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_category_backups_admin` (`created_by_admin_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flagged_by_admin_id` (`flagged_by_admin_id`),
  ADD KEY `deleted_by` (`deleted_by`),
  ADD KEY `idx_idea` (`idea_id`),
  ADD KEY `idx_contributor` (`contributor_id`),
  ADD KEY `idx_is_inappropriate` (`is_inappropriate`),
  ADD KEY `idx_is_deleted` (`is_deleted`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `comment_replies`
--
ALTER TABLE `comment_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mentioned_staff_id` (`mentioned_staff_id`),
  ADD KEY `idx_parent_comment` (`parent_comment_id`),
  ADD KEY `idx_idea` (`idea_id`),
  ADD KEY `idx_contributor` (`contributor_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `comment_response_tracking`
--
ALTER TABLE `comment_response_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comment_author_id` (`comment_author_id`),
  ADD KEY `idx_idea` (`idea_id`),
  ADD KEY `idx_comment` (`comment_id`),
  ADD KEY `idx_has_responses` (`has_responses`);

--
-- Indexes for table `contributors`
--
ALTER TABLE `contributors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_uuid` (`user_uuid`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `disabled_by_admin_id` (`disabled_by_admin_id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_department` (`department`),
  ADD KEY `idx_account_status` (`account_status`),
  ADD KEY `idx_is_anonymous` (`is_anonymous`);

--
-- Indexes for table `contributor_account_history`
--
ALTER TABLE `contributor_account_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_contributor` (`contributor_id`),
  ADD KEY `idx_admin` (`admin_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `coordinator_content_reports`
--
ALTER TABLE `coordinator_content_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_coordinator` (`coordinator_id`),
  ADD KEY `idx_content_type` (`content_type`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_reported_at` (`reported_at`);

--
-- Indexes for table `coordinator_reminders`
--
ALTER TABLE `coordinator_reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_coordinator` (`coordinator_id`),
  ADD KEY `idx_session` (`session_id`),
  ADD KEY `idx_sent_at` (`sent_at`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `idx_department_active` (`is_active`),
  ADD KEY `idx_department_coordinator` (`qa_coordinator_id`);

--
-- Indexes for table `department_performance_stats`
--
ALTER TABLE `department_performance_stats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_session_dept` (`session_id`,`department`),
  ADD KEY `idx_session` (`session_id`),
  ADD KEY `idx_department` (`department`);

--
-- Indexes for table `email_notifications`
--
ALTER TABLE `email_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idea_id` (`idea_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `idx_recipient_email` (`recipient_email`),
  ADD KEY `idx_notification_type` (`notification_type`),
  ADD KEY `idx_sent_at` (`sent_at`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `ideas`
--
ALTER TABLE `ideas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flagged_by_admin_id` (`flagged_by_admin_id`),
  ADD KEY `idx_session` (`session_id`),
  ADD KEY `idx_contributor` (`contributor_id`),
  ADD KEY `idx_department` (`department`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_approval_status` (`approval_status`),
  ADD KEY `idx_is_inappropriate` (`is_inappropriate`),
  ADD KEY `idx_submitted_at` (`submitted_at`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_view_count` (`view_count`),
  ADD KEY `idx_upvote_count` (`upvote_count`);

--
-- Indexes for table `idea_attachments`
--
ALTER TABLE `idea_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uploaded_by_contributor_id` (`uploaded_by_contributor_id`),
  ADD KEY `idx_idea` (`idea_id`),
  ADD KEY `idx_is_flagged` (`is_flagged`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `idea_categories`
--
ALTER TABLE `idea_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `idea_category_tags`
--
ALTER TABLE `idea_category_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_idea_category` (`idea_id`,`category_id`),
  ADD KEY `idx_idea` (`idea_id`),
  ADD KEY `idx_category` (`category_id`);

--
-- Indexes for table `idea_views`
--
ALTER TABLE `idea_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `viewer_id` (`viewer_id`),
  ADD KEY `idx_idea` (`idea_id`),
  ADD KEY `idx_viewed_at` (`viewed_at`);

--
-- Indexes for table `idea_votes`
--
ALTER TABLE `idea_votes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_contributor_idea` (`idea_id`,`contributor_id`),
  ADD KEY `idx_idea` (`idea_id`),
  ADD KEY `idx_contributor` (`contributor_id`),
  ADD KEY `idx_voted_at` (`voted_at`);

--
-- Indexes for table `inappropriate_content_log`
--
ALTER TABLE `inappropriate_content_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_content_type` (`content_type`),
  ADD KEY `idx_admin` (`admin_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `notification_settings`
--
ALTER TABLE `notification_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `notification_key` (`notification_key`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `template_key` (`template_key`);

--
-- Indexes for table `qa_content_action_audit`
--
ALTER TABLE `qa_content_action_audit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_action_content` (`content_type`,`content_id`,`is_undone`);

--
-- Indexes for table `qa_coordinator_departments`
--
ALTER TABLE `qa_coordinator_departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_coordinator_dept` (`coordinator_id`,`department`),
  ADD KEY `idx_department` (`department`),
  ADD KEY `idx_coordinator` (`coordinator_id`);

--
-- Indexes for table `qa_hidden_content_records`
--
ALTER TABLE `qa_hidden_content_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_hidden_contributor` (`contributor_id`,`is_restored`),
  ADD KEY `idx_hidden_content` (`content_type`,`content_id`);

--
-- Indexes for table `qa_managers`
--
ALTER TABLE `qa_managers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_user_id` (`admin_user_id`),
  ADD KEY `idx_admin_user_id` (`admin_user_id`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_key`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_academic_year` (`academic_year_id`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_opens_at` (`opens_at`),
  ADD KEY `idx_closes_at` (`closes_at`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `staff_idea_reports`
--
ALTER TABLE `staff_idea_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reporter_id` (`reporter_id`),
  ADD KEY `idx_content_type` (`content_type`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_reported_at` (`reported_at`);

--
-- Indexes for table `staff_invitations`
--
ALTER TABLE `staff_invitations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_coordinator` (`coordinator_id`),
  ADD KEY `idx_staff` (`staff_id`),
  ADD KEY `idx_session` (`session_id`),
  ADD KEY `idx_sent_at` (`sent_at`),
  ADD KEY `idx_staff_invitations_idea` (`idea_id`);

--
-- Indexes for table `staff_submission_tracking`
--
ALTER TABLE `staff_submission_tracking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_staff_session` (`session_id`,`staff_id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `idx_session` (`session_id`),
  ADD KEY `idx_department` (`department`),
  ADD KEY `idx_has_submitted` (`has_submitted`);

--
-- Indexes for table `staff_tc_acceptance`
--
ALTER TABLE `staff_tc_acceptance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_staff_version` (`staff_id`,`tc_version`),
  ADD KEY `idx_staff` (`staff_id`),
  ADD KEY `idx_accepted_at` (`accepted_at`);

--
-- Indexes for table `system_backups`
--
ALTER TABLE `system_backups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_system_backups_admin` (`created_by_admin_id`);

--
-- Indexes for table `system_notifications`
--
ALTER TABLE `system_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idea_id` (`idea_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `idx_recipient` (`recipient_id`),
  ADD KEY `idx_notification_type` (`notification_type`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `terms_and_conditions`
--
ALTER TABLE `terms_and_conditions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_version` (`version`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `idx_session_token` (`session_token`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_years`
--
ALTER TABLE `academic_years`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `category_backups`
--
ALTER TABLE `category_backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `comment_replies`
--
ALTER TABLE `comment_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `comment_response_tracking`
--
ALTER TABLE `comment_response_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `contributors`
--
ALTER TABLE `contributors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `contributor_account_history`
--
ALTER TABLE `contributor_account_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `coordinator_content_reports`
--
ALTER TABLE `coordinator_content_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `coordinator_reminders`
--
ALTER TABLE `coordinator_reminders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20908;

--
-- AUTO_INCREMENT for table `department_performance_stats`
--
ALTER TABLE `department_performance_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `email_notifications`
--
ALTER TABLE `email_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `ideas`
--
ALTER TABLE `ideas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `idea_attachments`
--
ALTER TABLE `idea_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `idea_categories`
--
ALTER TABLE `idea_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `idea_category_tags`
--
ALTER TABLE `idea_category_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `idea_views`
--
ALTER TABLE `idea_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=348;

--
-- AUTO_INCREMENT for table `idea_votes`
--
ALTER TABLE `idea_votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `inappropriate_content_log`
--
ALTER TABLE `inappropriate_content_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `notification_settings`
--
ALTER TABLE `notification_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6423;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3853;

--
-- AUTO_INCREMENT for table `qa_content_action_audit`
--
ALTER TABLE `qa_content_action_audit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `qa_coordinator_departments`
--
ALTER TABLE `qa_coordinator_departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `qa_hidden_content_records`
--
ALTER TABLE `qa_hidden_content_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `qa_managers`
--
ALTER TABLE `qa_managers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `staff_idea_reports`
--
ALTER TABLE `staff_idea_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `staff_invitations`
--
ALTER TABLE `staff_invitations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `staff_submission_tracking`
--
ALTER TABLE `staff_submission_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `staff_tc_acceptance`
--
ALTER TABLE `staff_tc_acceptance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `system_backups`
--
ALTER TABLE `system_backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `system_notifications`
--
ALTER TABLE `system_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10273;

--
-- AUTO_INCREMENT for table `terms_and_conditions`
--
ALTER TABLE `terms_and_conditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=314;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category_backups`
--
ALTER TABLE `category_backups`
  ADD CONSTRAINT `fk_category_backups_admin` FOREIGN KEY (`created_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`flagged_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `comments_ibfk_4` FOREIGN KEY (`deleted_by`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `comment_replies`
--
ALTER TABLE `comment_replies`
  ADD CONSTRAINT `comment_replies_ibfk_1` FOREIGN KEY (`parent_comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_replies_ibfk_2` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_replies_ibfk_3` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_replies_ibfk_4` FOREIGN KEY (`mentioned_staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `comment_response_tracking`
--
ALTER TABLE `comment_response_tracking`
  ADD CONSTRAINT `comment_response_tracking_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_response_tracking_ibfk_2` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_response_tracking_ibfk_3` FOREIGN KEY (`comment_author_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contributors`
--
ALTER TABLE `contributors`
  ADD CONSTRAINT `contributors_ibfk_1` FOREIGN KEY (`disabled_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `contributor_account_history`
--
ALTER TABLE `contributor_account_history`
  ADD CONSTRAINT `contributor_account_history_ibfk_1` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contributor_account_history_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coordinator_content_reports`
--
ALTER TABLE `coordinator_content_reports`
  ADD CONSTRAINT `coordinator_content_reports_ibfk_1` FOREIGN KEY (`coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coordinator_reminders`
--
ALTER TABLE `coordinator_reminders`
  ADD CONSTRAINT `coordinator_reminders_ibfk_1` FOREIGN KEY (`coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coordinator_reminders_ibfk_2` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `fk_departments_coordinator` FOREIGN KEY (`qa_coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `department_performance_stats`
--
ALTER TABLE `department_performance_stats`
  ADD CONSTRAINT `department_performance_stats_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `email_notifications`
--
ALTER TABLE `email_notifications`
  ADD CONSTRAINT `email_notifications_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `email_notifications_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `email_notifications_ibfk_3` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ideas`
--
ALTER TABLE `ideas`
  ADD CONSTRAINT `ideas_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ideas_ibfk_2` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ideas_ibfk_3` FOREIGN KEY (`flagged_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `idea_attachments`
--
ALTER TABLE `idea_attachments`
  ADD CONSTRAINT `idea_attachments_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `idea_attachments_ibfk_2` FOREIGN KEY (`uploaded_by_contributor_id`) REFERENCES `contributors` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `idea_category_tags`
--
ALTER TABLE `idea_category_tags`
  ADD CONSTRAINT `fk_idea_category_tags_category` FOREIGN KEY (`category_id`) REFERENCES `idea_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_idea_category_tags_idea` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `idea_views`
--
ALTER TABLE `idea_views`
  ADD CONSTRAINT `idea_views_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `idea_views_ibfk_2` FOREIGN KEY (`viewer_id`) REFERENCES `contributors` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `idea_votes`
--
ALTER TABLE `idea_votes`
  ADD CONSTRAINT `idea_votes_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `idea_votes_ibfk_2` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inappropriate_content_log`
--
ALTER TABLE `inappropriate_content_log`
  ADD CONSTRAINT `inappropriate_content_log_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `qa_coordinator_departments`
--
ALTER TABLE `qa_coordinator_departments`
  ADD CONSTRAINT `qa_coordinator_departments_ibfk_1` FOREIGN KEY (`coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `qa_managers`
--
ALTER TABLE `qa_managers`
  ADD CONSTRAINT `qa_managers_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `idea_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `staff_idea_reports`
--
ALTER TABLE `staff_idea_reports`
  ADD CONSTRAINT `staff_idea_reports_ibfk_1` FOREIGN KEY (`reporter_id`) REFERENCES `contributors` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `staff_invitations`
--
ALTER TABLE `staff_invitations`
  ADD CONSTRAINT `staff_invitations_ibfk_1` FOREIGN KEY (`coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_invitations_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_invitations_ibfk_3` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `staff_submission_tracking`
--
ALTER TABLE `staff_submission_tracking`
  ADD CONSTRAINT `staff_submission_tracking_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_submission_tracking_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `staff_tc_acceptance`
--
ALTER TABLE `staff_tc_acceptance`
  ADD CONSTRAINT `staff_tc_acceptance_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `system_backups`
--
ALTER TABLE `system_backups`
  ADD CONSTRAINT `fk_system_backups_admin` FOREIGN KEY (`created_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `system_notifications`
--
ALTER TABLE `system_notifications`
  ADD CONSTRAINT `system_notifications_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `system_notifications_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
