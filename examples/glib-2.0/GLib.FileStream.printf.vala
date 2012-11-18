public static int main (string[] args) {
	string mystr = "mystr";
	short myshort = 3;
	ushort myushort = 3;
	int myint = -10;
	uint myuint = 10;
	long mylong = 100;
	long myulong = 100;
	float myfloat = 0.10f;
	char mychar = 'a';
	char myuchar = 'a';
	unichar myunichar = 'z';
	void* myptr = null;
	bool mybool = true;
	size_t mysizet = 10;
	ssize_t myssizet = 10;
	int8 myint8 = 2;
	uint8 myuint8 = 2;
	int16 myint16 = 2;
	uint16 myuint16 = 2;
	int32 myint32 = 2;
	uint32 myuint32 = 2;
	int64 myint64 = 2;
	uint64 myuint64 = 2;

	// Output:
	// `` 1. ptr: (nil)``
	// `` 2. percent: % 3. string: mystr``
	stdout.printf (" 1. ptr: %p\n", myptr);
	stdout.printf (" 2. percent: %%\n");

	// Output:
	// `` 3. string: mystr``
	// `` 4. char: 97``
	// `` 5. uchar: 97``
	// `` 6. unichar: z
	stdout.printf (" 3. string: %s\n", mystr);
	stdout.printf (" 4. char: %d\n", mychar);
	stdout.printf (" 5. uchar: %hhu\n", myuchar);
	stdout.printf (" 6. unichar: %s\n", myunichar.to_string ());

	// Output:
	// `` 7. short: 3``
	// `` 8. ushort: 3``
	stdout.printf (" 7. short: %hi\n", myshort);
	stdout.printf (" 8. ushort: %hu\n", myushort);

	// Output:
	// `` 9. int8: 2``
	// ``10. uint8: 2``
	stdout.printf (" 9. int8: %hhi\n", myint8);
	stdout.printf ("10. uint8: %hhu\n", myuint8);

	// Output:
	// ``11. int16: 2``
	// ``12. uint16: 2``
	stdout.printf ("11. int16: %" + int16.FORMAT + "\n", myint16);
	stdout.printf ("12. uint16: %" + uint16.FORMAT + "\n", myuint16);

	// Output:
	// ``13. int32: 2``
	// ``14. uint32: 2``
	stdout.printf ("13. int32: %" + int32.FORMAT + "\n", myint32);
	stdout.printf ("14. uint32: %" + uint32.FORMAT + "\n", myuint32);

	// Output:
	// ``15. int64: 2``
	// ``16. uint64: 2``
	stdout.printf ("15. int64: %" + int64.FORMAT + "\n", myint64);
	stdout.printf ("16. uint64: %" + uint64.FORMAT + "\n", myuint64);

	// Output:
	// ``17. int: -10``
	// ``18. int: -10``
	// ``19. octal: 37777777766``
	// ``20. hex,lower: fffffff6``
	// ``21. hex,upper: FFFFFFF6``
	// ``22. uint: 10``
	stdout.printf ("17. int: %d\n", myint);
	stdout.printf ("18. int: %i\n", myint);
	stdout.printf ("19. octal: %o\n", myint);
	stdout.printf ("20. hex,lower: %x\n", myint);
	stdout.printf ("21. hex,upper: %X\n", myint);
	stdout.printf ("22. uint: %u\n", myuint);

	// Output:
	// ``23. long: 100``
	// ``24. ulong: 100``
	stdout.printf ("23. long: %li\n", mylong);
	stdout.printf ("24. ulong: %lu\n", myulong);

	// Output:
	// ``25. size_t: 10``
	// ``26. ssize_t: 10``
	stdout.printf ("25. size_t: %" + size_t.FORMAT + "\n", mysizet);
	stdout.printf ("26. ssize_t: %" + ssize_t.FORMAT + "\n", myssizet);

	// Output:
	// ``27. float,lower: 0.100000``
	// ``28. float,upper: 0.100000``
	// ``29. scientific,lower: 1.000000e-01``
	// ``30. scientific,upper: 1.000000E-01``
	// ``31. shortest,lower: 0.1``
	// ``32. shortest,upper: 0.1``
	// ``33. hex,lower: 0x1.99999ap-4``
	// ``34. hex,upper: 0X1.99999AP-4``
	stdout.printf ("27. float,lower: %f\n", myfloat);
	stdout.printf ("28. float,upper: %F\n", myfloat);
	stdout.printf ("29. scientific,lower: %e\n", myfloat);
	stdout.printf ("30. scientific,upper: %E\n", myfloat);
	stdout.printf ("31. shortest,lower: %g\n", myfloat);
	stdout.printf ("32. shortest,upper: %G\n", myfloat);
	stdout.printf ("33. hex,lower: %a\n", myfloat);
	stdout.printf ("34. hex,upper: %A\n", myfloat);

	// Output:
	// ``35. true``
	stdout.printf ("35. %s\n", mybool.to_string ());
	return 0;
}
