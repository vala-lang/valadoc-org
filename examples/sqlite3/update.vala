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

	// Required data:
	//  INSERT INTO User (id, name) VALUES (1, 'Hesse');
	//  INSERT INTO User (id, name) VALUES (2, 'Frisch');


	// Delete "Frisch" via id:
	string query = "UPDATE User SET name = 'Hermann' WHERE id = 1;";
	ec = db.exec (query, null, out errmsg);
	if (ec != Sqlite.OK) {
		stderr.printf ("Error: %s\n", errmsg);
		return -1;
	}

	int changes = db.total_changes ();
	print ("Affected rows: %d\n", changes);

	return 0;
}
