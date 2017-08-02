public static int main (string[] args) {
	string str = """
		{
			"url"  : "http://www.gnome.org/img/flash/two-thirty.png",
			"size" : [ 652, 242 ]
		}""";

	// Load a file:
	Json.Parser parser = new Json.Parser ();
	try {
		parser.load_from_data (str);
	} catch (Error e) {
		print ("Unable to parse data: %s\n", e.message);
		return -1;
	}


	// Create a cursor:
	Json.Node node = parser.get_root ();
	Json.Reader reader = new Json.Reader (node);

	// Read the file:
	// We use assert for format validation to keep the sample small.
	string url = null;
	bool has_size = false;
	int64 width = -1;
	int64 height = -1;

	foreach (string member in reader.list_members ()) {
		switch (member) {
		case "url":
			bool tmp = reader.read_member ("url");
			assert (tmp == true);
			assert (reader.is_value ());

			url = reader.get_string_value ();
			reader.end_member ();
			break;

		case "size":
			bool tmp = reader.read_member ("size");
			assert (tmp == true);
			assert (reader.is_array ());
			assert (reader.count_elements () == 2);
			// Element 0:
			reader.read_element (0);
			assert (reader.is_value ());
			width = reader.get_int_value ();
			reader.end_element ();
			// Element 1:
			reader.read_element (1);
			assert (reader.is_value ());
			height = reader.get_int_value ();
			reader.end_element ();
			reader.end_member ();

			has_size = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	if (has_size == false || url == null) {
		assert_not_reached ();
	}

	// Print the data:
	print ("url:    %s\n", url);
	print ("width:  %" + int64.FORMAT + "\n", width);
	print ("height: %" + int64.FORMAT + "\n", height);

	return 0;
}
