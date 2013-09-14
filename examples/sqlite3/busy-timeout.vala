public static int main (string[] args) {
	Sqlite.Database db;

	// Open/Create a database:
	int ec = Sqlite.Database.open ("test.db", out db);
	if (ec != Sqlite.OK) {
		stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
		return -1;
	}

	// Set timeout to 5 seconds:
	db.busy_timeout (5000);

	// Turns off all busy handlers:
	db.busy_timeout (0);
	return 0;
}
