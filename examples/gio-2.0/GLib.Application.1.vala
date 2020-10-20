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
			print ("Simple action %s activated\n", simple_action.get_name ());
			this.release ();
		});
		this.add_action (simple_action);

		SimpleAction stateful_action = new SimpleAction.stateful ("toggle-action", null, new Variant.boolean (false));
		stateful_action.activate.connect (() => {
			print ("Action %s activated\n", stateful_action.get_name ());

			this.hold ();
			Variant state = stateful_action.get_state ();
			bool b = state.get_boolean ();
			stateful_action.set_state (new Variant.boolean (!b));
			print (@"State change $b -> $(!b)\n");
			this.release ();
		});
		this.add_action (stateful_action);
	}

	public override void activate () {
		this.hold ();
		print ("Activated\n");
		this.release ();
	}

	private void describe_and_activate_action (string name) {
		VariantType param_type = this.get_action_parameter_type (name);
		Variant state = this.get_action_state (name);
		bool enabled = this.get_action_enabled (name);

		print (@"Action name:      $name\n");
		string? type = (param_type != null) ? param_type.dup_string () : "<none>";
		print (@"Parameter type:   $type\n");

		print ("State type:       %s\n", (state != null) ? state.get_type_string () : "<none>");
		string state_val = (state != null) ? state.print (false) : "<none>";
		print (@"State:            $state_val\n");
		print (@"Enabled:          $enabled\n");

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
			print ("Error: %s\n", e.message);
			return 0;
		}
	}
}
