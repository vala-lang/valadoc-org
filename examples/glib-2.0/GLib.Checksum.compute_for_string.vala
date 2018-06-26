public static int main (string[] args) {
	string password = "123supersecret";
	string salt = "dummy-salt";

	// md5 (password) = 2137ac274355e2e180d5125ae28fc408
	string hash = GLib.Checksum.compute_for_string (ChecksumType.MD5, password, password.length);

	// md5 (md5 (password) + salt) = ce48e145cb9fdcaf6ba2f63afc262d14
	hash = GLib.Checksum.compute_for_string (ChecksumType.MD5, hash + salt);
	print ("Hash: %s\n", hash);
	return 0;
}
