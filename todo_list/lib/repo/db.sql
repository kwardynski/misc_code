create EXTENSION citext;
create EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS "User" (
    "id" uuid NOT NULL,
    "name" citext NOT NULL,

    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Task" (
    "id" uuid NOT NULL,
    "name" citext not null,
    "date" date not null,
    "userid" uuid NOT NULL,

    PRIMARY KEY ("id"),
    FOREIGN KEY ("userid") REFERENCES "User"("id")
);