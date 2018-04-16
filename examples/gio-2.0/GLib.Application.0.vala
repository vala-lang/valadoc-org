public class MyApplication : Application {
	private MyApplication () {
		Object (application_id: "org.example.application", flags: ApplicationFlags.HANDLES_OPEN);
		set_inactivity_timeout (10000);
	}

	public override void activate () {
		// NOTE: when doing a longer-lasting action here that returns
		//  to the mainloop, you should use g_application_hold() and
		//  g_application_release() to keep the application alive until
		//  the action is completed.
	    print ("activated\n");
	}

	public override void open (File[] files, string hint) {
		// NOTE: when doing a longer-lasting action here that returns
		//  to the mainloop, you should use g_application_hold() and
		//  g_application_release() to keep the application alive until
		//  the action is completed.

		foreach (File file in files) {
			string uri = file.get_uri ();
			print (@"$uri\n");
		}
	}

	public static int main (string[] args) {
		MyApplication app = new MyApplication ();
		int status = app.run (args);
		return status;
	}
}
