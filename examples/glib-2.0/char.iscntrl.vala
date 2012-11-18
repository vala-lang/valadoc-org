public static int main (string[] args) {
	// 0-0x1F or equal to 0x7F

	// Output: ````
	for (int i = 0; i <= 0x1F; i++) {
		assert (((char) i).iscntrl () == true);
	}

	for (int i = 0x1F + 1; i < 0x7F; i++) {
		assert (((char) i).iscntrl () == false);
	}

	assert (((char) 0x7F).iscntrl () == true);

	for (int i = 0x7f + 1; i <= 255; i++) {
		assert (((char) i).iscntrl () == false);
	}


	return 0;
}
