public static int main (string[] args) {
	try {
		FileIOStream iostream;
		File file = File.new_tmp ("tpl-XXXXXX.txt", out iostream);
		print ("tmp file name: %s\n", file.get_path ());

		OutputStream ostream = iostream.output_stream;
		DataOutputStream dostream = new DataOutputStream (ostream);
		dostream.put_string ("my tmp data\n");
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
