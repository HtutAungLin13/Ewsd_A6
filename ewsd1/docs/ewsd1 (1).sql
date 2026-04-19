-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2026 at 08:06 AM
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
(1, '2024-2025', '2024-09-01', '2025-08-31', 1, '2026-03-17 12:28:14', '2026-03-17 12:28:14'),
(2, '2025-2026', '2025-09-01', '2026-08-31', 0, '2026-03-17 12:28:14', '2026-03-17 12:28:14');

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
(1, 'admin', 'admin@ewsd.local', '$2y$10$2oynwjICRS53CIp.tBWMI.nhF.NhCL1xNdqeH4bwYRhRvO78s/ar6', 'System Admin', 'Admin', 'Administration', 1, '2026-03-22 05:22:29', '2026-03-20 10:41:31', '2026-03-22 05:22:29'),
(6, 'staff1', 'staff1@example.com', '$2y$10$mTw4BtoCgoyFCzU7wbU1POboes9U9VVCcwbaADWAAbGs346P3PMPS', 'Test Staff', 'Staff', 'Innovation', 1, '2026-03-22 05:59:09', '2026-03-20 10:41:31', '2026-03-22 05:59:09'),
(9, 'staff2', 'staff2@example.com', '$2y$10$GbafrNeX1FlkAyoj94vHYuxO6r6ipFZ3lBzTXFtP8AaNI9uau7VKO', 'Staff User Two', 'Staff', 'Innovation', 1, '2026-03-22 06:02:42', '2026-03-20 10:41:31', '2026-03-22 06:02:42'),
(10, 'QAc', '13halhtutalin@gmail.com', '$2y$10$faKza9v7csg8PUNhP95FJuBnPhsu4J7wmhqPXGYAYm7ffZzgawe9i', 'hlin', 'QAManager', '.', 1, '2026-03-22 06:01:16', '2026-03-21 04:12:54', '2026-03-22 06:01:16'),
(11, 'QAc_old', 'lyon123@gmail.com', '$2y$10$faKza9v7csg8PUNhP95FJuBnPhsu4J7wmhqPXGYAYm7ffZzgawe9i', 'Leyon', 'QACoordinator', 'Tech', 1, '2026-03-22 06:57:39', '2026-03-21 05:17:37', '2026-03-22 06:57:39');

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
(5, 1, 'ADMIN_CREATE_BACKUP', 'system_backups', 1, '{\"scope\":[\"users\",\"departments\",\"settings\",\"categories\",\"notifications\",\"security\"]}', '::1', '2026-03-22 05:03:41');

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
(1, 'Quarterly Category Backup', '[{\"id\":1,\"name\":\"Technology\",\"description\":\"Technology and innovation ideas\",\"is_active\":1},{\"id\":2,\"name\":\"Social Impact\",\"description\":\"Ideas for social good\",\"is_active\":1},{\"id\":3,\"name\":\"Sustainability\",\"description\":\"Environmental and sustainability initiatives\",\"is_active\":1},{\"id\":4,\"name\":\"Business\",\"description\":\"Business and entrepreneurship ideas\",\"is_active\":1},{\"id\":6,\"name\":\"Test\",\"description\":\"Test\",\"is_active\":1}]', 'Initial seeded backup for dashboard testing', 1, '2026-03-22 01:30:00');

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
(7, 10, 13, 'test', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-03-22 05:58:29', '2026-03-22 05:58:29'),
(8, 11, 13, 'test111', 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2026-03-22 06:05:09', '2026-03-22 06:05:09');

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
(6, 8, 11, 13, 'Leyon', 'lyon123@gmail.com', 0, NULL, 0, '2026-03-22 06:05:09', '2026-03-22 06:05:09');

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
(14, '8a363037-e7c8-416d-ba99-2353a32ada9c', 'Test Staff', 'staff1@example.com', 'Innovation', 0, 'Active', NULL, NULL, NULL, NULL, '2026-03-21 05:24:39', '2026-03-21 05:24:39');

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
(5, 11, 'Idea', 1, 'Possible duplicate with existing proposal', 'Other', 'The scope appears similar to a previously approved idea.', 'Low', 'Dismissed', 0, NULL, '2026-03-18 02:10:00', '2026-03-18 03:00:00'),
(6, 11, 'Comment', 1, 'Contains borderline offensive tone', 'Offensive', 'Needs QA manager review before visible escalation.', 'Medium', 'Under_Review', 1, '2026-03-19 04:25:00', '2026-03-19 04:10:00', NULL),
(7, 11, 'Idea', 2, 'Contains unsupported claims', 'Defamation', 'Statement references a team without evidence.', 'High', 'Flagged', 1, '2026-03-20 06:15:00', '2026-03-20 06:00:00', NULL);

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

--
-- Dumping data for table `coordinator_reminders`
--

INSERT INTO `coordinator_reminders` (`id`, `coordinator_id`, `session_id`, `department`, `reminder_type`, `recipients_count`, `message`, `sent_at`) VALUES
(7, 11, 1, 'Innovation', 'Invitation', 4, 'You are invited to submit ideas before the submission window closes.', '2026-03-16 01:30:00'),
(8, 11, 1, 'Innovation', 'Reminder', 3, 'Friendly reminder to post at least one idea and comment on peers.', '2026-03-18 01:45:00'),
(9, 11, 1, 'Innovation', 'Final_Call', 2, 'Final call: submissions close tonight at 23:59.', '2026-03-21 11:00:00');

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
(2, 'Innovation', NULL, 1, '2026-03-21 04:08:22', '2026-03-21 04:08:22'),
(4, 'Operations', NULL, 1, '2026-03-21 04:08:22', '2026-03-21 04:08:22'),
(7, 'Marketing', NULL, 1, '2026-03-21 04:08:22', '2026-03-21 04:08:22'),
(9, 'Technology', NULL, 1, '2026-03-21 04:08:22', '2026-03-21 04:08:22'),
(421, '.', NULL, 1, '2026-03-21 04:12:54', '2026-03-21 04:12:54'),
(526, 'Tech', NULL, 1, '2026-03-21 05:17:37', '2026-03-21 05:17:37'),
(4531, 'Test', 11, 1, '2026-03-22 06:02:26', '2026-03-22 06:02:26');

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
(14, 'staff2@example.com', 'Staff', '', 'New coordinator comment on your idea: t3', 'Leyon commented in sample: test111', 11, 8, 4, '2026-03-22 00:05:09', NULL, 'Failed');

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
(2, 1, 2, 'Automated Testing Framework', 'Implement automated testing to improve code quality', 'Technology', 'High', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 17, 1, 0, '2024-02-05 04:30:00', '2024-02-20 03:00:00', NULL, '2026-03-18 08:20:10', '2026-03-22 05:58:02', 2, 1, 0, 0),
(3, 2, 3, 'Community Outreach Program', 'Partner with local organizations for community impact', 'Operations', 'Medium', 'Submitted', 'Pending', 0, NULL, NULL, NULL, 0, 0, 0, '2024-02-10 02:15:00', NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10', 0, 0, 0, 0),
(4, 2, 4, 'Anonymous Suggestion Box', 'Digital suggestion box for employee feedback', 'Innovation', 'Medium', 'Submitted', 'Pending', 0, NULL, NULL, NULL, 0, 0, 0, '2024-02-12 07:45:00', NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10', 0, 0, 0, 0),
(5, 3, 5, 'Solar Panel Installation', 'Install solar panels in the office', 'Technology', 'High', 'Submitted', '', 0, NULL, NULL, NULL, 0, 0, 0, '2024-03-05 01:30:00', NULL, NULL, '2026-03-18 08:20:10', '2026-03-18 08:20:10', 0, 0, 0, 0),
(6, 4, 6, 'testing', 'testing', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 0, 0, 0, '2026-03-21 05:43:28', NULL, NULL, '2026-03-21 05:43:28', '2026-03-21 05:43:28', 0, 0, 0, 1),
(7, 4, 14, 'testing2', 'testing2', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 3, 0, 0, '2026-03-21 06:50:02', NULL, NULL, '2026-03-21 06:50:02', '2026-03-21 09:02:48', 1, 0, 0, 1),
(8, 4, 6, 'testing3', 'testing3', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 4, 0, 0, '2026-03-21 06:58:08', NULL, NULL, '2026-03-21 06:58:08', '2026-03-21 09:00:47', 0, 0, 0, 1),
(9, 4, 6, '333', '333', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 7, 0, 1, '2026-03-21 09:05:11', NULL, NULL, '2026-03-21 09:05:11', '2026-03-21 09:09:35', 0, 0, 0, 0),
(10, 4, 6, '1', '1', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 3, 1, 1, '2026-03-22 05:29:02', NULL, NULL, '2026-03-22 05:29:02', '2026-03-22 05:58:29', 2, 0, 0, 0),
(11, 4, 6, 't3', 't3', 'Innovation', 'Medium', 'Submitted', 'Approved', 0, NULL, NULL, NULL, 2, 0, 1, '2026-03-22 06:03:05', NULL, NULL, '2026-03-22 06:03:05', '2026-03-22 06:05:09', 0, 0, 0, 1);

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
(3, 1, 'mockup.png', '/uploads/ideas/mockup.png', 'image/png', 245981, 1, 0, NULL, '2026-03-18 02:40:00');

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
(6, 'Test', 'Test', 1, '2026-03-22 06:02:13', '2026-03-22 06:02:13');

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
(6, 11, 1, '2026-03-22 06:03:05');

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
(48, 11, 13, NULL, '2026-03-22 06:04:58');

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
(5, 10, 13, 'up', '2026-03-22 05:58:27');

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
(1, 10, 'Comment', 1, 'Contains unprofessional wording', 'Flagged', 'Flagged for moderation follow-up', '2026-03-19 04:30:00'),
(2, 10, 'Idea', 2, 'Potentially defamatory claim', 'Hidden', 'Temporarily hidden pending review', '2026-03-20 06:20:00'),
(3, 10, 'Attachment', 1, 'Contains unrelated personal data', 'Removed', 'Attachment removed and uploader notified', '2026-03-21 02:55:00');

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
(4, 11, 'Tech', '2026-03-21 05:17:37', 1),
(5, 11, 'Test', '2026-03-22 06:02:26', 1);

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
(2, 10, '.', 1, '2026-03-21 04:12:54', '2026-03-21 04:12:54');

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
(1, 1, 1, 'Tech Ideas 2024', 'Submit your technology innovation ideas', '2024-01-15 00:00:00', '2024-03-31 23:59:59', '2024-03-31 23:59:59', 'Active', '2026-03-17 12:28:14', '2026-03-20 07:53:10'),
(2, 1, 2, 'Social Impact 2024', 'Ideas for social good initiatives', '2024-02-01 00:00:00', '2024-04-15 23:59:59', '2024-04-15 23:59:59', 'Active', '2026-03-17 12:28:14', '2026-03-20 07:53:10'),
(3, 1, 3, 'Green Ideas', 'Sustainability and environmental ideas', '2024-03-01 00:00:00', '2024-05-31 23:59:59', '2024-05-31 23:59:59', 'Draft', '2026-03-17 12:28:14', '2026-03-20 07:53:10'),
(4, 2, 1, 'sample', 'sample', '2026-03-14 12:42:00', '2026-03-28 12:42:00', '2026-03-28 12:42:00', 'Active', '2026-03-21 05:42:47', '2026-03-21 05:42:47');

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
(9, 'Staff User Two', 'staff2@example.com', 'Staff', 'Innovation', '', 1, '2026-03-20 07:35:27', '2026-03-20 07:35:27');

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
(1, 6, 'Idea', 7, 'Harassment', 'test', 'test', 'Medium', 'Reported', '2026-03-21 09:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `staff_invitations`
--

CREATE TABLE `staff_invitations` (
  `id` int(11) NOT NULL,
  `coordinator_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_invitations`
--

INSERT INTO `staff_invitations` (`id`, `coordinator_id`, `staff_id`, `session_id`, `message`, `sent_at`, `read_at`) VALUES
(1, 11, 1, 1, 'Please share one improvement idea for this session.', '2026-03-16 01:35:00', '2026-03-16 02:10:00'),
(2, 11, 2, 1, 'Your department input is needed for quality review planning.', '2026-03-16 01:36:00', NULL),
(3, 11, 3, 1, 'Reminder: comment on at least one peer idea before close.', '2026-03-18 01:50:00', '2026-03-18 03:05:00');

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
(11, 4, 'Innovation', 9, 1, '2026-03-21 05:43:28', 10, '2026-03-22 06:03:05', '2026-03-21 05:43:28', '2026-03-22 06:03:05'),
(13, 4, 'Innovation', 6, 1, '2026-03-21 06:50:02', 2, '2026-03-21 06:50:02', '2026-03-21 06:50:02', '2026-03-21 06:50:02');

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
(13, 6, 1, '2026-03-21 06:48:05', '::1');

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
(11, 'Staff', NULL, 'staff2@example.com', '', 'Coordinator Comment on Your Idea', 'Leyon commented: test111', 11, 8, 0, NULL, '2026-03-22 06:05:09');

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
(85, 10, '009c6ebea34571f0e292b499994bf65b9304438821db5912470851adcf7304ee', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 05:24:31', '2026-03-21 04:24:31'),
(86, 1, 'dfe74228b55d9f2ec3f9794c9c2b58f2ad74da0a7499a9d15449b7341ad77a1f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:15:47', '2026-03-21 05:15:47'),
(87, 11, '90482f977ca3b74815ecfbf83b582ce980540e6226a688c701525b7dcd58f827', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:18:24', '2026-03-21 05:18:24'),
(88, 6, '4b642c9d6e21e7e6646f631b8cd361064e468eba9967a1a8e7350215f1be5447', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:24:36', '2026-03-21 05:24:36'),
(89, 1, '47beb70523bc06981dad1cd6c8f7ea5bdcce2ad6fb4e6d7a980eb4182e70f956', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:25:23', '2026-03-21 05:25:23'),
(90, 10, '1140f0b2c3dbb48d73171208c41828ad902b7c14907c53c82ab8235392572d1c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:27:10', '2026-03-21 05:27:10'),
(91, 11, '98b1693d3e3ddbfc425b75ed47abbcc3d219081b21016e02fafd7e252b5aadf2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:27:40', '2026-03-21 05:27:40'),
(92, 1, '4db640e1df5e508231d14d894bbdb449a04d0a212adbf0a5916701253b63cb4e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:35:06', '2026-03-21 05:35:06'),
(93, 9, '38187ec4439f0bf7961f968ebd6f434df00e2e59c3ab70e49b911e5ae1cb9a3d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:36:18', '2026-03-21 05:36:18'),
(94, 10, 'cf62a0fe00faf950cc21c256d5f0de0fe770302e2b876ea06322b8c9b71f9817', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:36:39', '2026-03-21 05:36:39'),
(95, 6, '1ab6e78c93cdb81dd1d6441860a765387848fc8a8146a69fc616f13f6763e0f4', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:38:44', '2026-03-21 05:38:44'),
(96, 1, 'f03a135f5aa0e123670a3ec85d07c7dbc1c8af10ffda19637edc06ca8fa3cf78', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:41:43', '2026-03-21 05:41:43'),
(97, 9, '4fdf7b7d1109c7430886d44e56a578092ee880053b5121eaaeec72a296314c7d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:43:01', '2026-03-21 05:43:01'),
(98, 11, '1dc91bf4fd984a2db12b0f446c010c722e6a977696000b9ef45864a40b218b5e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:44:03', '2026-03-21 05:44:03'),
(99, 1, 'c416dc7c4f9d5bab014d846ce4dcbe25a520f2c98f82e8303b59ca5135a473cf', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:46:07', '2026-03-21 05:46:07'),
(100, 1, '4564c9bd6da2eb3feaeabde9d9fbf950a36584d6b69cb483c4a62f409c6d4ccb', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:49:28', '2026-03-21 05:49:28'),
(101, 10, '6ea1bbbcda88ed74b3b3e80be9aec8c97462bd821e64b425773fabbb008a8abf', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:55:23', '2026-03-21 05:55:23'),
(102, 11, 'fe158cdd615e2c638c45837a810ce81f43081230e4da45654ed133f6217f0f94', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 06:55:40', '2026-03-21 05:55:40'),
(103, 10, 'a8e30157ecaac3b939bb9b156dc9cccee2e8168485a24dfcd357a779a06c33ad', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 07:06:47', '2026-03-21 06:06:47'),
(104, 6, '15e0934d705c3cc845667887656977a1cc55931204aeba966efb476774c639ba', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 07:47:40', '2026-03-21 06:47:40'),
(105, 11, 'd633e859eed308bc5f66b00c4e0d0ae2bfc92ab33c53986823a55bfb0405e445', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 07:50:23', '2026-03-21 06:50:23'),
(106, 9, '0eb9e672acad70c601dc541b6fdab9fe63a72f4e656da27236dc6ace2b7742cd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 07:51:55', '2026-03-21 06:51:55'),
(107, 9, '45be0402c528c8ba22b2311e3136b6430c09299404789b74a605902fe2b6a624', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 07:57:50', '2026-03-21 06:57:50'),
(108, 11, 'a4a9e24a5639fd8d2400897f169ff56270f5a70a191f6c2f9ba5b5fb22fe0069', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 07:58:26', '2026-03-21 06:58:26'),
(109, 1, 'b91e602419f9e596ac9a285eeb463e570b50b80117ef61485e171bb30d54e665', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 08:09:42', '2026-03-21 07:09:42'),
(110, 6, '265e9dd175cce037e77a97a688a5a557805b963295893030e2a08154914b09ac', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 09:41:07', '2026-03-21 08:41:07'),
(111, 1, 'fd18729559f2ff453e1440720f5aa94c968e5825416fdc903e02d25e21d5fab2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 09:42:49', '2026-03-21 08:42:49'),
(112, 10, '03227cf8b96cf0b43030f3109a2ed33b1bc70b51ed209878a5d59929d19c477e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 09:50:30', '2026-03-21 08:50:30'),
(113, 11, '5387b48e837b18ac04489f699c9fb977493d47b82223bf868e12a443065cb606', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 09:58:35', '2026-03-21 08:58:35'),
(114, 9, 'b9bc7ed70715930a7a80cbbe3c3a662fc815c076eb4aad51944b0ac45881c75f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 10:02:03', '2026-03-21 09:02:03'),
(115, 11, 'b7e6182b778d780da995a166812c2ddf4ff7972e08c6e3633d9db10365f67d26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 10:05:53', '2026-03-21 09:05:53'),
(116, 9, 'c17b9449bf40cc2aa37ebca5d6b5825df5b7e1056608255816bdb9d97b52a2b9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-22 10:06:58', '2026-03-21 09:06:58'),
(117, 1, '0119fc76a75f1258d575201dcb5f49254fd7c30aa696a3e05285721fb301d4f0', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:03:24', '2026-03-22 05:03:24'),
(118, 10, 'cddfea2be8bb0ac8efc92cdf7b7e399dbe341a7198f9ac33134dcb6be63953e3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:05:08', '2026-03-22 05:05:08'),
(119, 1, 'b79344e6542e30dfc11b340c93fcfe361245894268bdc5f1868cc5e1c984e218', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:05:49', '2026-03-22 05:05:49'),
(120, 10, 'd0e59f595cb3a000a7ca2838a8b9abaa02140b29164b1caea613470dea4cb2a5', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:07:45', '2026-03-22 05:07:45'),
(121, 1, '188a79168773dddc72fb03793eb9839588f2de35a9179c74d279f8c764430a08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:08:48', '2026-03-22 05:08:48'),
(122, 10, '25ecfe8d796d4cbc77b36998f7880188def3f437118debc0962e4fe73cbc6dd7', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:11:29', '2026-03-22 05:11:29'),
(123, 1, '4145faedf40e81a4f0331deb16ae9fb877f15f128aec241f83b01eaccbbadf5d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:22:29', '2026-03-22 05:22:29'),
(124, 11, '7a423849c36d8f4d7c3b4ecf649eecc5c49d56f741296094c02d79e05f385510', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:24:50', '2026-03-22 05:24:50'),
(125, 9, '8c19f0a814929332e1b5b2e0aedf1553e50a9d4d908df577b4fb4b4d97b203ef', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:26:21', '2026-03-22 05:26:21'),
(126, 9, 'acdc6e00723279789df9a531a3deea5a900055dfe9d704fa46fc5bec29bceebf', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:29:23', '2026-03-22 05:29:23'),
(127, 6, 'eccd8002aab0fb85dd1f3981208e2f6cd4a066c32fbab4943a93001f2bf3319c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:31:22', '2026-03-22 05:31:22'),
(128, 10, '54c4c0dafb34143acfa383180c9186b1432be973cd26ddab5cc70a7a8359f16b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:41:30', '2026-03-22 05:41:30'),
(129, 11, '15c1de1b79a18ad9b307d408ed3181c9fb7992aca9690abf00fd97ed8f9ae79c', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:42:12', '2026-03-22 05:42:12'),
(130, 10, '67cb15a019b1362fbefedee4b15dae143a6a94d2178fe1c34b531500b3dc488a', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:52:33', '2026-03-22 05:52:33'),
(131, 11, 'cb7ec9e0fa7ac1dec5a6d4862c139d200251a7f247f22ea1555a1723d1e0cd78', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:57:36', '2026-03-22 05:57:36'),
(132, 9, '9e44df98efae51b388cddb9cdd2f4b809ffbb27dd6ea614283ba8dca28403223', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:58:48', '2026-03-22 05:58:48'),
(133, 6, 'b91ef4e064e9744966c88f7e59593e2372fc351ece0bf955d017ea161244e448', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 06:59:09', '2026-03-22 05:59:09'),
(134, 10, '2750d857cef16f2a9df7fad8b9f3411e37a1d77eb11b3bd1c50e6adb63223492', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 07:01:16', '2026-03-22 06:01:16'),
(135, 9, '6c236a7cac2df04a8d28321ef78f3e5d2a0d366f6e43a01d62a39346fc7b7697', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 07:02:42', '2026-03-22 06:02:42'),
(136, 11, '5f92bf7b80c699f7e0f368d7d6fb6834b003b3784209d3c53cf70394f9c0cc7e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 07:03:17', '2026-03-22 06:03:17'),
(137, 11, '4ea0b62c76b91eaaf9f59f89c18e5ad7a486102033ed64cfab61d9e6037d5cc1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 07:55:45', '2026-03-22 06:55:45'),
(138, 11, '4f3cee9a85e3d1aa49afdc1ed43cf8c6b71245f0d74ddad8f02ddcef892a448b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-23 07:57:39', '2026-03-22 06:57:39');

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
  ADD KEY `idx_sent_at` (`sent_at`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `category_backups`
--
ALTER TABLE `category_backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `comment_replies`
--
ALTER TABLE `comment_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `comment_response_tracking`
--
ALTER TABLE `comment_response_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `contributors`
--
ALTER TABLE `contributors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `contributor_account_history`
--
ALTER TABLE `contributor_account_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `coordinator_content_reports`
--
ALTER TABLE `coordinator_content_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `coordinator_reminders`
--
ALTER TABLE `coordinator_reminders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4532;

--
-- AUTO_INCREMENT for table `department_performance_stats`
--
ALTER TABLE `department_performance_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `email_notifications`
--
ALTER TABLE `email_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `ideas`
--
ALTER TABLE `ideas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `idea_attachments`
--
ALTER TABLE `idea_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `idea_categories`
--
ALTER TABLE `idea_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `idea_category_tags`
--
ALTER TABLE `idea_category_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `idea_views`
--
ALTER TABLE `idea_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `idea_votes`
--
ALTER TABLE `idea_votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `inappropriate_content_log`
--
ALTER TABLE `inappropriate_content_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notification_settings`
--
ALTER TABLE `notification_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1553;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=931;

--
-- AUTO_INCREMENT for table `qa_coordinator_departments`
--
ALTER TABLE `qa_coordinator_departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `qa_hidden_content_records`
--
ALTER TABLE `qa_hidden_content_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `qa_managers`
--
ALTER TABLE `qa_managers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `staff_idea_reports`
--
ALTER TABLE `staff_idea_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `staff_invitations`
--
ALTER TABLE `staff_invitations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `staff_submission_tracking`
--
ALTER TABLE `staff_submission_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `staff_tc_acceptance`
--
ALTER TABLE `staff_tc_acceptance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `system_backups`
--
ALTER TABLE `system_backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `system_notifications`
--
ALTER TABLE `system_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2481;

--
-- AUTO_INCREMENT for table `terms_and_conditions`
--
ALTER TABLE `terms_and_conditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

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
