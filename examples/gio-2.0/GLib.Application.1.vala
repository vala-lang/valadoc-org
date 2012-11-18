public class MyApplication : Application {
	private MyApplication () {
		Object (application_id: "org.example.application", flags: 0);
		set_inactivity_timeout (10000);
		add_actions ();
	}

	private void add_actions () {
		SimpleAction simple_action = new SimpleAction ("simple-action", null);
		simple_action.activate.connect (() => {
			this.hold ();
			stdout.printf ("simple action %s activated\n", simple_action.get_name ());
			this.release ();
		});
		this.add_action (simple_action);

		SimpleAction stateful_action = new SimpleAction.stateful ("toggle-action", null, new Variant.boolean (false));
		stateful_action.activate.connect (() => {
			stdout.printf ("action %s activated\n", stateful_action.get_name ());

			this.hold ();
			Variant state = stateful_action.get_state ();
			bool b = state.get_boolean ();
			stateful_action.set_state (new Variant.boolean (!b));
			stdout.printf ("state change %s -> %s\n", b.to_string (), (!b).to_string ());
			this.release ();
		});
		this.add_action (stateful_action);
	}

	public override void activate () {
		this.hold ();
		stdout.puts ("activated\n");
		this.release ();
	}

	private void describe_and_activate_action (string name) {
		VariantType param_type = this.get_action_parameter_type (name);
		Variant state = this.get_action_state (name);
		bool enabled = this.get_action_enabled (name);

		stdout.printf ("action name:      %s\n", name);
		string? tmp = (param_type != null)? param_type.dup_string () : "<none>";
		stdout.printf ("parameter type:   %s\n", tmp);

		stdout.printf ("state type:       %s\n", (state != null)? state.get_type_string () : "<none>");
		tmp = (state != null)? state.print (false) : "<none>";
		stdout.printf ("state:            %s\n", tmp);
		stdout.printf ("enabled:          %s\n", enabled.to_string ());

		this.activate_action (name, null);
	}

	public static int main (string[] args) {
		try {
			MyApplication app = new MyApplication ();

			if (args.length > 1) {
				if (args[1] == "--simple-action") {
					app.register (null);
					app.describe_and_activate_action ("simple-action");
					Process.exit (0);
				} else if (args[1] == "--toggle-action") {
					app.register (null);
					app.describe_and_activate_action ("toggle-action");
					Process.exit (0);
				}
			}

			int status = app.run (args);
			return status;
		} catch (Error e) {
			stdout.printf ("Error: %s\n", e.message);
			return 0;
		}
	}
}
