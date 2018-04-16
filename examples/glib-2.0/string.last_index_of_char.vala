public static int main (string[] args) {
	string filename = "blueprint-dalek.vs1.pdf";

	// Output: ``19``
	int index = filename.last_index_of_char ('.');
	print ("%d\n", index);

	// Output: ``-1``
	index = filename.last_index_of_char ('Ω');
	print ("%d\n", index);
	return 0;
}
