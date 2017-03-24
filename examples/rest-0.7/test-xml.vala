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
	try {
		MainLoop loop = new MainLoop ();

		Rest.Proxy proxy =new Rest.Proxy ("http://www.flickr.com/services/rest/", false);
		Rest.ProxyCall call = proxy.new_call ();
		call.set_method ("GET");
		call.add_params (
			"method", "flickr.photos.getInfo",
			"api_key", "314691be2e63a4d58994b2be01faacfb",
			"photo_id", "2658808091");

		Rest.ProxyCallAsyncCallback proxy_call_raw_async_cb = (call, err, obj) => {
			Rest.XmlParser parser = new Rest.XmlParser ();
			string payload = call.get_payload ();
			int64 len = call.get_payload_length ();
			Rest.XmlNode node = parser.parse_from_data (payload, len);
			xml_node_output (node, 0);

			loop.quit ();
		};

		call.run_async (proxy_call_raw_async_cb);
		loop.run ();


		call = proxy.new_call ();
		call.set_method ("GET");
		call.add_params (
			"method", "flickr.people.getPublicPhotos",
			"api_key", "314691be2e63a4d58994b2be01faacfb",
			"user_id","66598853@N00");

		call.run_async (proxy_call_raw_async_cb);
		loop.run ();
	} catch (Error e) {
		stderr.puts (e.message);
		stderr.putc ('\n');
	}
	return 0;
}
