public static int main (string[] args) {
	// Output: ``10``
	void* ptr = 10.to_pointer ();
	print ("%d\n", (int) ptr);
	return 0;
}
