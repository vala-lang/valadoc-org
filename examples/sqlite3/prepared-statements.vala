public static int main (string[] args) {
	Sqlite.Database db;
	string errmsg;

	// Open a database:
	int ec = Sqlite.Database.open ("test.db", out db);
	if (ec != Sqlite.OK) {
		stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
		return -1;
	}

	// Insert test data:
	string query = """
		CREATE TABLE User (
			id		INT		PRIMARY KEY		NOT NULL,
			name	TEXT					NOT NULL
		);

		INSERT INTO User (id, name) VALUES (1, 'Hesse');
		INSERT INTO User (id, name) VALUES (2, 'Frisch');
		""";
	ec = db.exec (query, null, out errmsg);
	if (ec != Sqlite.OK) {
		stderr.printf ("Error: %s\n", errmsg);
		return -1;
	}

	//
	// Create a prepared statement:
	// (db.prepare shouldn't be used anymore)
	//

	Sqlite.Statement stmt;

	const string prepared_query_str = "SELECT * FROM User WHERE id = $UID;";
	ec = db.prepare_v2 (prepared_query_str, prepared_query_str.length, out stmt);
	if (ec != Sqlite.OK) {
		stderr.printf ("Error: %d: %s\n", db.errcode (), db.errmsg ());
		return -1;
	}

	//
	// Use the prepared statement:
	//

	int param_position = stmt.bind_parameter_index ("$UID");
	assert (param_position > 0);

	stmt.bind_int (param_position, 1);


	int cols = stmt.column_count ();
	while (stmt.step () == Sqlite.ROW) {
		for (int i = 0; i < cols; i++) {
			string col_name = stmt.column_name (i) ?? "<none>";
			string val = stmt.column_text (i) ?? "<none>";
			int type_id = stmt.column_type (i);

			print ("column: %s\n", col_name);
			print ("value: %s\n", val);
			print ("type: %d\n", type_id);
		}
	}

	// Output:
	//  ``column: id``
	//  ``value: 1``
	//  ``type: 1``
	//  ``column: name``
	//  ``value: Hesse``
	//  ``type: 3``


	// Reset the statement to rebind parameters:
	stmt.reset ();

	// ...

	return 0;
}
