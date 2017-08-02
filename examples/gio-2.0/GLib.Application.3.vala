public class MyApplication : Application {
	private MyApplication () {
		Object (application_id: "org.example.application", flags: 0);
		set_inactivity_timeout (10000);
	}

	public override void activate () {
		// NOTE: when doing a longer-lasting action here that returns
		//  to the mainloop, you should use g_application_hold() and
		//  g_application_release() to keep the application alive until
		//  the action is completed.
		print ("Activated\n");
	}

	public override bool dbus_register (DBusConnection connection, string object_path) throws Error {
		// We must chain up to the parent class:
		base.dbus_register (connection, object_path);

		// Now we can do our own stuff here. For example, we could export some D-Bus objects
		return true;
	}

	public override void dbus_unregister (DBusConnection connection, string object_path) {
		// Do our own stuff here, e.g. unexport any D-Bus objects we exported in the dbus_register
		//  hook above. Be sure to check that we actually did export them, since the hook
		//  above might have returned early due to the parent class' hook returning false!

		base.dbus_unregister (connection, object_path);
	}

	public static int main (string[] args) {
		MyApplication app = new MyApplication ();
		int status = app.run (args);
		return status;
	}
}
