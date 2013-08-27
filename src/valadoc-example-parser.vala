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
	private unowned string filename;
	private StringBuilder content;
	private string node3;
	private int sibling3;
	private int depth;

	protected string ressource_location (string path) {
		string dir = Path.get_dirname (filename);
		return Path.build_filename (dir, path);
	}

	private string build_error_message (string format, ...) {
		va_list args = va_list ();
		int line_number;
		int char_number;

		context.get_position (out line_number, out char_number);
		return "%s: %d-%d: %s".printf (filename, line_number, char_number, format.vprintf (args));
	}

	private void visit_start (MarkupParseContext context, string name, string[] attr_names, string[] attr_values) throws MarkupError {
		if (depth == 0 && name == "examples") {
			examples_start ();
			depth++;
			return ;
		}

		if (depth == 1 && name == "example") {
			example_start ();
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
				image (str);
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
	
	protected virtual void examples_start () {
	}

	protected virtual void examples_end () {
	}

	protected virtual void example_start () {
	}

	protected virtual void example_end () {
	}

	protected virtual void compile (string cmnd) {
	}

	protected virtual void title (string? str) {
	}

	protected virtual void image (string image) {
	}

	protected virtual void note (string note) {
	}

	protected virtual void node (string node) {
	}

	protected virtual void file (string file) {
	}

	protected virtual void run (string cmnd) {
	}

	protected virtual void error () {
	}
}
