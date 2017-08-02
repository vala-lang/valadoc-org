public void print_volume (Volume volume, string title) {
	print ("%s:\n", title);
	print ("  name: %s\n", volume.get_name ());
	print ("  uuid: %s\n", volume.get_uuid ());
	print ("  can-eject: %s\n", volume.can_eject ().to_string ());
	print ("  can-mount: %s\n", volume.can_mount ().to_string ());
	print ("  should-automount: %s\n", volume.should_automount ().to_string ());
	print ("  sort-key: %s\n", volume.get_sort_key ());
	print ("  icon: %s\n", volume.get_icon ().to_string ());
	string? path = null;
	if (volume.get_activation_root () != null) {
		path = volume.get_activation_root ().get_path ();
	}
	print ("  active-root: %s\n", path);

	print ("  Identifiers:\n");
	string[] kinds = volume.enumerate_identifiers ();
	foreach (unowned string kind in kinds) {
		string identifier = volume.get_identifier (kind);
		print ("    %s=%s\n", kind, identifier);
	}
}


public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	VolumeMonitor monitor = VolumeMonitor.get ();

	print ("Volumes:\n");
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
