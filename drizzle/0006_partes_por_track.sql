DROP INDEX `parts_number_unique`;--> statement-breakpoint
CREATE UNIQUE INDEX `parts_track_number_unique` ON `parts` (`track`,`number`);