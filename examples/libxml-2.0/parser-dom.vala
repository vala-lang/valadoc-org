public static void print_simple (Xml.Node* node, string node_name) {
	assert (node->name == node_name);

	for (Xml.Node* iter = node->children; iter != null; iter = iter->next) {
		if (iter->type == Xml.ElementType.TEXT_NODE) {
			stdout.printf ("   - %s\n", iter->get_content ());
		} else {
			stdout.printf ("Unexpected element %s\n", iter->name);
		}
	}

}

public static void print_book (Xml.Node* node) {
	assert (node->name == "book");

	stdout.puts (" * Book:\n");

	string? id = node->get_prop ("id");
	if (id != null) {
		stdout.printf ("   - %s\n", id);
	} else {
		stdout.puts ("Expected: <book id=...\n");
	}

	for (Xml.Node* iter = node->children; iter != null; iter = iter->next) {
		if (iter->type == Xml.ElementType.ELEMENT_NODE) {
			switch (iter->name) {
			case "title":
				print_simple (iter, "title");
				break;

			case "author":
				print_simple (iter, "author");
				break;

			default:
				stdout.printf ("Unexpected element %s\n", iter->name);
				break;
			}
		}
	}
}

public static void print_books (Xml.Node* node) {
	assert (node->name == "books");

	stdout.puts ("Books:\n");
	for (Xml.Node* iter = node->children; iter != null; iter = iter->next) {
		if (iter->type == Xml.ElementType.ELEMENT_NODE) {
			if (iter->name == "book") {
				print_book (iter);
			} else {
				stdout.printf ("Unexpected element %s\n", iter->name);
			}
		}
	}
}

public static int main (string[] args) {
	// Parse the document from path
	Xml.Doc* doc = Xml.Parser.parse_file ("books.xml");
	if (doc == null) {
		stdout.printf ("File 'books.xml' not found or permissions missing\n");
		return 0;
	}

	Xml.Node* root = doc->get_root_element ();
	if (root == null) {
		stdout.printf ("WANTED! root\n");
		delete doc;
		return 0;
	}

	if (root->name == "books") {
		print_books (root);
	} else {
		stdout.printf ("Unexpected element %s\n", root->name);
	}

	delete doc;
	return 0;
}
