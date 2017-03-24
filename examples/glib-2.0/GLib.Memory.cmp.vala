public struct TestStruct {
	public int a;
	public int b;

	public TestStruct (int a, int b) {
		this.a = a;
		this.b = b;
	}
}

public static int main (string[] args) {
	TestStruct a = TestStruct (1, 2);
	TestStruct b = TestStruct (1, 2);

	// Output: ``0``
	int res = Memory.cmp (&a, &b, sizeof (TestStruct));
	print ("cmp (a, b) = %d\n", res);

	return 0;
}
