CREATE TABLE "users"(
    "id" SERIAL PRIMARY KEY,
    "username" VARCHAR(25) UNIQUE NOT NULL,
    "login" TIMESTAMP,
    CONSTRAINT "have_username" CHECK (LENGTH(TRIM("username")) > 0)
);
CREATE INDEX username_index ON "users"("username");

CREATE TABLE "topics"(
    "id" SERIAL PRIMARY KEY,
    "topic_name" VARCHAR(30) UNIQUE NOT NULL,
    "description" VARCHAR(500),
    CONSTRAINT "erase whitespaces" CHECK(LENGTH(TRIM("topic_name"))> 0)
);
CREATE INDEX find_topics ON "topics" (LOWER("topic_name") VARCHAR_PATTERN_OPS);

CREATE TABLE "posts"(
    "id" SERIAL PRIMARY KEY,
    "title" VARCHAR(100) UNIQUE NOT NULL,
    "url" VARCHAR (500),
    "post_created" TIMESTAMP,
    "text_content" TEXT,
    "topic_id" INTEGER REFERENCES "topics" ON DELETE CASCADE,
    "user_id" INTEGER REFERENCES "users" ON DELETE SET NULL,
    CONSTRAINT "has_title" CHECK(LENGTH(TRIM("title"))>0),
    CONSTRAINT "url_text" CHECK (("url" IS NULL AND "text_content" IS NOT NULL) 
    OR ("url" IS NOT NULL AND "text_content" IS NULL))

);
