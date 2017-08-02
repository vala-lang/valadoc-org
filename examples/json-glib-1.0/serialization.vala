public enum MyEnum {
	FOO, BAR, FOOBAR
}

public class MyObject : Object {
	public string str { get; set; }
	public MyEnum en { get; set; }
	public int num { get; set; }

	public MyObject (string str, MyEnum en, int num) {
		this.str = str;
		this.num = num;
		this.en = en;
	}
}

public static int main (string[] args) {
	MyObject obj = new MyObject ("my string", MyEnum.FOOBAR, 10);
	Json.Node root = Json.gobject_serialize (obj);

	// To string: (see gobject_to_data)
	Json.Generator generator = new Json.Generator ();
	generator.set_root (root);
	string data = generator.to_data (null);

	// Output:
	// ``{"str":"my string","en":2,"num":10}``
	print (data);
	print ("\n");

	return 0;
}
