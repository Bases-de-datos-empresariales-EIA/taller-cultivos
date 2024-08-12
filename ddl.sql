-- DROP SCHEMA cultivo;

CREATE SCHEMA cultivo AUTHORIZATION postgres;

-- DROP TYPE cultivo."Enum_RoleName";

CREATE TYPE cultivo."Enum_RoleName" AS ENUM (
	'ADMIN',
	'USER');
-- cultivo."Invoice" definition

-- Drop table

-- DROP TABLE cultivo."Invoice";

CREATE TABLE cultivo."Invoice" (
	id text NOT NULL,
	"date" timestamp(3) NULL,
	"invoiceNumber" text NULL,
	kg float8 NULL,
	price float8 NULL,
	"grossTotal" float8 NULL,
	tax float8 NULL,
	deduction float8 NULL,
	"netTotal" float8 NULL,
	"createdAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"isNulled" bool NOT NULL,
	"updatedAt" timestamp(3) NOT NULL,
	"salesDeduction" float8 NULL,
	"finalValue" float8 NULL,
	CONSTRAINT "Invoice_pkey" PRIMARY KEY (id)
);


-- cultivo."Lot" definition

-- Drop table

-- DROP TABLE cultivo."Lot";

CREATE TABLE cultivo."Lot" (
	id text NOT NULL,
	"name" text NOT NULL,
	"createdAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updatedAt" timestamp(3) NOT NULL,
	CONSTRAINT "Lot_pkey" PRIMARY KEY (id)
);
CREATE UNIQUE INDEX "Lot_name_key" ON cultivo."Lot" USING btree (name);


-- cultivo."Role" definition

-- Drop table

-- DROP TABLE cultivo."Role";

CREATE TABLE cultivo."Role" (
	id text NOT NULL,
	"name" cultivo."Enum_RoleName" NOT NULL,
	"createdAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updatedAt" timestamp(3) NOT NULL,
	CONSTRAINT "Role_pkey" PRIMARY KEY (id)
);
CREATE UNIQUE INDEX "Role_name_key" ON cultivo."Role" USING btree (name);


-- cultivo."TMP_Collection" definition

-- Drop table

-- DROP TABLE cultivo."TMP_Collection";

CREATE TABLE cultivo."TMP_Collection" (
	id text NULL,
	bunches int4 NULL,
	"collectionDate" timestamp(3) NULL,
	lot text NULL,
	"userId" text NULL,
	"shipmentId" text NULL,
	"createdAt" timestamp(3) NULL,
	"updatedAt" timestamp(3) NULL
);


-- cultivo."VerificationToken" definition

-- Drop table

-- DROP TABLE cultivo."VerificationToken";

CREATE TABLE cultivo."VerificationToken" (
	identifier text NOT NULL,
	"token" text NOT NULL,
	expires timestamp(3) NOT NULL
);
CREATE UNIQUE INDEX "VerificationToken_identifier_token_key" ON cultivo."VerificationToken" USING btree (identifier, token);
CREATE UNIQUE INDEX "VerificationToken_token_key" ON cultivo."VerificationToken" USING btree (token);


-- cultivo."_prisma_migrations" definition

-- Drop table

-- DROP TABLE cultivo."_prisma_migrations";

CREATE TABLE cultivo."_prisma_migrations" (
	id varchar(36) NOT NULL,
	checksum varchar(64) NOT NULL,
	finished_at timestamptz NULL,
	migration_name varchar(255) NOT NULL,
	logs text NULL,
	rolled_back_at timestamptz NULL,
	started_at timestamptz DEFAULT now() NOT NULL,
	applied_steps_count int4 DEFAULT 0 NOT NULL,
	CONSTRAINT "_prisma_migrations_pkey" PRIMARY KEY (id)
);


-- cultivo."User" definition

-- Drop table

-- DROP TABLE cultivo."User";

