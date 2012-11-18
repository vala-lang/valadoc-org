public void print_volume (Volume volume, string title) {
	stdout.printf ("%s:\n", title);
	stdout.printf ("  name: %s\n", volume.get_name ());
	stdout.printf ("  uuid: %s\n", volume.get_uuid ());
	stdout.printf ("  can-eject: %s\n", volume.can_eject ().to_string ());
	stdout.printf ("  can-mount: %s\n", volume.can_mount ().to_string ());
	stdout.printf ("  should-automount: %s\n", volume.should_automount ().to_string ());
	stdout.printf ("  sort-key: %s\n", volume.get_sort_key ());
	stdout.printf ("  icon: %s\n", volume.get_icon ().to_string ());
	string? path = null;
	if (volume.get_activation_root () != null) {
		path = volume.get_activation_root ().get_path ();
	}
	stdout.printf ("  active-root: %s\n", path);

	stdout.printf ("  Identifiers:\n");
	string[] kinds = volume.enumerate_identifiers ();
	foreach (unowned string kind in kinds) {
		string identifier = volume.get_identifier (kind);
		stdout.printf ("    %s=%s\n", kind, identifier);
	}
}


public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	VolumeMonitor monitor = VolumeMonitor.get ();

	stdout.printf ("Volumes:\n");
	List<Volume> volumes = monitor.get_volumes (); 
	foreach (Volume volume in volumes) {
		print_volume (volume, "Available");
	}


	// Emitted when a mountable volume is added to the system:
	monitor.volume_added.connect ((volume) => {
		print_volume (volume, "Volume added");
	});

	// Emitted when mountable volume is changed:
	monitor.volume_changed.connect ((volume) => {
		print_volume (volume, "Volume changed");
	});

	// Emitted when a mountable volume is removed from the system:
	monitor.volume_removed.connect ((volume) => {
		print_volume (volume, "Volume removed");
	});

	loop.run ();
	return 0;
}
