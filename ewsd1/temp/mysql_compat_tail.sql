ALTER TABLE `user_sessions`
  MODIFY `session_token` varchar(64) NOT NULL,
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `idx_session_token` (`session_token`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_expires_at` (`expires_at`);

ALTER TABLE `academic_years`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `category_backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
ALTER TABLE `comment_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `comment_response_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `contributors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
ALTER TABLE `contributor_account_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `coordinator_content_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
ALTER TABLE `coordinator_reminders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4532;
ALTER TABLE `department_performance_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
ALTER TABLE `email_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
ALTER TABLE `ideas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
ALTER TABLE `idea_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `idea_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `idea_category_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `idea_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
ALTER TABLE `idea_votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `inappropriate_content_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `notification_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1553;
ALTER TABLE `notification_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=931;
ALTER TABLE `qa_coordinator_departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `qa_hidden_content_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `qa_managers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
ALTER TABLE `staff_idea_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `staff_invitations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `staff_submission_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
ALTER TABLE `staff_tc_acceptance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
ALTER TABLE `system_backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `system_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2481;
ALTER TABLE `terms_and_conditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
ALTER TABLE `category_backups`
  ADD CONSTRAINT `fk_category_backups_admin` FOREIGN KEY (`created_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`flagged_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `comments_ibfk_4` FOREIGN KEY (`deleted_by`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;
ALTER TABLE `comment_replies`
  ADD CONSTRAINT `comment_replies_ibfk_1` FOREIGN KEY (`parent_comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_replies_ibfk_2` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_replies_ibfk_3` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_replies_ibfk_4` FOREIGN KEY (`mentioned_staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL;
ALTER TABLE `comment_response_tracking`
  ADD CONSTRAINT `comment_response_tracking_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_response_tracking_ibfk_2` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_response_tracking_ibfk_3` FOREIGN KEY (`comment_author_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE;
ALTER TABLE `contributors`
  ADD CONSTRAINT `contributors_ibfk_1` FOREIGN KEY (`disabled_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;
ALTER TABLE `contributor_account_history`
  ADD CONSTRAINT `contributor_account_history_ibfk_1` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contributor_account_history_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
ALTER TABLE `coordinator_content_reports`
  ADD CONSTRAINT `coordinator_content_reports_ibfk_1` FOREIGN KEY (`coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
ALTER TABLE `coordinator_reminders`
  ADD CONSTRAINT `coordinator_reminders_ibfk_1` FOREIGN KEY (`coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coordinator_reminders_ibfk_2` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;
ALTER TABLE `departments`
  ADD CONSTRAINT `fk_departments_coordinator` FOREIGN KEY (`qa_coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;
ALTER TABLE `department_performance_stats`
  ADD CONSTRAINT `department_performance_stats_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;
ALTER TABLE `email_notifications`
  ADD CONSTRAINT `email_notifications_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `email_notifications_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `email_notifications_ibfk_3` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE SET NULL;
ALTER TABLE `ideas`
  ADD CONSTRAINT `ideas_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ideas_ibfk_2` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ideas_ibfk_3` FOREIGN KEY (`flagged_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL;
ALTER TABLE `idea_attachments`
  ADD CONSTRAINT `idea_attachments_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `idea_attachments_ibfk_2` FOREIGN KEY (`uploaded_by_contributor_id`) REFERENCES `contributors` (`id`) ON DELETE SET NULL;
ALTER TABLE `idea_category_tags`
  ADD CONSTRAINT `fk_idea_category_tags_category` FOREIGN KEY (`category_id`) REFERENCES `idea_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_idea_category_tags_idea` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE;
ALTER TABLE `idea_views`
  ADD CONSTRAINT `idea_views_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `idea_views_ibfk_2` FOREIGN KEY (`viewer_id`) REFERENCES `contributors` (`id`) ON DELETE SET NULL;
ALTER TABLE `idea_votes`
  ADD CONSTRAINT `idea_votes_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `idea_votes_ibfk_2` FOREIGN KEY (`contributor_id`) REFERENCES `contributors` (`id`) ON DELETE CASCADE;
ALTER TABLE `inappropriate_content_log`
  ADD CONSTRAINT `inappropriate_content_log_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
ALTER TABLE `qa_coordinator_departments`
  ADD CONSTRAINT `qa_coordinator_departments_ibfk_1` FOREIGN KEY (`coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
ALTER TABLE `qa_managers`
  ADD CONSTRAINT `qa_managers_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `idea_categories` (`id`) ON DELETE CASCADE;
ALTER TABLE `staff_idea_reports`
  ADD CONSTRAINT `staff_idea_reports_ibfk_1` FOREIGN KEY (`reporter_id`) REFERENCES `contributors` (`id`) ON DELETE SET NULL;
ALTER TABLE `staff_invitations`
  ADD CONSTRAINT `staff_invitations_ibfk_1` FOREIGN KEY (`coordinator_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_invitations_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_invitations_ibfk_3` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;
ALTER TABLE `staff_submission_tracking`
  ADD CONSTRAINT `staff_submission_tracking_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_submission_tracking_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE;
ALTER TABLE `staff_tc_acceptance`
  ADD CONSTRAINT `staff_tc_acceptance_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE;
ALTER TABLE `system_backups`
  ADD CONSTRAINT `fk_system_backups_admin` FOREIGN KEY (`created_by_admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
ALTER TABLE `system_notifications`
  ADD CONSTRAINT `system_notifications_ibfk_1` FOREIGN KEY (`idea_id`) REFERENCES `ideas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `system_notifications_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE SET NULL;
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE;
