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
		/** [{ stdin, expected_output }] para el Modo Codigo. null = sin tests */
		testsJson: text("tests_json"),
		/** Codigo inicial que aparece en el editor */
		starterCode: text("starter_code"),
		/**
		 * 'seed'  -> viene de content/exercises/NN.json (el seed lo reemplaza)
		 * 'profe' -> lo escribio el profesor en /admin (el seed no lo toca)
		 */
		source: text("source").notNull().default("profe"),
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

/* -------------------------------------------------------------------------- */
/*  BANCO DE PREGUNTAS                                                         */
/* -------------------------------------------------------------------------- */

/**
 * Una pregunta reutilizable. El quiz del capitulo, los simulacros y el arcade
 * beben todos de aqui.
 *
 *  mcq             data_json {options:[{id,text}]}      correct_json {option_id}
 *  predict_output  igual que mcq + code_snippet obligatorio
 *  find_bug        data_json {lines:[texto,...]}        correct_json {line_number}
 *  parsons         data_json {lines:[{id,text,indent}]} correct_json {order:[ids]}
 *                  (las lineas se entregan DESORDENADAS al estudiante)
 */
export const questionBank = sqliteTable(
	"question_bank",
	{
		id: integer("id").primaryKey({ autoIncrement: true }),
		chapterId: integer("chapter_id")
			.notNull()
			.references(() => chapters.id, { onDelete: "cascade" }),
		/** 'mcq' | 'predict_output' | 'find_bug' | 'parsons' */
		type: text("type").notNull().default("mcq"),
		/** 'facil' | 'medio' | 'dificil' */
		difficulty: text("difficulty").notNull().default("facil"),
		prompt: text("prompt").notNull(),
		codeSnippet: text("code_snippet"),
		dataJson: text("data_json").notNull().default("{}"),
		/** NUNCA viaja al cliente antes de responder */
		correctJson: text("correct_json").notNull().default("{}"),
		explanation: text("explanation").notNull().default(""),
		active: integer("active", { mode: "boolean" }).notNull().default(true),
		/** 'seed' (content/bank/NN.json) | 'profe' (escrita en /admin) */
		source: text("source").notNull().default("profe"),
	},
	(t) => [
		index("question_bank_chapter_idx").on(t.chapterId, t.type, t.difficulty),
		index("question_bank_active_idx").on(t.active),
	],
);

/** Todo lo que NO es el quiz oficial: simulacros, arcade y reto del dia. */
export const practiceAttempts = sqliteTable(
	"practice_attempts",
	{
		id: integer("id").primaryKey({ autoIncrement: true }),
		userId: text("user_id")
			.notNull()
			.references(() => users.id, { onDelete: "cascade" }),
		/**
		 * 'simulacro_quiz' | 'simulacro_parcial' | 'arcade_relampago' |
		 * 'arcade_detective' | 'arcade_puzzle' | 'arcade_sorpresa' |
		 * 'arcade_codigo' | 'reto_dia'
		 */
		mode: text("mode").notNull(),
		configJson: text("config_json").notNull().default("{}"),
		score: integer("score").notNull().default(0),
		total: integer("total").notNull().default(0),
		xpEarned: integer("xp_earned").notNull().default(0),
		durationSeconds: integer("duration_seconds").notNull().default(0),
		detailJson: text("detail_json").notNull().default("{}"),
		createdAt: integer("created_at", { mode: "timestamp_ms" })
			.notNull()
			.default(sql`(unixepoch() * 1000)`),
	},
	(t) => [index("practice_attempts_user_idx").on(t.userId, t.mode)],
);

/* -------------------------------------------------------------------------- */
/*  GAMIFICACION                                                               */
/* -------------------------------------------------------------------------- */

/**
 * XP, nivel, rachas e insignias de cada estudiante.
 * Lo escribe SIEMPRE el servidor (lib/gamification.server.ts).
 */
export const userStats = sqliteTable("user_stats", {
	userId: text("user_id")
		.primaryKey()
		.references(() => users.id, { onDelete: "cascade" }),
	xp: integer("xp").notNull().default(0),
	level: integer("level").notNull().default(0),
	/** Dias seguidos con actividad. Se pierde al saltarse un dia. */
	streakDays: integer("streak_days").notNull().default(0),
	bestStreak: integer("best_streak").notNull().default(0),
	/** YYYY-MM-DD del ultimo dia con actividad */
	lastActivityDate: text("last_activity_date"),
	/** { ganadas: [id], contadores: { find_bug: n, parsons: n, ... } } */
	badgesJson: text("badges_json").notNull().default("{}"),
	updatedAt: integer("updated_at", { mode: "timestamp_ms" })
		.notNull()
		.default(sql`(unixepoch() * 1000)`),
});

/** Ajustes sueltos del profe (por ahora: mostrar u ocultar el ranking). */
export const settings = sqliteTable("settings", {
	key: text("key").primaryKey(),
	value: text("value").notNull().default(""),
});

/* -------------------------------------------------------------------------- */
/*  MODO CODIGO                                                                */
/* -------------------------------------------------------------------------- */

/** Cada vez que un estudiante corre su codigo contra los tests de un ejercicio. */
export const codeRuns = sqliteTable(
	"code_runs",
	{
		id: integer("id").primaryKey({ autoIncrement: true }),
		userId: text("user_id")
			.notNull()
			.references(() => users.id, { onDelete: "cascade" }),
		exerciseId: integer("exercise_id").references(() => exercises.id, {
			onDelete: "set null",
		}),
		code: text("code").notNull(),
		/** true solo si TODOS los tests pasaron */
		passed: integer("passed", { mode: "boolean" }).notNull().default(false),
		resultsJson: text("results_json").notNull().default("[]"),
		createdAt: integer("created_at", { mode: "timestamp_ms" })
			.notNull()
			.default(sql`(unixepoch() * 1000)`),
	},
	(t) => [index("code_runs_user_idx").on(t.userId, t.createdAt)],
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
export type BankQuestion = typeof questionBank.$inferSelect;
export type PracticeAttempt = typeof practiceAttempts.$inferSelect;
export type UserStats = typeof userStats.$inferSelect;
export type CodeRun = typeof codeRuns.$inferSelect;

/** Tipos de pregunta soportados por el banco. */
export const TIPOS_PREGUNTA = [
	"mcq",
	"predict_output",
	"find_bug",
	"parsons",
] as const;
export type TipoPregunta = (typeof TIPOS_PREGUNTA)[number];

export const DIFICULTADES = ["facil", "medio", "dificil"] as const;
export type Dificultad = (typeof DIFICULTADES)[number];
