public static int main (string[] args) {
	// Output: ``roundf (0.3f) =  0.0f``
	stdout.printf ("roundf (%.1lff) =  %.1lff\n", 0.3f, Math.roundf (0.3f));

	// Outpu: ``floorf (3.9f) = 3.0f``
	stdout.printf ("floorf (%.1lff) = %.1lff\n", 3.9f, Math.floorf (3.9f));

	// Outpu: ``ceil (3.1) = 4.0``
	stdout.printf ("ceil (%.1lf) = %.1lf\n", 3.1, Math.ceil (3.1));


	// Output: ``acos (2.000000) = nan``
	stdout.printf("acos (%lf) = %lf\n", 2, Math.acos (x));

	// Output: ``atan2 (30.000000, 20.000000) = 0.982794``
	stdout.printf("atan2 (%lf, %lf) = %lf\n", 30.0, 20.0, Math.atan2 (30.0, 20.0));

	// Output: ``cos (1.042310) = 0.504227``
	stdout.printf ("cos (%lf) = %lf\n", 1.04231, Math.cos (1.04231));

	// ...

	return 0;
}
