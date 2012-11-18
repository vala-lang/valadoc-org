public void print_drive (Drive drive, string title) {
	stdout.printf ("%s:\n", title);
	stdout.printf ("  name: %s\n", drive.get_name ());
	stdout.printf ("  can-eject: %s\n", drive.can_eject ().to_string ());
	stdout.printf ("  can-poll-for-media: %s\n", drive.can_poll_for_media ().to_string ());
	stdout.printf ("  can-start: %s\n", drive.can_start ().to_string ());
	stdout.printf ("  can-start-degraded: %s\n", drive.can_start_degraded ().to_string ());
	stdout.printf ("  can-stop: %s\n", drive.can_stop ().to_string ());
	stdout.printf ("  has-volumes: %s\n", drive.has_volumes ().to_string ());
	stdout.printf ("  has-media: %s\n", drive.has_media ().to_string ());
	stdout.printf ("  is-media-check-automatic: %s\n", drive.is_media_check_automatic ().to_string ());
	stdout.printf ("  is-media-removable: %s\n", drive.is_media_removable ().to_string ());
	stdout.printf ("  start-stop-type: %s\n", drive.get_start_stop_type ().to_string ());

	string[] kinds = drive.enumerate_identifiers ();
	foreach (unowned string kind in kinds) {
		stdout.printf ("    %s = %s\n", kind, drive.get_identifier (kind));
	}
}

public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	VolumeMonitor monitor = VolumeMonitor.get ();


	// Print a list of drives connected to the system:
	List<Drive> drives = monitor.get_connected_drives ();
	foreach (Drive drive in drives) {
		print_drive (drive, "Connected");
	}


	// Emitted when a drive is connected to the system:
	monitor.drive_connected.connect ((drive) => {
		print_drive (drive, "Drive connected");

		// Reject all newly connected drives:
		drive.eject_with_operation.begin (MountUnmountFlags.FORCE, null, null, (obj, res) => {
			try {
				bool status = drive.eject_with_operation.end (res);
				stdout.printf ("eject: %s: %s\n", drive.get_name (), status.to_string ());
			} catch (Error e) {
				stdout.printf ("Error: %s\n", e.message);
			}
		});
	});


	// Emitted when a drive changes:
	monitor.drive_changed.connect ((drive) => {
		// See GLib.Drive.changed
		print_drive (drive, "Drive changed");
	});


	// Emitted when a drive is disconnected from the system:
	monitor.drive_disconnected.connect ((drive) => {
		// See GLib.Drive.disconnected
		print_drive (drive, "Drive disconnected");
	});


	// Emitted when the eject button is pressed on drive:
	monitor.drive_eject_button.connect ((drive) => {
		// See GLib.Drive.eject_button
		print_drive (drive, "Drive eject-button");
	});


	// Emitted when the stop button is pressed on drive:
	monitor.drive_stop_button.connect ((drive) => {
		// See GLib.Drive.stop_button
		print_drive (drive, "Drive stop-button");
	});

	loop.run ();
	return 0;
}
