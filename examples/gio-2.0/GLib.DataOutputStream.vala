public static void write_data (DataOutputStream dos) throws GLib.IOError {
	dos.put_int16 (int16.MIN);
	dos.put_int32 (int32.MIN);
	dos.put_int64 (int64.MIN);

	dos.put_uint16 (uint16.MAX);
	dos.put_uint32 (uint32.MAX);
	dos.put_uint64 (uint64.MAX);

	dos.put_byte ('c');
	dos.put_string ("Northwest Passage");
	dos.put_byte ('\0');

	dos.put_string ("Barrett's Privateers");
	dos.put_byte ('\0');
}

public static void read_data (DataInputStream dis) throws GLib.IOError {
	print ("%d (Expected: %d)\n", dis.read_int16 (), int16.MIN);
	print ("%d (Expected: %d)\n", dis.read_int32 (), int32.MIN);
	print ("%"+int64.FORMAT+" (Expected: %"+int64.FORMAT+")\n", dis.read_int64 (), int64.MIN);

	print ("%u (Expected: %u)\n", dis.read_uint16 (), uint16.MAX);
	print ("%u (Expected: %u)\n", dis.read_uint32 (), uint32.MAX);
	print ("%"+uint64.FORMAT+" (Expected: %"+uint64.FORMAT+")\n", dis.read_uint64 (), uint64.MAX);

	print ("%c\n", dis.read_byte ());

	print ("%s\n", dis.read_upto ("\0", 1, null));
	dis.read_byte (); // Consume '\0'

	print ("%s\n", dis.read_upto ("\0", 1, null));
	dis.read_byte (); // Consume '\0'
}

public static int main (string[] args) {
	try {
		// Create a file that can only be accessed by the current user:
		File file = File.new_for_path ("my-test.bin");
		FileIOStream ios = file.create_readwrite (FileCreateFlags.PRIVATE);

		// Write data:
		DataOutputStream dos = new DataOutputStream (ios.output_stream);
		write_data (dos);

		// Reset fp, read data:
		ios.seek (0, SeekType.SET);
		DataInputStream dis = new DataInputStream (ios.input_stream);
		read_data (dis);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
