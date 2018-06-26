public static int main (string[] args) {
	Sqlite.Database db;
	string errmsg;

	// Open/Create a database:
	int ec = Sqlite.Database.open ("test.db", out db);
	if (ec != Sqlite.OK) {
		stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
		return -1;
	}


	string query = """
		CREATE TABLE User (
			id		INT		PRIMARY KEY		NOT NULL,
			name	TEXT					NOT NULL
		);
		""";

	// Execute our query:
	ec = db.exec (query, null, out errmsg);
	if (ec != Sqlite.OK) {
		stderr.printf ("Error: %s\n", errmsg);
		return -1;
	}

	print ("Created.\n");

	return 0;
}
