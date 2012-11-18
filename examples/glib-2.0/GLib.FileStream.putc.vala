static int main () {
	// Output: ``Could MacGyver use it to save the world?``
	string str = "Could MacGyver use it to save the world?\n";
	for (int i = 0; str[i] != '\0'; i++) {
		stdout.putc (str[i]);
	}
	return 0;
}
