static int main (string[] args) {
	// Output:
	//  ``symbol: 0	byte-offset: 0:	楽``
	//  ``symbol: 1	byte-offset: 3:	あ``
	//  ``symbol: 2	byte-offset: 6:	れ``
	//  ``symbol: 3	byte-offset: 9:	ば``
	//  ``symbol: 4	byte-offset: 12:	苦``
	//  ``symbol: 5	byte-offset: 15:	あ``
	//  ``symbol: 6	byte-offset: 18:	り``
	//  ``symbol: 7	byte-offset: 21:	。``

	string wisdom = "楽あれば苦あり。";
	for (int i = 0; i < 8; i++) {
		int bpos = wisdom.index_of_nth_char (i);
		print ("symbol: %d\tbyte-offset: %d:\t%s\n", i, bpos, wisdom.get_char (bpos).to_string ());
	}

	return 0;
}
