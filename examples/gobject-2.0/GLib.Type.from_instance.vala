public class MyClass : Object {
}

public static int main (string[] args) {
	// Output: ``MyClass``
	stdout.printf ("%s\n", Type.from_instance (new MyClass ()).name ());
	return 0;
}
