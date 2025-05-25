-- Ryan Bernal

-- 0) Create the appropriate schema for the above tables and insert the relevant tuples in each.
CREATE TABLE "M" ("mID" INTEGER NOT NULL,
		  "mName" TEXT NOT NULL,
		  "mState" TEXT NOT NULL,
		  "mCountry" TEXT NOT NULL,
		   UNIQUE ("mName"),
		   PRIMARY KEY ("mID"));

INSERT INTO "I"
	("mID", "mName", "mState", "mCountry")
	VALUES
	(001, 'Sonia', 'AB', 'Canada'),
	(002, 'Mikana', 'AB', 'Canada'),
	(003, 'Ree', 'CL', 'USA'),
	(004, 'Zox', 'NY', 'USA');

CREATE TABLE "D" ("dID" INTEGER NOT NULL,
		  "dName" TEXT NOT NULL,
		  "dState" TEXT NOT NULL,
		  "dCountry" TEXT NOT NULL,
		   UNIQUE ("dName"),
		   PRIMARY KEY ("dID"));

INSERT INTO "D"
	("dID", "dName", "dState", "dCountry")
	VALUES
	(001, 'Global', 'AB', 'Canada'),
	(002, 'REX', 'ON', 'Canada'),
	(003, 'Zee', 'NY', 'USA'),
	(004, 'FEE', 'NJ', 'USA'),
	(005, 'Known', 'AB', 'Canada');

CREATE TABLE "I" ("iID" INTEGER NOT NULL,
		  "desc" TEXT NOT NULL,
		  "color" TEXT NOT NULL,
		  "weight" INTEGER NOT NULL,
		  "price" INTEGER NOT NULL,
		  "qty" INTEGER NOT NULL,
		  "mID" INTEGER NOT NULL,
		  "dID" INTEGER NOT NULL,
		   PRIMARY KEY ("iID"),
		   FOREIGN KEY ("mID") REFERENCES M("mID") ON DELETE RESTRICT,
		   FOREIGN KEY ("dID") REFERENCES D("dID") ON DELETE RESTRICT);

INSERT INTO "I"
	("iID", "desc", "color", "weight", "price", "qty", "mID", "dID")
	VALUES
	(001, 'Chair', 'Brown', 25, 20, 100, 001, 001),
	(002, 'Table', 'Green', 100, 25, 50, 001, 002),
	(003, 'Book', 'Green', 10, 5, 300, 003, 001),
	(004, 'Screen', 'Silver', 75, 30, 50, 004, 003),
	(005, 'Printer', 'White', 20, 10, 200, 002, 004),
	(006, 'Door', 'Green', 200, 40, 2, 004, 001);

-- 1) Find all items in Green Color
SELECT * FROM "I" WHERE "color"='Green';

-- 2) Find all items with Green Color and the price is less than 10.
SELECT * FROM "I" WHERE "color"='Green' AND "price"<10;

-- 3) Find the name of all distributors from the USA.
SELECT "dName" FROM "D" WHERE "dCountry"='USA';

-- 4) Find the Desc. of items with Qty more than 60.
SELECT "desc" FROM "I" WHERE "qty">60;

-- 5) Find names of manufacturers from AB.
SELECT "mName" FROM "M" WHERE "mState"='AB';

-- 6) Find all manufacturers' names from the USA who made items with Brown color
SELECT "mName" FROM "I", "M"
WHERE I.mID=M.mID AND "mCountry"='USA' AND "color"='Brown';

-- 7) Find the description of all items manufactured in the USA and is made of Brown Color
SELECT "desc" FROM "I", "M" 
WHERE I.mID=M.mID AND "mCountry"='USA' AND "color"='Brown';

-- 8) Find the description of all items manufactured in the USA and distributed by a Canadian company.
SELECT "desc" FROM "I", "M", "D" 
WHERE I.mID=M.mID AND I.dID=D.dID AND "mCountry"='USA' AND "dCountry"='Canada';

-- 9) Find Desc of all items manufactured and distributed in Canada
SELECT "desc" FROM "I", "M", "D" 
WHERE I.mID=M.mID AND I.dID=D.dID AND "mCountry"='Canada' AND "dCountry"='Canada';

-- 10) Find Desc of items manufactured and distributed in the same country
SELECT "desc" FROM "I", "M", "D" 
WHERE I.mID=M.mID AND I.dID=D.dID AND mCountry=dCountry;

-- 11) Find Desc of items manufactured and distributed in different countries
SELECT "desc" FROM "I", "M", "D" 
WHERE I.mID=M.mID AND I.dID=D.dID AND mCountry!=dCountry;

-- 12) Find a color that is only manufactured in Canada 
SELECT "color" FROM "I", "M" 
WHERE I.mID=M.mID AND "mCountry"='Canada' AND "color"
NOT IN (SELECT "color" FROM "I", "M" WHERE I.mID=M.mID AND "mCountry"='USA');

-- 13) Find Colors that are manufactured in both the USA and Canada
SELECT "color" FROM "I", "M" 
WHERE I.mID=M.mID AND "mCountry"='Canada' AND "color"
IN (SELECT "color" FROM "I", "M" WHERE I.mID=M.mID AND "mCountry"='USA');

-- 14) Find the name of the distributor who never distributed any item
SELECT "dName" FROM "D" 
WHERE "dName"
NOT IN (SELECT "dName" FROM "I", "D" WHERE I.dID=D.dID);

-- 15) Find the total number of items each State/Province Manufactured
SELECT "mState", SUM("qty") AS "totalMS" 
FROM "I", "M" WHERE I.mID=M.mID 
GROUP BY "mState";

-- 16) Find the total number of items each country distributed
SELECT "dCountry", SUM("qty") AS "totalDC" 
FROM "I", "D" WHERE I.dID=D.dID 
GROUP BY "dCountry";

-- 17) Find the name of state/provinces that distributed more than 500 items
SELECT "dState", SUM("qty") AS "totalDS" 
FROM "I", "D" WHERE I.dID=D.dID 
GROUP BY "dCountry" 
HAVING SUM("qty") > 500;