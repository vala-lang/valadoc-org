public class ExampleParser : Object {
	const string[] nodes3 = {"compile", "title", "file", "node","note", "run", "image"};

	private const MarkupParser parser = {
		visit_start,
		visit_end,
		visit_text,
		null,
		error
	};

	private MarkupParseContext context;
	protected unowned string filename;
	private StringBuilder content;
	private string node3;
	private int sibling3;
	private int depth;

	protected string ressource_location (string path) {
		string dir = Path.get_dirname (filename);
		return Path.build_filename (dir, path);
	}

	protected string get_base_dir () {
		string dir = Path.get_dirname (filename);
		return dir;
	}

	protected string pos_as_string () {
		int line_number;
		int char_number;

		context.get_position (out line_number, out char_number);
		return "%d.%d".printf (line_number, char_number);
	}

	protected string build_error_message (string format, ...) {
		va_list args = va_list ();

		string pos = pos_as_string ();
		return "%s: %s: %s".printf (filename, pos, format.vprintf (args));
	}

	private bool get_attribute_bool (string[] names, string[] vals, string attribute, bool default_value) throws MarkupError {
		for (int i = 0; i < vals.length; i++) {
			if (names[i] == attribute) {
				bool return_value;
				if (bool.try_parse (vals[i], out return_value)) {
					return return_value;
				} else {
					throw new MarkupError.PARSE (build_error_message ("%s: invalid value", attribute));
				}
			}
		}

		return default_value;
	}

	private void visit_start (MarkupParseContext context, string name, string[] attr_names, string[] attr_values) throws MarkupError {
		if (depth == 0 && name == "examples") {
			examples_start ();
			depth++;
			return ;
		}

		if (depth == 1 && name == "example") {
			bool deprecated = get_attribute_bool (attr_names, attr_values, "deprecated", false);
			bool experimental = get_attribute_bool (attr_names, attr_values, "experimental", false);
			example_start (deprecated, experimental);
			sibling3 = 0;
			depth++;
			return ;
		}

		if (depth == 2 && name in nodes3) {
			if (sibling3 != 0 && name == "title") {
				throw new MarkupError.UNKNOWN_ELEMENT (build_error_message ("Unexpected element: `<%s>'", name));
			}

			if (sibling3 == 0 && name != "title") {
				title (null);
			}

			this.node3 = name;
			sibling3++;
			depth++;
			return ;
		}

		throw new MarkupError.UNKNOWN_ELEMENT (build_error_message ("Unexpected element: `<%s>'", name));
	}

	private void visit_end (MarkupParseContext context, string name) throws MarkupError {
		if (depth == 1 && name == "examples") {
			examples_end ();
			depth--;
			return ;
		}

		if (depth == 2 && name == "example") {
			example_end ();
			depth--;
			return ;
		}

		if (depth == 3 && node3 == name && name in nodes3) {
			string str = content.str.strip ();

			switch (name) {
			case "compile":
				compile (str);
				break;

			case "image":
				image (ressource_location (str));
				break;

			case "title":
				title (str);
				break;

			case "file":
				file (ressource_location (str));
				break;

			case "node":
				node (str);
				break;

			case "note":
				note (str);
				break;

			case "run":
				run (str);
				break;
			}

			this.node3 = null;
			content.erase ();
			depth--;
			return ;
		}

		throw new MarkupError.UNKNOWN_ELEMENT (build_error_message ("Unexpected element: `</%s>'", name));
	}

	private void visit_text (MarkupParseContext context, string text, size_t text_len) throws MarkupError {
		if (depth == 3) {
			content.append (text);
		} else if (text.strip () != "") {
			throw new MarkupError.INVALID_CONTENT ("Unexpected text `%s'", text);
		}
	}

	public ExampleParser () {
		context = new MarkupParseContext (parser, 0, this, null);
		content = new StringBuilder ();
	}

	public void parse (string filename) throws MarkupError, FileError {
		this.filename = filename;
		string markup = null;
		size_t length = 0;

		FileUtils.get_contents (filename, out markup, out length);
		context.parse (markup, -1);
		content.erase ();
		depth = 0;
	}


	//
	// Callbacks:
	//
	
	protected virtual void examples_start () throws MarkupError {
	}

	protected virtual void examples_end () throws MarkupError {
	}

	protected virtual void example_start (bool deprecated, bool experimental) throws MarkupError {
	}

	protected virtual void example_end () throws MarkupError {
	}

	protected virtual void compile (string cmnd) throws MarkupError {
	}

	protected virtual void title (string? str) throws MarkupError {
	}

	protected virtual void image (string image) throws MarkupError {
	}

	protected virtual void note (string note) throws MarkupError {
	}

	protected virtual void node (string node) throws MarkupError {
	}

	protected virtual void file (string file) throws MarkupError {
	}

	protected virtual void run (string cmnd) throws MarkupError {
	}

	protected virtual void error () {
	}
}
