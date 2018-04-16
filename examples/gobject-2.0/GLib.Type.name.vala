public class MyClass : Object {
}

public static int main (string[] args) {
	// Output: ``MyClass``
	print ("%s\n", typeof (MyClass).name ());

	// Output: ``MyClass``
	print ("%s\n", new MyClass ().get_type ().name ());

	// Output: ``MyClass``
	print ("%s\n", Type.from_instance (new MyClass ()).name ());

	// Output: ``MyClass``
	print ("%s\n", Type.from_name ("MyClass").name ());
	return 0;
}
