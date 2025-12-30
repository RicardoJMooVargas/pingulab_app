BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "customers" (
    "id" bigserial PRIMARY KEY,
    "apodo" text NOT NULL,
    "nombre" text,
    "apellido" text,
    "numero" text,
    "direccion" text,
    "created" timestamp without time zone NOT NULL,
    "updated" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "quotes" ADD COLUMN "customerId" bigint;

--
-- MIGRATION VERSION FOR pingulab_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pingulab_app', '20251230021928230', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251230021928230', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
