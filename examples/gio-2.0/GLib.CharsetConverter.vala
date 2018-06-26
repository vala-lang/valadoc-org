public static int main (string[] args) {
	try {
		MemoryOutputStream mostream = new MemoryOutputStream (null, GLib.realloc, GLib.free);
		CharsetConverter oconverter = new CharsetConverter ("utf-16", "utf-8");
		ConverterOutputStream costream = new ConverterOutputStream (mostream, oconverter);
		DataOutputStream dostream = new DataOutputStream (costream);
		dostream.put_string ("ΑαΒβΓγΔδΕεΖζΗηΘθ\n");
		dostream.put_string ("ΙιΚκΛλΜμΝνΞξΟοΠπ\n");
		dostream.put_string ("ΡρΣσΤτΥυΦφΧχΨψΩω\n");
		mostream.close ();

		Bytes bytes = mostream.steal_as_bytes ();

		MemoryInputStream mistream = new MemoryInputStream.from_bytes (bytes);
		CharsetConverter iconverter = new CharsetConverter ("utf-8", "utf-16");
		ConverterInputStream cistream = new ConverterInputStream (mistream, iconverter);
		DataInputStream distream = new DataInputStream (cistream);

		string line = distream.read_line ();
		print (@"$line\n");

		line = distream.read_line ();
        print (@"$line\n");

		line = distream.read_line ();
        print (@"$line\n");
	} catch (IOError e) {
		print ("IOError: %s\n", e.message);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
