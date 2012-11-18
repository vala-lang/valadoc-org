public class MyThread : Object {
	public ThreadPriority priority { get; private set; }
	public int x_times { get; private set; }

	public MyThread (int times, ThreadPriority priority) {
		this.priority = priority;
		this.x_times = times;
	}

	public int run () {
		// set the priority:
		Thread.self<int> ().set_priority (ThreadPriority.URGENT);

		for (int i = 0; i < this.x_times; i++) {
			stdout.printf ("ping! %d/%d\n", i + 1, this.x_times);
			Thread.usleep (10000);
		}

		// return & exit have the same effect
		Thread.exit (42);
		return 43;
	}
}

public static int main (string[] args) {
	// Check whether threads are supported:
	if (Thread.supported () == false) {
		stderr.printf ("Threads are not supported!\n");
		return -1;
	}

	try {
		// Start a thread:
		MyThread my_thread = new MyThread (10, ThreadPriority.URGENT);
		Thread<int> thread = new Thread<int>.try ("My fst. thread", my_thread.run);

		// Count all running threads:
		int threads = 0;
		Thread.foreach (() => {
			threads++;
		});

		// Output: ``Running threads: 0``
		stdout.printf ("Running threads: %d\n", threads);

		// Wait until thread finishes:
		int result = thread.join ();
		// Output: `Thread stopped! Return value: 42`
		stdout.printf ("Thread stopped! Return value: %d\n", result);
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
