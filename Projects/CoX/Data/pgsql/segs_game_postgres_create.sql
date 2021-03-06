CREATE TABLE "table_versions" (
    "id" serial NOT NULL,
    "table_name" varchar NOT NULL UNIQUE,
    "version" integer NOT NULL DEFAULT '0',
    "last_update" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT table_versions_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

INSERT INTO table_versions VALUES(1,'db_version',8,'2018-05-03 17:52:33');
INSERT INTO table_versions VALUES(2,'table_versions',0,'2017-11-11 08:57:42');
INSERT INTO table_versions VALUES(3,'accounts',1,'2018-05-03 14:06:03');
INSERT INTO table_versions VALUES(4,'characters',8,'2018-05-04 14:58:27');
INSERT INTO table_versions VALUES(5,'costume',0,'2017-11-11 08:57:43');
INSERT INTO table_versions VALUES(7,'supergroups',1,'2018-05-03 14:06:43');
INSERT INTO table_versions VALUES(8,'emails',0,'2018-09-23 08:00:00');


CREATE TABLE "accounts" (
    "id" integer NOT NULL,
    "max_slots" integer NOT NULL DEFAULT '8',
    CONSTRAINT accounts_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "costumes" (
    "id" serial NOT NULL,
    "character_id" integer NOT NULL,
    "costume_index" integer NOT NULL,
    "skin_color" integer NOT NULL,
    "parts" bytea NOT NULL,
    CONSTRAINT costumes_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "characters" (
    "id" serial NOT NULL,
    "char_level" integer NOT NULL DEFAULT '1',
    "slot_index" integer NOT NULL DEFAULT '0',
    "account_id" integer NOT NULL DEFAULT '0',
    "char_name" varchar(20) NOT NULL,
    "chardata" bytea NOT NULL,
    "entitydata" bytea NOT NULL,
    "body_type" integer NOT NULL DEFAULT '4',
    "height" real NOT NULL DEFAULT '0.0',
    "physique" real NOT NULL DEFAULT '0.0',
    "supergroup_id" integer NOT NULL DEFAULT '0',
    "player_data" bytea NOT NULL,
    CONSTRAINT characters_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "supergroups" (
    "id" serial NOT NULL,
    "sg_name" varchar(30) NOT NULL,
    "sg_motto" varchar(128) NOT NULL,
    "sg_motd" varchar(1024) NOT NULL,
    "sg_rank_names" bytea NOT NULL,
    "sg_rank_perms" bytea NOT NULL,
    "sg_emblem" bytea NOT NULL,
    "sg_colors" bytea NOT NULL,
    "sg_members" bytea NOT NULL,
    CONSTRAINT supergroups_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE 'emails'(
	`id`	serial NOT NULL,
	`sender_id`	integer NOT NULL,
	`recipient_id` integer NOT NULL,
	`email_data` bytea NOT NULL,
	CONSTRAINT emails_pk PRIMARY KEY ("id")
);




ALTER TABLE "costumes" ADD CONSTRAINT "costumes_fk0" FOREIGN KEY ("character_id") REFERENCES "characters"("id");
ALTER TABLE "emails" ADD CONSTRAINT "emails_fk0" FOREIGN KEY ("sender_id") REFERENCES "characters"("id");
ALTER TABLE "emails" ADD CONSTRAINT "emails_fk1" FOREIGN KEY ("recipient_id") REFERENCES "characters"("id");

ALTER TABLE "characters" ADD CONSTRAINT "characters_fk0" FOREIGN KEY ("account_id") REFERENCES "accounts"("id");
