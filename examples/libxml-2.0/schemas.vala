public static int main (string[] args) {
	// The document:
	Xml.Doc* doc = Xml.Parser.parse_file ("books.xml");
	if (doc == null) {
		stdout.printf ("File 'books.xml' not found or permissions missing\n");
		return 0;
	}

	// The schema:
	Xml.SchemaParserCtxt schema_parser = new Xml.SchemaParserCtxt ("books.xsd");
	Xml.Schema schema = schema_parser.parse ();
	if (schema == null) {
		stdout.puts ("Invalid/missing schema\n");
		return 0;
	}

	Xml.SchemaValidCtxt valctxt = new Xml.SchemaValidCtxt (schema);
	if (valctxt == null) {
		stdout.puts ("Unable to create a validation context\n");
		return 0;
	}


	// Validation:
	int is_valid = valctxt.validate_doc (doc);
	if (is_valid == 0) {
		stdout.puts ("valid\n");
	} else {
		stdout.puts ("invalid\n");
	}

	return 0;
}
