BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "customers" ADD COLUMN "notes" text;

--
-- MIGRATION VERSION FOR pingulab_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pingulab_app', '20251230022514211', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251230022514211', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
