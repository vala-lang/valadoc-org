public static int main (string[] args) {
	string data = "7-19-abc";
	int seg1 = -1;
	int seg2 = -1;
	int seg3 = -1;

	// Output: ``7, 19, -1``
	data.scanf ("%d-%d-%d", &seg1, &seg2, &seg3);
	print ("%d, %d, %d\n", seg1, seg2, seg3);
	return 0;
}
