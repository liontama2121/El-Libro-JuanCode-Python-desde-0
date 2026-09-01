import { sql } from "drizzle-orm";
import {
	index,
	integer,
	sqliteTable,
	text,
	uniqueIndex,
} from "drizzle-orm/sqlite-core";

/* -------------------------------------------------------------------------- */
/*  AUTENTICACIÓN (Better Auth + adaptador Drizzle, usePlural: true)           */
/* -------------------------------------------------------------------------- */

export const users = sqliteTable("users", {
	id: text("id").primaryKey(),
	name: text("name").notNull(),
	username: text("username").notNull().unique(),
	email: text("email").notNull().unique(),
	emailVerified: integer("email_verified", { mode: "boolean" })
		.notNull()
		.default(true),
	image: text("image"),
	/** 'teacher' | 'student' */
	role: text("role").notNull().default("student"),
	/** Obliga a cambiar la clave temporal en el primer ingreso */
	mustChangePassword: integer("must_change_password", { mode: "boolean" })
		.notNull()
		.default(false),
	createdAt: integer("created_at", { mode: "timestamp_ms" })
		.notNull()
		.default(sql`(unixepoch() * 1000)`),
	updatedAt: integer("updated_at", { mode: "timestamp_ms" })
		.notNull()
		.default(sql`(unixepoch() * 1000)`),
});

export const sessions = sqliteTable("sessions", {
	id: text("id").primaryKey(),
	token: text("token").notNull().unique(),
	userId: text("user_id")
		.notNull()
		.references(() => users.id, { onDelete: "cascade" }),
	expiresAt: integer("expires_at", { mode: "timestamp_ms" }).notNull(),
	ipAddress: text("ip_address"),
	userAgent: text("user_agent"),
	createdAt: integer("created_at", { mode: "timestamp_ms" }).notNull(),
	updatedAt: integer("updated_at", { mode: "timestamp_ms" }).notNull(),
});

/**
 * Better Auth guarda el hash de la contraseña aquí (columna `password`), en la
 * fila con provider_id = 'credential'. Es el `password_hash` del usuario.
 */
export const accounts = sqliteTable("accounts", {
	id: text("id").primaryKey(),
	userId: text("user_id")
		.notNull()
		.references(() => users.id, { onDelete: "cascade" }),
	accountId: text("account_id").notNull(),
	providerId: text("provider_id").notNull(),
	/** Better Auth >= 1.7: 'local:credential' para usuario+contraseña */
	issuer: text("issuer").notNull().default("local:credential"),
	password: text("password"),
	accessToken: text("access_token"),
	refreshToken: text("refresh_token"),
	idToken: text("id_token"),
	accessTokenExpiresAt: integer("access_token_expires_at", {
		mode: "timestamp_ms",
	}),
	refreshTokenExpiresAt: integer("refresh_token_expires_at", {
		mode: "timestamp_ms",
	}),
	scope: text("scope"),
	createdAt: integer("created_at", { mode: "timestamp_ms" }).notNull(),
	updatedAt: integer("updated_at", { mode: "timestamp_ms" }).notNull(),
});

export const verifications = sqliteTable("verifications", {
	id: text("id").primaryKey(),
	identifier: text("identifier").notNull(),
	value: text("value").notNull(),
	expiresAt: integer("expires_at", { mode: "timestamp_ms" }).notNull(),
	createdAt: integer("created_at", { mode: "timestamp_ms" }),
	updatedAt: integer("updated_at", { mode: "timestamp_ms" }),
});

/* -------------------------------------------------------------------------- */
/*  CONTENIDO DEL LIBRO                                                        */
/* -------------------------------------------------------------------------- */

export const parts = sqliteTable("parts", {
	id: integer("id").primaryKey({ autoIncrement: true }),
	number: integer("number").notNull().unique(),
	title: text("title").notNull(),
	emoji: text("emoji").notNull().default("📘"),
});

export const chapters = sqliteTable(
	"chapters",
	{
		id: integer("id").primaryKey({ autoIncrement: true }),
		partId: integer("part_id")
			.notNull()
			.references(() => parts.id, { onDelete: "cascade" }),
		/** Orden global dentro del libro: 1..24 */
		number: integer("number").notNull(),
		title: text("title").notNull(),
		emoji: text("emoji").notNull().default("📖"),
		description: text("description").notNull().default(""),
		contentHtml: text("content_html").notNull().default(""),
		published: integer("published", { mode: "boolean" })
			.notNull()
			.default(false),
	},
	(t) => [uniqueIndex("chapters_number_unique").on(t.number)],
);

