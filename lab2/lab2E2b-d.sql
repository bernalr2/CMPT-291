-- Ryan Bernal

-- b) Write an appropraite Schema for a table named picnicTab that can hold the data.
-- sqlite3 picnic.db
-- .open picnic.db

CREATE TABLE "picnicTab" ("ID" INTEGER,
			 "tableType" TEXT,
		     "surfMaterial" TEXT,
			 "structMaterial" TEXT,
			 "sTaV" TEXT,
			 "neighID" INTEGER,
			 "neighName" TEXT
			 "Ward" BLOB,
			 "Latitude" REAL,
			 "Longitude" REAL,
			 "Location" BLOB,
			 "geoPoint" BLOB);


-- c) 	Use the .mode command to switch into CSV. Then import all but the header tuple into picnicTab.

-- .mode csv
-- .import --skip 1 Public_Picnic_Table_Locations.csv picnicTab
-- SELECT * FROM "picnicTab";

-- d) Do you think this is a good design choice? Why/why not? List as many as you can.

-- I believe this is a great design choice. My reasons are:
-- Easier to input large sums of data instead of the User typing out one large command to insert everything
-- Flexible with Data Entry types, where you can choose the data entry type to be formatted in each column 
-- You are able to test in the terminal instead of having to exit out of the file, compile file, and run file like you have to do with C
-- More options to test and check the database while being more efficient like being able to use SQL commands as well as the SQLite3 commands
