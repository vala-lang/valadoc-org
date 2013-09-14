public static int main (string[] args) {
	Sqlite.Database db;

	// Open/Create a database:
	int ec = Sqlite.Database.open_v2 ("test.db", out db, Sqlite.OPEN_READONLY);
	if (ec != Sqlite.OK) {
		stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
		return -1;
	}

	return 0;
}
