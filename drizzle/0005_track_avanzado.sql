DROP INDEX `chapters_number_unique`;--> statement-breakpoint
ALTER TABLE `chapters` ADD `track` text DEFAULT 'basico' NOT NULL;--> statement-breakpoint
CREATE UNIQUE INDEX `chapters_track_number_unique` ON `chapters` (`track`,`number`);--> statement-breakpoint
ALTER TABLE `parts` ADD `track` text DEFAULT 'basico' NOT NULL;--> statement-breakpoint
ALTER TABLE `users` ADD `track` text DEFAULT 'basico' NOT NULL;