public enum MyEnum {
	VALUE_A = -10,
	VALUE_B = 10;

    public static bool try_parse_name (string name, out MyEnum result = null) {
        EnumClass enumc = (EnumClass) typeof (MyEnum).class_ref ();
        unowned EnumValue? eval = enumc.get_value_by_name (name);
        if (eval == null) {
			result = MyEnum.VALUE_A;
			return false;
		}

        result = (MyEnum) eval.value;
		return true;
    }

    public static bool try_parse_nick (string nick, out MyEnum result = null) {
        EnumClass enumc = (EnumClass) typeof (MyEnum).class_ref ();
        unowned EnumValue? eval = enumc.get_value_by_nick (nick);
        return_val_if_fail (eval != null, -1);
        if (eval == null) {
			result = MyEnum.VALUE_A;
			return false;
		}

       	result = (MyEnum) eval.value;
		return true;
    }

	public static int min () {
        EnumClass enumc = (EnumClass) typeof (MyEnum).class_ref ();
		return enumc.minimum;
	}

	public static int max () {
        EnumClass enumc = (EnumClass) typeof (MyEnum).class_ref ();
		return enumc.maximum;
	}

	public static uint n_values () {
        EnumClass enumc = (EnumClass) typeof (MyEnum).class_ref ();
		return enumc.n_values;
	}

	public string to_nick () {
        EnumClass enumc = (EnumClass) typeof (MyEnum).class_ref ();
        unowned EnumValue? eval = enumc.get_value (this);
        return_val_if_fail (eval != null, null);
        return eval.value_nick;
	}

	public static HashTable<unowned string, MyEnum> to_hash_table () {
		HashTable<unowned string, MyEnum> table = new HashTable<unowned string, MyEnum> (str_hash, str_equal);
        EnumClass enumc = (EnumClass) typeof (MyEnum).class_ref ();
		foreach (unowned EnumValue val in enumc.values) {
			table.insert (val.value_nick, (MyEnum) val.@value);
		}
		return table;
	}
}


public static int main (string[] args) {
	uint n_values = MyEnum.n_values ();
	assert (n_values == 2);

	int min = MyEnum.min ();
	assert (min == -10);

	int max = MyEnum.max ();
	assert (max == 10);


	// Output: ``MY_ENUM_VALUE_A, value-a``
	string str = MyEnum.VALUE_A.to_string ();
	string nick = MyEnum.VALUE_A.to_nick ();
	print ("%s, %s\n", str, nick);


	HashTable<unowned string, MyEnum> table = MyEnum.to_hash_table ();
	string key = "value-a";

	// Output: ``value-a, MY_ENUM_VALUE_A = value-a = -10``
	MyEnum val = table.lookup (key);
	print ("%s, %s = %s = %d\n", key, val.to_string (), val.to_nick (), val);

	// Output: ``value-b, MY_ENUM_VALUE_B = value-b = 10``
	key = "value-b";
	val = table.lookup (key);
	print ("%s, %s = %s = %d\n", key, val.to_string (), val.to_nick (), val);

	// Output: ``try-parse-nick: MY_ENUM_VALUE_A``
	MyEnum result;
	if (MyEnum.try_parse_nick ("value-a", out result)) {
		print ("try-parse-nick: %s\n", result.to_string ());
	}

	// Output: ``try-parse-name: MY_ENUM_VALUE_A``
	if (MyEnum.try_parse_name ("MY_ENUM_VALUE_A", out result)) {
		print ("try-parse-name: %s\n", result.to_string ());
	}

	return 0;
}
