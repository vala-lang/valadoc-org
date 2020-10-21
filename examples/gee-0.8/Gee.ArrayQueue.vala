void main () {
	var queue = new Gee.ArrayQueue<string> ();
	queue.offer ("hello");
	queue.offer ("this");
	queue.offer ("time");

	foreach (string s in queue)
		print ("%s\n", s);
}
