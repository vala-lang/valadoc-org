private static int exec_callback (int n_columns, string[] values, string[] column_names) {
	for (int i = 0; i < n_columns; i++) {
		print ("%s: %s\n", column_names[i], values[i]);
	}
	return 0;
}

private static void sqlite_func_my_strlen (Sqlite.Context context, Sqlite.Value[] values) {
	// Parameter validation:
	assert (values.length == 1); // checked by sqlight

	if (values[0].to_type () != Sqlite.TEXT) {
		context.result_error ("Unexpected parameter type", Sqlite.MISMATCH);
		return ;
	}

	// Get the parameter:
	string text = values[0].to_text ();

	// Store the return value:
	context.result_int (text.length);
}

public static int main (string[] args) {
	Sqlite.Database db;
	string errmsg;

	// Open/Create a database:
	int ec = Sqlite.Database.open ("test.db", out db);
	if (ec != Sqlite.OK) {
		stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
		return -1;
	}


	// Register a function:
	db.create_function ("my_strlen", 1, Sqlite.UTF8, null, sqlite_func_my_strlen, null, null);


	// Call our function:
	string query = "SELECT my_strlen ('Hello, world!');";
	ec = db.exec (query, exec_callback, out errmsg);
	if (ec != Sqlite.OK) {
		stderr.printf ("Error: %s\n", errmsg);
		return -1;
	}

	// Output: (see exec_callback)
	//  ``my_strlen ('Hello, world'): 13``

	return 0;
}
