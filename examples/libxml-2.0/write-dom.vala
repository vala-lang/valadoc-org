public static Xml.Node* create_book (Xml.Ns* ns, int id, string title, string author) {
	Xml.Node* book = new Xml.Node (ns, "book");
	book->new_prop ("id", id.to_string ());

	book->new_text_child (ns, "title", title);
	book->new_text_child (ns, "author", author);
	return book;
}

public static int main (string[] args) {
	Xml.Doc* doc = new Xml.Doc ("1.0");
	Xml.Ns* ns = new Xml.Ns (null, "", "my");

	Xml.Node* books = new Xml.Node (ns, "books");
	doc->set_root_element (books);


	Xml.Node* comment;
	Xml.Node* book;

	comment = new Xml.Node.comment ("First book");
	books->add_child (comment);

	book = create_book (ns, 1, "The Royal Game", "Stefan Zweig");
	books->add_child (book);


	comment = new Xml.Node.comment ("Second book");
	books->add_child (comment);

	book = create_book (ns, 2, "The Stoker", "Franz Kafka");
	books->add_child (book);


	int res = doc->save_format_file ("my-books.xml", 1);
	if (res < 0) {
		print ("Error\n");
	}

	delete doc;
	return 0;
}
