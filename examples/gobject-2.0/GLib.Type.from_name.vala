public class MyClass : Object {}

public static int main (string[] args) {
	// Register the type:
	Type? type = typeof (MyClass);

	// Output: ``MyClass``
	print ("%s\n", Type.from_name ("MyClass").name ());
	type = null;
	return 0;
}
