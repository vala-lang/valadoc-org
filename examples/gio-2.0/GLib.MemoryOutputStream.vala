public static int main (string[] args) {
	try {
		MemoryOutputStream os = new MemoryOutputStream (null, GLib.realloc, GLib.free);

		// Write data to memory:
		DataOutputStream dos = new DataOutputStream (os);
		dos.put_int16 (int16.MIN);
		dos.put_int32 (int32.MIN);
		dos.put_int64 (int64.MIN);
		dos.close ();

		// Read data:
		uint8[] data = os.steal_data ();
		data.length = (int) os.get_data_size ();

		MemoryInputStream @is = new MemoryInputStream.from_data (data, GLib.free);
		DataInputStream dis = new DataInputStream (@is);
		print ("%d (Expected: %d)\n", dis.read_int16 (), int16.MIN);
		print ("%d (Expected: %d)\n", dis.read_int32 (), int32.MIN);
		print ("%"+int64.FORMAT+" (Expected: %"+int64.FORMAT+")\n", dis.read_int64 (), int64.MIN);
	} catch (IOError e) {
		print ("IOError %s\n", e.message);
	}
	return 0;
}