export const exercises = sqliteTable(
	"exercises",
	{
		id: integer("id").primaryKey({ autoIncrement: true }),
		chapterId: integer("chapter_id")
			.notNull()
			.references(() => chapters.id, { onDelete: "cascade" }),
		orden: integer("orden").notNull().default(1),
		title: text("title").notNull(),
		/** 'facil' | 'medio' | 'dificil' */
		difficulty: text("difficulty").notNull().default("facil"),
		statementHtml: text("statement_html").notNull().default(""),
		hintHtml: text("hint_html").notNull().default(""),
		solutionHtml: text("solution_html").notNull().default(""),
	},
	(t) => [index("exercises_chapter_idx").on(t.chapterId)],
);

export const quizzes = sqliteTable("quizzes", {
	id: integer("id").primaryKey({ autoIncrement: true }),
	chapterId: integer("chapter_id")
		.notNull()
		.unique()
		.references(() => chapters.id, { onDelete: "cascade" }),
	passingScore: integer("passing_score").notNull().default(80),
});

export const questions = sqliteTable(
	"questions",
	{
		id: integer("id").primaryKey({ autoIncrement: true }),
		quizId: integer("quiz_id")
			.notNull()
			.references(() => quizzes.id, { onDelete: "cascade" }),
		orden: integer("orden").notNull().default(1),
		prompt: text("prompt").notNull(),
		/** Opcional: se muestra como bloque de código sobre las opciones */
		codeSnippet: text("code_snippet"),
	},
	(t) => [index("questions_quiz_idx").on(t.quizId)],
);

export const options = sqliteTable(
	"options",
	{
		id: integer("id").primaryKey({ autoIncrement: true }),
		questionId: integer("question_id")
			.notNull()
			.references(() => questions.id, { onDelete: "cascade" }),
		/** 'a' | 'b' | 'c' | 'd' */
		label: text("label").notNull(),
		text: text("text").notNull(),
		isCorrect: integer("is_correct", { mode: "boolean" })
			.notNull()
			.default(false),
	},
	(t) => [index("options_question_idx").on(t.questionId)],
);

/* -------------------------------------------------------------------------- */
/*  PROGRESO                                                                   */
/* -------------------------------------------------------------------------- */

export const quizAttempts = sqliteTable(
	"quiz_attempts",
	{
		id: integer("id").primaryKey({ autoIncrement: true }),
		userId: text("user_id")
			.notNull()
			.references(() => users.id, { onDelete: "cascade" }),
		quizId: integer("quiz_id")
			.notNull()
			.references(() => quizzes.id, { onDelete: "cascade" }),
		/** 0..100 */
		score: integer("score").notNull(),
		passed: integer("passed", { mode: "boolean" }).notNull().default(false),
		answersJson: text("answers_json").notNull().default("{}"),
		createdAt: integer("created_at", { mode: "timestamp_ms" })
			.notNull()
			.default(sql`(unixepoch() * 1000)`),
	},
	(t) => [index("quiz_attempts_user_idx").on(t.userId, t.quizId)],
);

export const unlocks = sqliteTable(
	"unlocks",
	{
		id: integer("id").primaryKey({ autoIncrement: true }),
		userId: text("user_id")
			.notNull()
			.references(() => users.id, { onDelete: "cascade" }),
		chapterId: integer("chapter_id")
			.notNull()
			.references(() => chapters.id, { onDelete: "cascade" }),
		/** 'quiz' | 'teacher' */
		source: text("source").notNull().default("quiz"),
		createdAt: integer("created_at", { mode: "timestamp_ms" })
			.notNull()
			.default(sql`(unixepoch() * 1000)`),
	},
	(t) => [uniqueIndex("unlocks_user_chapter_unique").on(t.userId, t.chapterId)],
);

export type User = typeof users.$inferSelect;
export type Part = typeof parts.$inferSelect;
export type Chapter = typeof chapters.$inferSelect;
export type Exercise = typeof exercises.$inferSelect;
export type Quiz = typeof quizzes.$inferSelect;
export type Question = typeof questions.$inferSelect;
export type Option = typeof options.$inferSelect;
export type QuizAttempt = typeof quizAttempts.$inferSelect;
export type Unlock = typeof unlocks.$inferSelect;
