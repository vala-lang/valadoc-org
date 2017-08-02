public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	VolumeMonitor monitor = VolumeMonitor.get ();

	//
	// The Volume (=logical drive):
	//

	// Print a list of the volumes on the system:
	print ("Volumes:\n");
	List<Volume> volumes = monitor.get_volumes (); 
	foreach (Volume volume in volumes) {
		print (" - %s\n", volume.get_name ());
	}


	// * Signals:

	monitor.volume_added.connect ((volume) => {
		print ("Volume added: %s\n", volume.get_name ());
	});

	monitor.volume_changed.connect ((volume) => {
		print ("Volume changed: %s\n", volume.get_name ());
	});

	monitor.volume_removed.connect ((volume) => {
		print ("Volume removed: %s\n", volume.get_name ());
	});


	//
	// Drive: (connected hardware)
	//

	// Print a list of drives connected to the system:
	print ("Drives:\n");
	List<Drive> drives = monitor.get_connected_drives ();
	foreach (Drive drive in drives) {
		print (" - %s\n", drive.get_name ());
	}


	// * Signals:

	monitor.drive_changed.connect ((drive) => {
		print ("Drive changed: %s\n", drive.get_name ());
	});

	monitor.drive_connected.connect ((drive) => {
		print ("Drive connected: %s\n", drive.get_name ());
	});

	monitor.drive_disconnected.connect ((drive) => {
		print ("Drive disconnected: %s\n", drive.get_name ());
	});

	monitor.drive_eject_button.connect ((drive) => {
		print ("Drive eject-button: %s\n", drive.get_name ());
	});

	monitor.drive_stop_button.connect ((drive) => {
		print ("Drive stop-button:%s\n", drive.get_name ());
	});


	//
	// Mount: (user-visible mounted filesystem that you can access)
	//

	//  Print a list of the mounts on the system:
	List<Mount> mounts = monitor.get_mounts ();
	foreach (Mount mount in mounts) {
		print (" - %s\n", mount.get_name ());
	}

	// * Signals:

	monitor.mount_added.connect ((mount) => {
		print ("Mount added: %s\n", mount.get_name ());
	});

	monitor.mount_changed.connect ((mount) => {
		print ("Mount changed: %s\n", mount.get_name ());
	});

	monitor.mount_pre_unmount.connect ((mount) => {
		print ("Mount pre-unmount: %s\n", mount.get_name ());
	});

	monitor.mount_removed.connect ((mount) => {
		print ("Mount removed: %s\n", mount.get_name ());
	});

	loop.run ();
	return 0;
}
