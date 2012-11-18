static int main (string[] args) {
	int num = 0;
	stdout.printf ("What's your favorite integer?\n");
	stdin.scanf ("%d", &num);
	stdout.printf ("%d? Really?\n", num);
	return 0;
}
