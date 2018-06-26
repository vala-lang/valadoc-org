public class Calculation : Object {
	public char op;
	public int a;
	public int b;

	public Calculation (char op, int a, int b) {
		this.op = op;
		this.a = a;
		this.b = b;
	}
}

public static int main (string[] args) {
	if (Thread.supported () == false) {
		print ("Threads are not supported.\n");
		return 0;
	}

	AsyncQueue<Calculation> jobs = new AsyncQueue<Calculation> ();

	ThreadFunc<bool> worker_func = () => {
		while (true) {
			Calculation calc = jobs.pop ();
			switch (calc.op) {
			case '+':
				print ("Thread %p: %d + %d = %d\n", Thread<bool>.self<bool> (), calc.a, calc.b, calc.a + calc.b);
				break;

			case '-':
				print ("Thread %p: %d - %d = %d\n", Thread<bool>.self<bool> (), calc.a, calc.b, calc.a - calc.b);
				break;

			case '*':
				print ("Thread %p: %d * %d = %d\n", Thread<bool>.self<bool> (), calc.a, calc.b, calc.a * calc.b);
				break;

			case '/':
				print ("Thread %p: %d / %d = %d\n", Thread<bool>.self<bool> (), calc.a, calc.b, calc.a / calc.b);
				break;

			case '\0':
				return true;

			default:
				assert_not_reached ();
			}
		}
	};

	// Start threads:
	Thread<bool> thread1 = new Thread<bool> ("thread-1", worker_func);
	Thread<bool> thread2 = new Thread<bool> ("thread-2", worker_func);

	while (true) {
		print ("Operator: (+,-,*,/, exit)\n");
		string line = stdin.read_line ()._strip ();

		if (line == "exit") {
			break;
		}

		char op = '\0';
		int a = 0;
		int b = 0;

		switch (line) {
		case "+": op = '+'; break;
		case "-": op = '-'; break;
		case "*": op = '*'; break;
		case "/": op = '/'; break;
		default: print ("Invalid operator\n"); continue;
		}

		print ("Value 1:\n");
		a = int.parse (stdin.read_line ()._strip ());

		print ("Value 2:\n");
		b = int.parse (stdin.read_line ()._strip ());

		jobs.push (new Calculation (op, a, b));
	}

	// Quit all threads:
	jobs.push (new Calculation (0, 0, 0));
	jobs.push (new Calculation (0, 0, 0));
	thread1.join ();
	thread2.join ();
	jobs = null;
	return 0;
}
