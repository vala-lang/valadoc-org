public static int main (string[] args) {
	if (Thread.supported () == false) {
		print ("Threads are not supported.\n");
		return 0;
	}

	// Mutex used to protect data:
	Mutex mutex = Mutex ();

	// Shared Data: Must not be accessed by more than one thread at once
	int MAX = 100;
	int thread_id = 0;
	int shared = 0;

	ThreadFunc<bool> worker_func = () => {
		// Enter the critical section: Other threads are locked out
		// until unlock () is called
		mutex.lock ();
		int id = thread_id;
		thread_id++;
		mutex.unlock ();
		// Leave the critical section

		while (shared < MAX) {
			// ...

			mutex.lock ();
			int tmp = shared;
			print ("t%d = %d\n", id, tmp);
			shared++;
			mutex.unlock ();

			// ...
			Thread.usleep (10000);
		}
		return true;
	};

	Thread<bool> thread1 = new Thread<bool> ("thread-1", worker_func);
	Thread<bool> thread2 = new Thread<bool> ("thread-2", worker_func);

	thread1.join ();
	thread2.join ();

	return 0;
}

