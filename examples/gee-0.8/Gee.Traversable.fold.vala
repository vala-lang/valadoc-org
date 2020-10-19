uint max_length (Gee.Traversable<string> l) {
	return l.fold<uint> ((s, maxlen) => {
			return uint.max (s.length, maxlen);
		}, 0U);
}

public void main () {
	var ts = new Gee.TreeSet<string> ();
	ts.add ("helo");
	ts.add ("goodbyte");
	ts.add ("every");
	ts.add ("day");
	foreach (string s in ts) {
		print ("%s\n", s);
	}
	print ("longest string is of length: %u\n", max_length (ts));
}
