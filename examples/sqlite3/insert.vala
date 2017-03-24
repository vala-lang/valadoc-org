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


	// Insert: (See Sqlite.Database.prepare)
	string query = """
		INSERT INTO User (id, name) VALUES (1, 'Hesse');
		INSERT INTO User (id, name) VALUES (2, 'Frisch');
		""";
	ec = db.exec (query, null, out errmsg);
	if (ec != Sqlite.OK) {
		stderr.printf ("Error: %s\n", errmsg);
		return -1;
	}

	int64 last_id = db.last_insert_rowid ();
	print ("Last inserted id: %" + int64.FORMAT + "\n", last_id);

	return 0;
}
