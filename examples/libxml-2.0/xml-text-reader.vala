public class Book : Object {
	public string author { private set; get; }
	public string title { private set; get; }
	public int64 id { private set; get; }

	public Book (int64 id, owned string author, owned string title) {
		this.author = (owned) author;
		this.title = (owned) title;
		this.id = id;
	}

	public string to_string () {
		return ("%"+int64.FORMAT+": %s, written by %s").printf (id, title, author);
	}
}

public class BookReader : Object {
	private SList<Book> books;
	private Xml.TextReader reader;
	private Xml.ReaderType current_type;
	private unowned string filename;
	private int status;

	public SList<Book> read (string filename) throws FileError, MarkupError {
		this.reader = new Xml.TextReader.filename (filename);
		if (this.reader == null) {
			throw new FileError.NOENT ("Unable to open %s\n", filename);
		}

		this.filename = filename;

		next ();
		read_books ();

		if (status != 0) {
			error ("failed to parse file");
		}

		return (owned) books;
	}

	private void error (string str) throws MarkupError {
		int column = reader.get_parser_column_number ();
		int line = reader.get_parser_line_number ();
		throw new MarkupError.PARSE ("%s: %d.%d: %s",  filename, line, column, str);
	}

	private void next () throws MarkupError {
		status = reader.read ();
		if (status == -1) {
			error ("failed to parse file");
		}

		current_type = (Xml.ReaderType) reader.node_type ();
		if (current_type == Xml.ReaderType.WHITESPACE || current_type == Xml.ReaderType.SIGNIFICANT_WHITESPACE) {
			next ();
		}
	}

	private bool is_start_element (string name) {
		if (current_type != Xml.ReaderType.ELEMENT || reader.const_name () != name) {
			return false;
		}
		return true;
	}

	private void start_element (string name) throws MarkupError {
		if (current_type != Xml.ReaderType.ELEMENT || reader.const_name () != name) {
			string got = (reader.const_name () != null)? ", got: " + reader.const_name () : "";
			error ("expected start element of `%s'%s".printf (name, got));
		}
	}

	private void end_element (string name) throws MarkupError {
		if (current_type != Xml.ReaderType.END_ELEMENT || reader.const_name () != name) {
			string got = (reader.const_name () != null)? ", got: " + reader.const_name () : "";
			error ("expected end element of `%s'%s".printf (name, got));
		}
		next ();
	}

	private string text () throws MarkupError {
		if (current_type != Xml.ReaderType.TEXT) {
			string got = (reader.const_name () != null)? ", got: " + reader.const_name () : "";
			error ("expected text" + got);
		}

		string content = reader.const_value ();
		next ();

		return content;
	}

	private int64 get_attr_int (string name) throws MarkupError {
		string num_str = reader.get_attribute (name);
		if (num_str == null) {
			error ("expected id=\"<int>\"");
		}

		int64 id;

		if (int64.try_parse (num_str, out id) == false) {
			error ("expected id=\"<int>\"");
		}

		return id;
	}

	private void read_books () throws MarkupError {
		start_element ("books");
		next ();

		while (is_start_element ("book")) {
			read_book ();
		}

		end_element ("books");
	}

	private void read_book () throws MarkupError {
		start_element ("book");
		int64 id = get_attr_int ("id");
		next ();

		string title = read_title ();
		string author = read_author ();

		end_element ("book");

		books.prepend (new Book (id, (owned) author, (owned) title));
	}

	private string read_title () throws MarkupError {
		start_element ("title");
		next ();

		string title = text ();

		end_element ("title");
		return title;
	}

	private string read_author () throws MarkupError {
		start_element ("author");
		next ();

		string author = text ();

		end_element ("author");
		return author;
	}

	public static int main (string[] args) {
		try {
			BookReader reader = new BookReader ();
			SList<Book> books = reader.read ("books.xml");
			books.foreach ((book) => {
				print (book.to_string ());
				print ("\n");
			});
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}
		return 0;
	}
}
