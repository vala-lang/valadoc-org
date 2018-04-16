public class Context : Object {
	// Lock used to protect data:
	private RWLock rwlock = RWLock ();

	// Shared Data:
	private HashTable<string, string> users = new HashTable<string, string> (str_hash, str_equal);
	private List<string> messages = new List<string> ();

	public Context () {
		users.insert ("root", "123");
		users.insert ("mean", "abc");
		users.insert ("square", "xyz");
	}

	private bool worker_func (string username, string password, string message) {
		// Login:
		rwlock.reader_lock ();
		string? stored_pw = users.lookup (username);
		rwlock.reader_unlock ();
		if (stored_pw == null || stored_pw != password) {
			print ("%s: Invalid user name or password\n", username);
			return false;
		}

		// Read all messages:
		rwlock.reader_lock ();
		messages.foreach ((str) => {
			print ("%s: %s\n", username, str);
		});
		rwlock.reader_unlock ();


		// Share a message:		
		rwlock.writer_lock ();
		messages.append (message);
		rwlock.writer_unlock ();

		return true;
	}

	public void run () {
		Thread<bool> worker1 = new Thread<bool> ("worker-1", () => {
			string username = "root";
			string password = "123";
			string message = "roots message";
			return worker_func (username, password, message);
		});

		Thread<bool> worker2 = new Thread<bool> ("worker-2", () => {
			string username = "mean";
			string password = "abc";
			string message = "abcs message";
			return worker_func (username, password, message);
		});

		Thread<bool> worker3 = new Thread<bool> ("worker-3", () => {
			string username = "square";
			string password = "xyz";
			string message = "squares message";
			return worker_func (username, password, message);
		});

		worker1.join ();
		worker2.join ();
		worker3.join ();
	}

	public static int main (string[] args) {
		if (Thread.supported () == false) {
			print ("Threads are not supported.\n");
			return 0;
		}

		// Output:
		//  ``mean: squares message``
		//  ``root: squares message``
		//  ``root: abcs message``
		// OR
		//  ``square: abcs message``
		//  ``square: roots message``
		// OR
		//  ``root: squares message``
		//  ``mean: squares message``
		// OR
		//  ``square: abcs message``
		// OR
		//  ...
		Context context = new Context ();
		context.run ();
		return 0;
	}
}
