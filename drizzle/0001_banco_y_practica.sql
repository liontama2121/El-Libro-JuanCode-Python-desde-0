CREATE TABLE `practice_attempts` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`user_id` text NOT NULL,
	`mode` text NOT NULL,
	`config_json` text DEFAULT '{}' NOT NULL,
	`score` integer DEFAULT 0 NOT NULL,
	`total` integer DEFAULT 0 NOT NULL,
	`xp_earned` integer DEFAULT 0 NOT NULL,
	`duration_seconds` integer DEFAULT 0 NOT NULL,
	`detail_json` text DEFAULT '{}' NOT NULL,
	`created_at` integer DEFAULT (unixepoch() * 1000) NOT NULL,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE INDEX `practice_attempts_user_idx` ON `practice_attempts` (`user_id`,`mode`);--> statement-breakpoint
CREATE TABLE `question_bank` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`chapter_id` integer NOT NULL,
	`type` text DEFAULT 'mcq' NOT NULL,
	`difficulty` text DEFAULT 'facil' NOT NULL,
	`prompt` text NOT NULL,
	`code_snippet` text,
	`data_json` text DEFAULT '{}' NOT NULL,
	`correct_json` text DEFAULT '{}' NOT NULL,
	`explanation` text DEFAULT '' NOT NULL,
	`active` integer DEFAULT true NOT NULL,
	FOREIGN KEY (`chapter_id`) REFERENCES `chapters`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE INDEX `question_bank_chapter_idx` ON `question_bank` (`chapter_id`,`type`,`difficulty`);--> statement-breakpoint
CREATE INDEX `question_bank_active_idx` ON `question_bank` (`active`);--> statement-breakpoint
ALTER TABLE `exercises` ADD `tests_json` text;--> statement-breakpoint
ALTER TABLE `exercises` ADD `starter_code` text;