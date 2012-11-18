public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	VolumeMonitor monitor = VolumeMonitor.get ();

	//
	// The Volume (=logical drive):
	//

	// Print a list of the volumes on the system:
	stdout.printf ("Volumes:\n");
	List<Volume> volumes = monitor.get_volumes (); 
	foreach (Volume volume in volumes) {
		stdout.printf (" - %s\n", volume.get_name ());
	}


	// * Signals:

	monitor.volume_added.connect ((volume) => {
		stdout.printf ("Volume added: %s\n", volume.get_name ());
	});

	monitor.volume_changed.connect ((volume) => {
		stdout.printf ("Volume changed: %s\n", volume.get_name ());
	});

	monitor.volume_removed.connect ((volume) => {
		stdout.printf ("Volume removed: %s\n", volume.get_name ());
	});


	//
	// Drive: (connected hardware)
	//

	// Print a list of drives connected to the system:
	stdout.printf ("Drives:\n");
	List<Drive> drives = monitor.get_connected_drives ();
	foreach (Drive drive in drives) {
		stdout.printf (" - %s\n", drive.get_name ());
	}


	// * Signals:

	monitor.drive_changed.connect ((drive) => {
		stdout.printf ("Drive changed: %s\n", drive.get_name ());
	});

	monitor.drive_connected.connect ((drive) => {
		stdout.printf ("Drive connected: %s\n", drive.get_name ());
	});

	monitor.drive_disconnected.connect ((drive) => {
		stdout.printf ("Drive disconnected: %s\n", drive.get_name ());
	});

	monitor.drive_eject_button.connect ((drive) => {
		stdout.printf ("Drive eject-button: %s\n", drive.get_name ());
	});

	monitor.drive_stop_button.connect ((drive) => {
		stdout.printf ("Drive stop-button:%s\n", drive.get_name ());
	});


	//
	// Mount: (user-visible mounted filesystem that you can access)
	//

	//  Print a list of the mounts on the system:
	List<Mount> mounts = monitor.get_mounts ();
	foreach (Mount mount in mounts) {
		stdout.printf (" - %s\n", mount.get_name ());
	}

	// * Signals:

	monitor.mount_added.connect ((mount) => {
		stdout.printf ("Mount added: %s\n", mount.get_name ());
	});

	monitor.mount_changed.connect ((mount) => {
		stdout.printf ("Mount changed: %s\n", mount.get_name ());
	});

	monitor.mount_pre_unmount.connect ((mount) => {
		stdout.printf ("Mount pre-unmount: %s\n", mount.get_name ());
	});

	monitor.mount_removed.connect ((mount) => {
		stdout.printf ("Mount removed: %s\n", mount.get_name ());
	});

	loop.run ();
	return 0;
}
