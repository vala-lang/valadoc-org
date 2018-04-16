public string generate_attrs_output (HashTable<string, string> attrs) {
	StringBuilder builder = new StringBuilder ();
	builder.append ("{ ");

	builder.append ("}");
	attrs.foreach ((key, value) => {
		builder.append (key);
		builder.append_c (':');
		builder.append (value);
	});

	return (owned) builder.str;
}

void xml_node_output (Rest.XmlNode node, int depth) {
	do {
		// node.attrs is bound as <void*, void*> (Wed Aug 28, 2013)
		string attrs_output = generate_attrs_output ((HashTable<string, string>) node.attrs);
		print ("%*s[%s, %s, %s]\n",
			depth, "", node.name, (node.content != null)? node.content : "NULL",
			attrs_output);

		// Bound as <void*, void*>  (Wed Aug 28, 2013)
		((HashTable<string, Rest.XmlNode>) node.children).foreach ((name, child) => {
			print ("%*s%s - >\n", depth, "", child.name);
			xml_node_output (child, depth + 4);
		});
	} while ((node = node.next) != null);
}

public static int main (string[] args) {
	if (args.length != 2) {
		stderr.puts ("$ dump-xml <FILENAME>\n");
		return 1;
	}

	string data;
	size_t length;

	try {
		FileUtils.get_contents (args[1], out data, out length);
	} catch (FileError e) {
		stderr.printf ("%s\n", e.message);
		return 1;
	}

	Rest.XmlParser parser = new Rest.XmlParser ();
	Rest.XmlNode node = parser.parse_from_data (data, length);
	if (node == null) {
		print ("Cannot parse document\n");
		return -1;
	}

	xml_node_output (node, 0);
	return 0;
}




