public static void print_mount (Mount mount, string title) {
	print ("%s:\n", title);

	print ("  name: %s\n", mount.get_name ());
	print ("  uuid: %s\n", mount.get_uuid ());
	print ("  can-eject: %s\n", mount.can_eject ().to_string ());
	print ("  can-unmount: %s\n", mount.can_unmount ().to_string ());
	print ("  is-shadowed: %s\n", mount.is_shadowed ().to_string ());
	print ("  default-location: %s\n", mount.get_default_location ().get_path ());
	print ("  icon: %s\n", mount.get_icon ().to_string ());
	print ("  root: %s\n", mount.get_root ().get_path ());

	try {
		string[] types = mount.guess_content_type_sync (false);
		print ("  guess-content-type:\n");
		foreach (unowned string type in types) {
			print ("    %s\n", type);
		}
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
}

public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	VolumeMonitor monitor = VolumeMonitor.get ();

	//  Print a list of the mounts on the system:
	List<Mount> mounts = monitor.get_mounts ();
	foreach (Mount mount in mounts) {
		print_mount (mount, "Available");
	}


	// Emitted when a mount is added:
	monitor.mount_added.connect ((mount) => {
		print_mount (mount, "Mount added");
	});

	// Emitted when a mount changes:
	monitor.mount_changed.connect ((mount) => {
		// See GLib.Mount.changed
		print_mount (mount, "Mount changed");
	});

	// Emitted when a mount is about to be removed:
	monitor.mount_pre_unmount.connect ((mount) => {
		// See GLib.Mount.pre_unmount
		print_mount (mount, "Mount pre-unmount");
	});

	// Emitted when a mount is removed:
	monitor.mount_removed.connect ((mount) => {
		// See GLib.Mount.unmounted
		print_mount (mount, "Mount removed");
	});

	loop.run ();
	return 0;
}
