public class MyClass : Object {
}

public static int main (string[] args) {
	// Output: ``MyClass``
	stdout.printf ("%s\n", typeof (MyClass).name ());

	// Output: ``MyClass``
	stdout.printf ("%s\n", new MyClass ().get_type ().name ());

	// Output: ``MyClass``
	stdout.printf ("%s\n", Type.from_instance (new MyClass ()).name ());

	// Output: ``MyClass``
	stdout.printf ("%s\n", Type.from_name ("MyClass").name ());
	return 0;
}
