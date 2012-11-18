public class DummyObject : Object {
}

public struct DummyStruct {
	public int dummy1;
	public int dummy2;

	public DummyStruct (int d1, int d2) {
		dummy1 = d1;
		dummy2 = d2;
	}
}

public static int main (string[] args) {
	HashTable<string, DummyObject> table1 = new HashTable<string, DummyObject> (str_hash, str_equal);
	table1.insert ("str", new DummyObject ());

	HashTable<int, DummyObject> table2 = new HashTable<int, DummyObject> (direct_hash, direct_equal);
	table2.insert (1, new DummyObject ());

	HashTable<int?, DummyObject> table3 = new HashTable<int?, DummyObject> (int_hash, int_equal);
	//table3.insert (null, new DummyObject ()); -> segfault
	table3.insert (1, new DummyObject ());

	HashTable<Object, DummyObject> table4 = new HashTable<Object, DummyObject> (direct_hash, direct_equal);
	table4.insert (new DummyObject (), new DummyObject ());

	HashTable<DummyStruct?, DummyObject> table5 = new HashTable<DummyStruct?, DummyObject> ((k) => {
		return int_hash (k.dummy1) ^ int_hash (k.dummy2);
	}, (k1, k2) => {
		return k1 == k2;
	});
	table5.insert (DummyStruct (1, 2), new DummyObject ());

	return 0;
}
