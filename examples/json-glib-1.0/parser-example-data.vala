public errordomain MyError {
	INVALID_FORMAT
}

public static void process_role (Json.Node node, uint number) throws Error {
	if (node.get_node_type () != Json.NodeType.OBJECT) {
		throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
	}

	// TODO, type check ...
	unowned Json.Object obj = node.get_object ();
	unowned string first = null;
	unowned string last = null;

	foreach (unowned string name in obj.get_members ()) {
		switch (name) {
		case "firstName":
			unowned Json.Node item = obj.get_member (name);
			if (item.get_node_type () != Json.NodeType.VALUE) {
				throw new MyError.INVALID_FORMAT ("Unexpected element type %s", item.type_name ());
			}

			first = obj.get_string_member ("firstName");
			break;

		case "lastName":
			unowned Json.Node item = obj.get_member (name);
			if (item.get_node_type () != Json.NodeType.VALUE) {
				throw new MyError.INVALID_FORMAT ("Unexpected element type %s", item.type_name ());
			}

			last = obj.get_string_member ("lastName");
			break;

		default:
			throw new MyError.INVALID_FORMAT ("Unexpected element '%s'", name);
		}
	}
	
	if (first == null || last == null) {
		throw new MyError.INVALID_FORMAT ("Expected: firstName, lastName");
	}

	print ("\t%s %s\n", first, last);
}

public static void process_role_array (Json.Node node) throws Error {
	if (node.get_node_type () != Json.NodeType.ARRAY) {
		throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
	}

	unowned Json.Array array = node.get_array ();
	int i = 1;

	foreach (unowned Json.Node item in array.get_elements ()) {
		process_role (item, i);
		i++;
	}
}

public static void process_good (Json.Node node) throws Error {
	print ("Good:\n");
	process_role_array (node);
}

public static void process_bad (Json.Node node) throws Error {
	print ("Bad:\n");
	process_role_array (node);
}

public static void process (Json.Node node) throws Error {
	if (node.get_node_type () != Json.NodeType.OBJECT) {
		throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
	}

	unowned Json.Object obj = node.get_object ();

	foreach (unowned string name in obj.get_members ()) {
		switch (name) {
		case "good":
			unowned Json.Node item = obj.get_member (name);
			process_good (item);
			break;

		case "bad":
			unowned Json.Node item = obj.get_member (name);
			process_bad (item);
			break;

		default:
			throw new MyError.INVALID_FORMAT ("Unexpected element '%s'", name);
		}
	}
}

public static int main (string[] args) {
	// Json: (Array: [], Object: {})
	string data =
		"""
		{
			"good" : [
				{ "firstName" : "Marty",
				  "lastName"  : "McFly" },

				{ "firstName" : "Emmett",
				  "lastName"  : "Brown" }
			],
			"bad" : [
				{ "firstName" : "Biff",
				  "lastName"  : "Green" }
			]
		}
		""";

	// Parse:
	Json.Parser parser = new Json.Parser ();
	try {
		parser.load_from_data (data);

		// Get the root node:
		Json.Node node = parser.get_root ();

		// Process (print) the file:
		process (node);
	} catch (Error e) {
		print ("Unable to parse the string: %s\n", e.message);
		return -1;
	}
	return 0;
}
