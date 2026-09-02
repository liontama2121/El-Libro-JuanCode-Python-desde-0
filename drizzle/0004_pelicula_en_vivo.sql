CREATE TABLE `trace_demos` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`chapter_id` integer NOT NULL,
	`orden` integer DEFAULT 1 NOT NULL,
	`title` text NOT NULL,
	`description` text DEFAULT '' NOT NULL,
	`code` text DEFAULT '' NOT NULL,
	`columns_json` text DEFAULT '[]' NOT NULL,
	`steps_json` text DEFAULT '[]' NOT NULL,
	`active` integer DEFAULT true NOT NULL,
	FOREIGN KEY (`chapter_id`) REFERENCES `chapters`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE INDEX `trace_demos_chapter_idx` ON `trace_demos` (`chapter_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `trace_demos_chapter_orden_idx` ON `trace_demos` (`chapter_id`,`orden`);