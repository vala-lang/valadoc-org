public class MapParser : Object {
	private const MarkupParser parser = {
		visit_start,
		visit_end,
		visit_text,
		visit_passthrough,
		error
	};

	private MarkupParseContext context;

	public MapParser () {
		context = new MarkupParseContext (parser, 0, this, null);
	}

	// context.get_element_stack ().length () = O(n)
	private int depth;


	private string error_msg (string msg, ...) {
		va_list va_list = va_list ();
		int line_number;
		int char_number;

		StringBuilder pos = new StringBuilder ();
		foreach (string lst in context.get_element_stack ()) {
			if (pos.len != 0) {
				pos.append_c ('.');
			}
			pos.append (lst);
		}

		context.get_position (out line_number, out char_number);
		return "%s: %d.%d: %s".printf (pos.str, line_number, char_number, msg.vprintf (va_list));
	}

	// <name>
	private void visit_start (MarkupParseContext context, string name, string[] attr_names, string[] attr_values) throws MarkupError {
		// Use context.get_element_stack () to evaluate the state!

		if (name == "map" && this.depth == 0) {
			if (attr_names.length != 0) {
				throw new MarkupError.UNKNOWN_ATTRIBUTE (error_msg ("Unexpected attribute': `map.%s'", name));
			}
		} else if (name == "entry" && this.depth == 1) {
			unowned string key = null;
			unowned string val = null;

			for (int i = 0; attr_names[i] != null; i++) {
				switch (attr_names[i]) {
					case "key":
						key = attr_values[i];
						break;

					case "value":
						val = attr_values[i];
						break;

					default:
						throw new MarkupError.UNKNOWN_ATTRIBUTE (error_msg ("Unexpected attribute': `entry.%s'", name));
				}
			}

			if (key == null) {
				throw new MarkupError.MISSING_ATTRIBUTE (error_msg ("Missing attribute': `entry.key'"));
			} else if (val == null) {
				throw new MarkupError.MISSING_ATTRIBUTE (error_msg ("Missing attribute': `entry.value'"));
			}

			print ("Entry: '%s' = '%s'\n", key, val);
		} else {
			throw new MarkupError.UNKNOWN_ELEMENT (error_msg ("Unexpected element: `%s'", name));
		}

		this.depth++;
	}

	// </foo>
	private void visit_end (MarkupParseContext context, string name) throws MarkupError {
		this.depth--;

		if ((this.depth == 1 && name != "entry") || (this.depth == 0 && name != "map")) {
			throw new MarkupError.PARSE (error_msg ("Missing element: `/%s'", name));
		}
	}

	private void visit_text (MarkupParseContext context, string text, size_t text_len) throws MarkupError {
	}

	private void visit_passthrough () {
		// process instructions, comments
	}

	private void error (MarkupParseContext context, Error error) {
	}

	public bool parse (string markup) throws MarkupError {
		this.depth = 0;
        return context.parse (markup, -1);
	}

	public static int main (string[] args) {
		try {
			MapParser parser = new MapParser ();
			parser.parse ("""<map>
					<entry key="method" value="printf" />
					<entry key="field" value="errno" />
					<entry key="constant" value="RED" />
				</map>""");
		} catch (Error e) {
			print ("%s\n", e.message);
		}
		return 0;
	}
}