CREATE TABLE cultivo."User" (
	id text NOT NULL,
	"name" text NULL,
	email text NULL,
	"emailVerified" timestamp(3) NULL,
	image text NULL,
	"roleId" text NULL,
	CONSTRAINT "User_pkey" PRIMARY KEY (id),
	CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES cultivo."Role"(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "User_email_key" ON cultivo."User" USING btree (email);


-- cultivo."Account" definition

-- Drop table

-- DROP TABLE cultivo."Account";

CREATE TABLE cultivo."Account" (
	id text NOT NULL,
	"userId" text NOT NULL,
	"type" text NOT NULL,
	provider text NOT NULL,
	"providerAccountId" text NOT NULL,
	refresh_token text NULL,
	access_token text NULL,
	expires_at int4 NULL,
	token_type text NULL,
	"scope" text NULL,
	id_token text NULL,
	session_state text NULL,
	CONSTRAINT "Account_pkey" PRIMARY KEY (id),
	CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES cultivo."User"(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON cultivo."Account" USING btree (provider, "providerAccountId");


-- cultivo."Profile" definition

-- Drop table

-- DROP TABLE cultivo."Profile";

CREATE TABLE cultivo."Profile" (
	id text NOT NULL,
	"document" text NULL,
	"phoneNumber" text NULL,
	image text NULL,
	"userId" text NOT NULL,
	"createdAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updatedAt" timestamp(3) NOT NULL,
	CONSTRAINT "Profile_pkey" PRIMARY KEY (id),
	CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES cultivo."User"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "Profile_document_key" ON cultivo."Profile" USING btree (document);
CREATE UNIQUE INDEX "Profile_userId_key" ON cultivo."Profile" USING btree ("userId");


-- cultivo."Session" definition

-- Drop table

-- DROP TABLE cultivo."Session";

CREATE TABLE cultivo."Session" (
	id text NOT NULL,
	"sessionToken" text NOT NULL,
	"userId" text NOT NULL,
	expires timestamp(3) NOT NULL,
	CONSTRAINT "Session_pkey" PRIMARY KEY (id),
	CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES cultivo."User"(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "Session_sessionToken_key" ON cultivo."Session" USING btree ("sessionToken");


-- cultivo."Shipment" definition

-- Drop table

-- DROP TABLE cultivo."Shipment";

CREATE TABLE cultivo."Shipment" (
	id text NOT NULL,
	"shippedBunches" int4 NOT NULL,
	"shipmentDate" timestamp(3) NULL,
	"bunchWeight" float8 NULL,
	"deliveredWeight" float8 NULL,
	"userId" text NOT NULL,
	"createdAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updatedAt" timestamp(3) NOT NULL,
	"shipmentCode" text NOT NULL,
	CONSTRAINT "Shipment_pkey" PRIMARY KEY (id),
	CONSTRAINT "Shipment_userId_fkey" FOREIGN KEY ("userId") REFERENCES cultivo."User"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "Shipment_shipmentCode_key" ON cultivo."Shipment" USING btree ("shipmentCode");


-- cultivo."Collection" definition

-- Drop table

-- DROP TABLE cultivo."Collection";

CREATE TABLE cultivo."Collection" (
	id text NOT NULL,
	bunches int4 NOT NULL,
	"collectionDate" timestamp(3) NOT NULL,
	"lotId" text NOT NULL,
	"userId" text NOT NULL,
	"shipmentId" text NULL,
	"createdAt" timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updatedAt" timestamp(3) NOT NULL,
	CONSTRAINT "Collection_pkey" PRIMARY KEY (id),
	CONSTRAINT "Collection_lotId_fkey" FOREIGN KEY ("lotId") REFERENCES cultivo."Lot"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT "Collection_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES cultivo."Shipment"(id) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT "Collection_userId_fkey" FOREIGN KEY ("userId") REFERENCES cultivo."User"(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "Collection_collectionDate_lotId_key" ON cultivo."Collection" USING btree ("collectionDate", "lotId");