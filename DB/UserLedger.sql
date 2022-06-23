CREATE TABLE "public.Account" (
	"AccountID" integer NOT NULL,
	"AccountTypeID" VARCHAR(255) NOT NULL,
	"AccountNumber" integer NOT NULL,
	"UserID" integer NOT NULL,
	"Balance" DECIMAL NOT NULL DEFAULT '0',
	CONSTRAINT "Account_pk" PRIMARY KEY ("AccountID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.AccountType" (
	"AccountTypeID" integer NOT NULL,
	"AcountType" VARCHAR(255) NOT NULL DEFAULT 'Share',
	CONSTRAINT "AccountType_pk" PRIMARY KEY ("AccountTypeID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.User" (
	"UserID" serial NOT NULL,
	"FID" serial NOT NULL UNIQUE,
	"PrimarySID" VARCHAR(255) NOT NULL,
	CONSTRAINT "User_pk" PRIMARY KEY ("UserID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Transaction" (
	"TransactionID" serial NOT NULL,
	"AccountID" integer NOT NULL,
	"BalanceEffect" DECIMAL NOT NULL,
	"ProductID" integer NOT NULL,
	CONSTRAINT "Transaction_pk" PRIMARY KEY ("TransactionID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Product" (
	"ProductID" integer NOT NULL,
	"ProductName" TEXT NOT NULL,
	CONSTRAINT "Product_pk" PRIMARY KEY ("ProductID")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "Account" ADD CONSTRAINT "Account_fk0" FOREIGN KEY ("AccountTypeID") REFERENCES "AccountType"("AccountTypeID");
ALTER TABLE "Account" ADD CONSTRAINT "Account_fk1" FOREIGN KEY ("UserID") REFERENCES "User"("UserID");



ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_fk0" FOREIGN KEY ("AccountID") REFERENCES "Account"("AccountID");
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_fk1" FOREIGN KEY ("ProductID") REFERENCES "Product"("ProductID");






