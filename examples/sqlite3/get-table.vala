public static int main (string[] args) {
	Sqlite.Database db;

	// Open a database:
	int ec = Sqlite.Database.open ("test.db", out db);
	if (ec != Sqlite.OK) {
		stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
		return -1;
	}

	// Required table:
	//	CREATE TABLE User (
	//		id		INT		PRIMARY KEY		NOT NULL,
	//		name	TEXT					NOT NULL
	//	);

	// Example data:
	//  INSERT INTO User (id, name) VALUES (1, 'Hesse');
	//  INSERT INTO User (id, name) VALUES (2, 'Frisch');

	// Insert:
	string errmsg;
	string[] res;
	int nrows;
	int ncols;

	string query = "SELECT * FROM User";
	ec = db.get_table (query, out res, out nrows, out ncols, out errmsg);
	if (ec != Sqlite.OK) {
		stderr.printf ("Error: %s\n", errmsg);
		return -1;
	}

	int max = nrows*ncols + ncols;
	for (int i = 0; i < max; i = i + ncols) {
		for (int x = 0; x < ncols; x++) {
			print (res[i + x]);
			print ("\t");
		}
		print ("\n");
	}


	// Output:
	//  ``id	name	``
	//  ``1		Hesse	``
	//  ``2		Frisch	``

	return 0;
}
