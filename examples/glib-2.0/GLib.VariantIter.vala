public static int main (string[] args) {
    GLib.Variant? val = null;
    string? key = null;

	VariantBuilder builder = new VariantBuilder (new VariantType ("a{sv}") );
	builder.add ("{sv}", "str1", new Variant.string ("str"));
	builder.add ("{sv}", "str2", new Variant.int16 (10));
	builder.add ("{sv}", "str4", new Variant.int32 (10));
	builder.add ("{sv}", "str5", new Variant.int64 (10));

	Variant dictionary = builder.end ();

	VariantIter iter = dictionary.iterator ();

	while (iter.next ("{sv}", out key, out val)) {
		print ("Item '%s' has type '%s'\n", key, val.get_type_string ());
	}

	return 0;
}
