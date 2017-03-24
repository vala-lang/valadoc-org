public class MyClass : Object {
}

public static int main (string[] args) {
	// Output: ``MyClass``
	print ("%s\n", Type.from_instance (new MyClass ()).name ());
	return 0;
}
