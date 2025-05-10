-- Ryan Bernal

-- h) Use SQL to write a schema for Enrollment. Your schema should specify the integriy constraint that neither of the attributes can be absent for any given tuple.

CREATE TABLE "Enrollment" ("sID" INTEGER NOT NULL,
                          "cID" TEXT NOT NULL);

-- i) Write one SQL command that inserts all of the tuples into the empty table you created in the previous part
INSERT INTO "Enrollment"
	("sID", "cID")
	VALUES
	(23929340, 'BIOL101'),
	(23929340, 'PHIL101'),
	(23929340, 'MATH101'),
	(23929340, 'CHEM102'),
	(21921015, 'MATH101'),
	(21921015, 'CHEM102'),
	(21921015, 'PHIL102'),
	(01028190, 'MATH307');

-- j) Write an SQL command that prints the table Enrollment.
SELECT * FROM "Enrollment";

-- k) Attempt to insert the tuple (123456, NULL) and write the error message you see.
INSERT INTO "Enrollment"
	("sID", "cID")
	VALUES
	(123456, NULL);-- h) Use SQL to write a schema for Enrollment. Your schema should specify the integriy constraint that neither of the attributes can be absent for any given tuple.

CREATE TABLE "Enrollment" ("sID" INTEGER NOT NULL,
                          "cID" TEXT NOT NULL);

-- i) Write one SQL command that inserts all of the tuples into the empty table you created in the previous part
INSERT INTO "Enrollment"
	("sID", "cID")
	VALUES
	(23929340, 'BIOL101')
	(23929340, 'PHIL101')
	(23929340, 'MATH101')
	(23929340, 'CHEM102')
	(21921015, 'MATH101')
	(21921015, 'CHEM102')
	(21921015, 'PHIL102')
	(01028190, 'MATH307');

-- j) Write an SQL command that prints the table Enrollment.
SELECT * FROM "Enrollment";

-- k) Attempt to insert the tuple (123456, NULL) and write the error message you see.
INSERT INTO "Enrollment"
	("sID", "cID")
	VALUES
	(123456, NULL);
-- NOT NULL constraint failed: Enrollment.cID

-- l) Write an SQL command that deletes the table Enrollment.
DROP TABLE "Enrollment";
