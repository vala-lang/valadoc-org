public static int main (string[] args) {
	PtrArray array = new PtrArray ();
	array.add ("second entry");
	array.add ("third entry");
	array.add ("first entry");

	array.sort ((a, b) => {
		void** foo = a; void* _foo = *foo; // a is void*, but we get void**
		void** bar = b; void* _bar = *bar; // b is void*, but we get void**
		return strcmp ((string) _foo, (string) _bar);
	});

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	array.foreach ((ptr) => {
		print ("%s\n", (string) ptr);
	});

	return 0;
}
