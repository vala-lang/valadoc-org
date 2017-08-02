[Flags]
public enum MyFlags {
	VALUE_A,
	VALUE_B;

	public static bool try_parse_name (string name, out MyFlags result = null) {
		FlagsClass flagc = (FlagsClass) typeof (MyFlags).class_ref ();
		unowned FlagsValue? fval = flagc.get_value_by_name (name);
		if (fval == null) {
			result = 0;
			return false;
		}

		result = (MyFlags) fval.value;
		return true;
	}

	public static bool try_parse_nick (string nick, out MyFlags result = null) {
		FlagsClass flagc = (FlagsClass) typeof (MyFlags).class_ref ();
		unowned FlagsValue? fval = flagc.get_value_by_nick (nick);
		return_val_if_fail (fval != null, -1);
		if (fval == null) {
			result = 0;
			return false;
		}

	   	result = (MyFlags) fval.value;
		return true;
	}

	public static uint n_values () {
		FlagsClass flagc = (FlagsClass) typeof (MyFlags).class_ref ();
		return flagc.n_values;
	}
}

public static int main (string[] args) {
	uint n_values = MyFlags.n_values ();
	assert (n_values == 2);

	// Output: ``try-parse-nick: 1``
	MyFlags result;
	if (MyFlags.try_parse_nick ("value-a", out result)) {
		print ("try-parse-nick: %d\n", result);
	}

	// Output: ``try-parse-name: 2``
	if (MyFlags.try_parse_name ("MY_FLAGS_VALUE_B", out result)) {
		print ("try-parse-name: %d\n", result);
	}

	return 0;
}
