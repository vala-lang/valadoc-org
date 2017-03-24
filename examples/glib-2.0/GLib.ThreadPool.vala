class Worker {
	public string thread_name { private set; get; }
    public int x_times { private set; get; }
	public int priority { private set; get; }

    public Worker (string name, int x, int priority) {
		this.priority = priority;
		this.thread_name = name;
		this.x_times = x;
    }

	public void run () {
		for (int i = 0; i < this.x_times ; i++) {
			print ("%s: %d/%d\n", this.thread_name, i + 1, this.x_times);
			Thread.usleep (1000000); // wait a second
		}
	}
}


public static int main (string[] args) {
	try {
		ThreadPool<Worker> pool = new ThreadPool<Worker>.with_owned_data ((worker) => {
			// Call worker.run () on thread-start
			worker.run ();
		}, 3, false);

		// Define a priority (otpional)
		pool.set_sort_function ((worker1, worker2) => {
			// A simple priority-compare, qsort-style
			return (worker1.priority < worker2.priority)? -1 : (int) (worker1.priority > worker2.priority);
		});

		// Assign some tasks:
		pool.add (new Worker ("Thread 1", 5, 4));
		pool.add (new Worker ("Thread 2", 10, 3));
		pool.add (new Worker ("Thread 4", 5, 2));
		pool.add (new Worker ("Thread 5", 5, 1));

		uint waiting = pool.unprocessed ();		// unfinished workers = 4
		uint allowed = pool.get_max_threads (); // max running threads = 3
		uint running = pool.get_num_threads (); // running threads = 3
		print ("%u/%u threads are running, %u outstanding.\n", running, allowed, waiting);
	} catch (ThreadError e) {
		print ("ThreadError: %s\n", e.message);
	}
	
	return 0;
}
