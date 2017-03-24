private inline void ret_to_ex (int errc) throws FileError {
	if (errc < 0) {
		throw new FileError.FAILED ("Failed");
	}
}

public class Books : Object {
	private SList<Book> books;

	public Books (owned SList<Book> books) {
		this.books = (owned) books;
	}

	public void write (Xml.TextWriter writer) throws FileError {
		ret_to_ex (writer.start_element ("books"));
		foreach (Book book in books) {
			book.write (writer);
		}
		ret_to_ex (writer.end_element ());
	}
}

public class Book : Object {
	public string author { private set; get; }
	public string title { private set; get; }
	public int64 id { private set; get; }

	public Book (int64 id, string author, string title) {
		this.author = author;
		this.title = title;
		this.id = id;
	}

	public void write (Xml.TextWriter writer) throws FileError {
		ret_to_ex (writer.start_element ("book"));
		ret_to_ex (writer.write_attribute ("id", id.to_string ()));

		ret_to_ex (writer.start_element ("title"));
		ret_to_ex (writer.write_string (title));
		ret_to_ex (writer.end_element ());

		ret_to_ex (writer.start_element ("author"));
		ret_to_ex (writer.write_string (author));
		ret_to_ex (writer.end_element ());

		ret_to_ex (writer.end_element ());
	}
}

public static int main (string[] args) {
	SList<Book> book_list = new SList<Book> ();
	book_list.prepend (new Book (2, "Franz Kafka", "The Stoker"));
	book_list.prepend (new Book (1, "Stefan Zweig", "The Royal Game"));

	Books books = new Books ((owned) book_list);

	Xml.TextWriter writer = new Xml.TextWriter.filename ("my-books.xml", false);
	if (writer == null) {
		print ("Error: Xml.TextWriter.filename () == null\n");
		return 0;
	}

	try {
		ret_to_ex (writer.start_document ("1.0", "utf-8"));
		writer.set_indent (true);
		books.write (writer);
		ret_to_ex (writer.flush ());
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
