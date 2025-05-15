-- Ryan Bernal

-- a) Create a database file called alum.db and open it in SQLite if it's not already opened.
-- sqlite3 alum.db


-- b) Use SQLite to create the schema for AlumProject. Your schema should designate the primary key, and and enforce existence and uniqueness of the primary key values. Do not use unneccesary keywords.
CREATE TABLE AlumProject ("ID" INTEGER NOT NULL,
			 "prjName" TEXT NOT NULL,
			 "budget" REAL NOT NULL,
			 UNIQUE (ID, prjName),
			 PRIMARY KEY (ID) );

-- c) Populate the empty table you created in the previous part with the tuples you see. You must use a single SQL command to do this.
INSERT INTO "AlumProject"
	("ID", "prjName", "budget")
	VALUES
	(1, 'Cybercab', 26.1),
	(2, 'Metaverse', 42.7),
	(3, 'Windows12', 16.5);
SELECT * FROM "AlumProject";

-- d) Attempt to insert into AlumProject a tuple for a project of your choice and a budget that lacks an ID. Do you see an error? If you see an error, wwrite down what the error was. If not, explain why there was no error.
INSERT INTO "AlumProject" ("ID", "prjName", "budget") VALUES (NULL, 'Windows13', 7.8);
SELECT * FROM "AlumProject";
-- No error message was displayed. The tuple that I provided still registered into the data even with a NULL "ID" provided. This is due to a feature in SQLite, where if your primary key is a singleton with INTEGER type, SQLite will automatically create a unique primary key value through auto-incrementation.

-- e) Create the schema for Alumnus. Your schema should designate the primary key, and enforce existence and uniqueness of the primary key values. In addition, your schema should specify the fact that the column prjID is a foreign key to ID in the AlumProject table. In addition, to preserve correctness, the database should delete the rows that refer to a deleted project in AlumProject. Do not use unncecessary keywords.
CREATE TABLE Alumnus ("name" TEXT NOT NULL,
		     "ID" INTEGER NOT NULL,
		     "salary" REAL NOT NULL,
			 "prjID" INTEGER,
		     UNIQUE (name, ID),
		     PRIMARY KEY (ID),
		     FOREIGN KEY (prjID) REFERENCES AlumProject(ID) ON DELETE CASCADE
		     );

-- f) Populate the empty table you created in the previous part with the tuples you see. You must use a single SQL command to do this.
INSERT INTO "Alumnus"
	("name", "ID", "salary", "prjID")
	VALUES
	('Becca', 1, 500.0, 2),
	('James', 2, 3000.0, 2),
	('Jill', 3, 4000.0, NULL),
	('Ardy', 4, 1000.0, 3),
	('Elon', 5, 2000.0, 1),
	('Mark', 6, 9900, 2),
	('Bill', 7, 100.0, 3);
SELECT * FROM "Alumnus";

-- g) Attempt to insert into Alumnus your name with ID 8 and a salary of your choice, being employed to work on the project with ID 50. Write the error message you receive as a comment following the insertion command.
-- INSERT INTO "Alumnus" ("name", "ID", "salary", "prjID") VALUES ('Ryan', 8, 0.0, 50);
-- Runtime error: FOREIGN KEY constraint failed (19)

-- h) Re-attempt to insert the tuple into Alumnus, but this time the project ID is 2, but your ID is 1 (instead of 8). Write the error message you receive as a comment following the insertion command.
-- INSERT INTO "Alumnus" ("name", "ID", "salary", "prjID") VALUES ('Ryan', 1, 0.0, 2);
-- Runtime error: UNIQUE constraint failed: Alumnus.ID (19)

-- i) Bill Gates has declared that Microsoft is shutting down the Windows12 project. Write an SQL command that deletes the row from AlumProject.
DELETE FROM "AlumProject" WHERE ID=3;
SELECT * FROM "AlumProject";

-- j) Print all the rows in Alumnus. Follow this command by a comment naming people who no longer exist in the Alumnus table.
SELECT * FROM "Alumnus";
-- After printing out the table, the people Ardy and Bill are no longer apart of the table.
