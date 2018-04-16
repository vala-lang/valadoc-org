public static int main (string[] args) {
	// Parse the document from path
	Xml.Doc* doc = Xml.Parser.parse_file ("books.xml");
	if (doc == null) {
		print ("File 'books.xml' not found or permissions missing\n");
		return 0;
	}

	Xml.XPath.Context cntx = new Xml.XPath.Context (doc);
	Xml.XPath.Object* res = cntx.eval_expression ("/books/book/title");

	assert (res != null);
	assert (res->type == Xml.XPath.ObjectType.NODESET);
	assert (res->nodesetval != null);

	for (int i = 0; i < res->nodesetval->length (); i++) {
		Xml.Node* node = res->nodesetval->item (i);
		print ("%s\n", node->get_content ());
	}

	delete res;
	delete doc;
	return 0;
}
