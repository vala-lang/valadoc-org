public static int main (string[] args) {
	try {
		//
		// Read data:
		//

		KeyFile file = new KeyFile ();

		// Use ',' as array-element-separator instead of ';'.
		file.set_list_separator (',');

		// file.load_from_file ("my-keyfile.conf", KeyFileFlags.NONE);
		file.load_from_data ("""
			# This is an example key-value file

			[OptionalGroup]
			required_key = myreq
			optional_key = myopt

			[BasicValues]
			String=mystr
			Bool=true
			Int=300
			Double=0.0

			[Lists]
			BoolArray=true,true,false
			StringArray=Str1,Str2

			[LocalizedString]
			Hi=Hello
			Hi[fr]=Bonjour
			Hi[de]=Hallo
			Hi[es]=Hola
		""", -1, KeyFileFlags.NONE);

		// ** BasicValues:
		string @string = file.get_string ("BasicValues", "String");
		bool @bool = file.get_boolean ("BasicValues", "Bool");
		int @int = file.get_integer ("BasicValues", "Int");
		double @double = file.get_double ("BasicValues", "Double");

		// Output:
		//  ``mystr``
		//  ``true``
		//  ``300``
		//  ``0.000000``
		print ("%s\n", @string);
		print ("%s\n", @bool.to_string ());
		print ("%d\n", @int);
		print ("%f\n", @double);

		// ** Lists:
		bool[] bool_array = file.get_boolean_list ("Lists", "BoolArray");
		string[] string_array = file.get_string_list ("Lists", "StringArray");

		// Output: ``true true false``
		foreach (bool b in bool_array) {
			print ("%s ", b.to_string ());
		}
		print ("\n");

		// Output: ``"Str1" "Str2"``
		foreach (string str in string_array) {
			print ("\"%s\" ", str);
		}
		print ("\n");

		// ** LocalizedString:
		string hi = file.get_locale_string ("LocalizedString", "Hi", null);
		// Output: ``Hello``
		print ("%s\n", hi);


		// ** OptionalGroup
		// Check availability before accessing to avoid exceptions:
		if (file.has_group ("OptionalGroup")) {
			string required_key = file.get_string ("OptionalGroup", "required_key");
			string? optional_key = null;
			if (file.has_key ("OptionalGroup", "optional_key")) {
				optional_key = file.get_string ("OptionalGroup", "optional_key");
			}

			// Output:
			//  ``myreq``
			//  ``myopt``
			print ("%s\n", required_key);
			print ("%s\n", optional_key);
		}

		//
		// Modify data:
		//

		file.set_string ("BasicValues", "String", "my-new-value");
		file.remove_group ("LocalizedString");
		file.remove_group ("OptionalGroup");
		file.remove_key ("Lists", "StringArray");


		//
		// List all groups & keys:
		//

		// Output:
		//  ``Key: BasicValues.String = my-new-value``
		//  ``Key: BasicValues.Bool = true``
		//  ``Key: BasicValues.Int = 300``
		//  ``Key: BasicValues.Double = 0.0``
		//  ``Key: Lists.BoolArray = true,true,false``

		foreach (unowned string group in file.get_groups ()) {
			foreach (unowned string key in file.get_keys (group)) {
				print ("Key: %s.%s = %s\n", group, key, file.get_value (group, key));
			}
		}

		//
		// Print the modified keyfile to stdout:
		//

		// Output:
		//  ``-----``
		//  ``[BasicValues]``
		//  ``String=my-new-value``
		//  ``Bool=true``
		//  ``Int=300``
		//  ``Double=0.0``
		//  ````
		//  ``[Lists]``
		//  ``BoolArray=true,true,false``
		//  ``----``
		string keyfile_str = file.to_data ();
		print ("-----\n%s----\n", keyfile_str);
	} catch (KeyFileError e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
