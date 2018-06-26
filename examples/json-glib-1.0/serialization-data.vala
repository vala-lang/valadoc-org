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

	string data = Json.gobject_to_data (obj, null);
	print (data);
	print ("\n");

	// Output:
	//  ``{``
	//  ``  "str" : "my string",``
	//  ``  "en" : 2,``
	//  ``  "num" : 10``
	//  ``}``

	return 0;
}
