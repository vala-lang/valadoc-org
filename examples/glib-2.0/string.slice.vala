static int main (string[] args) {
	string wisdom = "水は方円の器に従い、人は善悪の友による。";
	int start = wisdom.index_of_nth_char (5); // 器
	int end = wisdom.index_of_nth_char (10); // 人

	// Output: ``器に従い、``
	string res = wisdom.slice (start, end);
	print ("%s\n", res);
	return 0;
}
