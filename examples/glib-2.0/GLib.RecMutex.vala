public static int main (string[] args) {
	if (Thread.supported () == false) {
		print ("Threads are not supported.\n");
		return 0;
	}

	// Mutex used to protect data:
	RecMutex mutex = RecMutex ();

	// Shared Data: Must not be accessed by more than one thread at once
	int MAX = 100;
	int shared = 0;	
	int thread_id = 0;

	Func<string> inc_counter = (name) => {
		// Enter the critical section: Other threads are locked out
		// until unlock () is called
		// RecMutex allows us to nest critical section without deadlock.
		mutex.lock ();
		int tmp = shared;
		print ("%s=%d\n", name, tmp);
		shared++;
		mutex.unlock ();
		// Leave the critical section
	};

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
			inc_counter ("t%d".printf (id));
			mutex.unlock ();

			// ...
			Thread.usleep (10000);
		}
		return true;
	};

	Thread<bool> thread1 = new Thread<bool> ("thread-1", worker_func);
	Thread<bool> thread2 = new Thread<bool> ("thread-1", worker_func);

	thread1.join ();
	thread2.join ();

	return 0;
}
