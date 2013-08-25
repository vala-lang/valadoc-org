public enum MyEnum {
	FOO, BAR, FOOBAR
}

public class MyObject : Object {
	public string str { get; set; }
	public MyEnum en { get; set; }
	public int num { get; set; }

	public string to_string () {
		StringBuilder builder = new StringBuilder ();
		builder.append_printf ("str = %s\n", str);
		builder.append_printf ("en  = %s\n", en.to_string ());
		builder.append_printf ("num = %d", num);
		return (owned) builder.str;
	}
}

public static int main (string[] args) {
	string data = """
		{
			"str" : "my string",
			"en"  : 2,
			"num" : 10
		}""";


	// See Json.gobject_from_data
	try {
		// Create a Json.Node:
		Json.Parser parser = new Json.Parser ();
		parser.load_from_data (data);

		Json.Node node = parser.get_root ();

		// Deserialization:
		MyObject obj = Json.gobject_deserialize (typeof (MyObject), node) as MyObject;
		assert (obj != null);

		// Output:
		//  ``str = my string``
		//  ``en  = MY_ENUM_FOOBAR``
		//  ``num = 10``
		stdout.puts (obj.to_string ());
		stdout.putc ('\n');
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
