CREATE TABLE `code_runs` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`user_id` text NOT NULL,
	`exercise_id` integer,
	`code` text NOT NULL,
	`passed` integer DEFAULT false NOT NULL,
	`results_json` text DEFAULT '[]' NOT NULL,
	`created_at` integer DEFAULT (unixepoch() * 1000) NOT NULL,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`exercise_id`) REFERENCES `exercises`(`id`) ON UPDATE no action ON DELETE set null
);
--> statement-breakpoint
CREATE INDEX `code_runs_user_idx` ON `code_runs` (`user_id`,`created_at`);--> statement-breakpoint
ALTER TABLE `exercises` ADD `source` text DEFAULT 'profe' NOT NULL;--> statement-breakpoint
ALTER TABLE `question_bank` ADD `source` text DEFAULT 'profe' NOT NULL;