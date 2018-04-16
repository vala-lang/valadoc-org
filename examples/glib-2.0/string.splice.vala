static int main (string[] args) {
	string wisdom = "水は方円の器に従い、人は善悪の友による。";
	int start = wisdom.index_of_nth_char (5); // 器
	int end = wisdom.index_of_nth_char (10); // 人

	// Output:
	//  ``水は方円の器に従い、人は善悪の友による。``
	//  ``水は方円の人は善悪の友による。``
	//  ``水は方円のREPLACEMENT人は善悪の友による。``
	string res1 = wisdom.splice (start, end);
	string res2 = wisdom.splice (start, end, "REPLACEMENT");
	print ("%s\n", wisdom);
	print ("%s\n", res1);
	print ("%s\n", res2);

	return 0;
}
