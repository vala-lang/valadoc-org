private static int exec_callback (int n_columns, string[] values, string[] column_names) {
	for (int i = 0; i < n_columns; i++) {
		print ("%s: %s\n", column_names[i], values[i]);
	}
	return 0;
}

public static int main (string[] args) {
	Sqlite.Database db;
	string errmsg;

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
	string query = "SELECT * FROM User";
	ec = db.exec (query, exec_callback, out errmsg);
	if (ec != Sqlite.OK) {
		stderr.printf ("Error: %s\n", errmsg);
		return -1;
	}

	// Outpu: (see exec_callback)
	//  ``id: 1``
	//  ``name: Hesse``
	//  ``id: 2``
	//  ``name: Frisch``

	return 0;
}
