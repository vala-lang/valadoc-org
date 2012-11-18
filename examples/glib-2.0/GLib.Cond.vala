public class Context : Object {
	private Cond data_cond = Cond ();
	private Mutex data_mutex = Mutex ();
	private string current_data = null;

	private void push_data (string data) {
		stdout.printf ("=> push_data: lock\n");
		data_mutex.lock ();
		stdout.printf ("=> push_data: set data\n");
		current_data = data;
		data_cond.signal ();
		stdout.printf ("=> push_data: unlock\n");
		data_mutex.unlock ();
	}

	private string pop_data () {
		stdout.printf ("<= pop_data: lock\n");
		data_mutex.lock ();
		while (current_data == null) {
			data_cond.wait (data_mutex);
		}
		stdout.printf ("<= pop_data: get data\n");
		string data = (owned) current_data;
		stdout.printf ("<= pop_data: unlock\n");
		data_mutex.unlock ();
		return data;
	}

	public void run () {
		Thread<bool> thread2 = new Thread<bool> ("pop-data", () => {
			stdout.printf ("Thread start:\n");
			this.pop_data ();
			return true;
		});

		Thread.usleep (1000000);
		this.push_data ("data");
		thread2.join ();

		// Possible output:
		//  ``<= pop_data: lock``
		//  ``=> push_data: lock``
		//  ``=> push_data: set data``
		//  ``=> push_data: unlock``
		//  ``<= pop_data: get data``
		//  ``<= pop_data: unlock``
	}

	public static int main (string[] args) {
		Context context = new Context ();
		context.run ();
		return 0;
	}
}
