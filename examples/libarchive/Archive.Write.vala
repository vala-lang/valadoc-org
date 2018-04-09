public static int main (string[] args) {
    if (args.length <= 2) {
        error ("Usage: [ARCHIVE] [FILE]");
    }

    string outname = args[1];

    GLib.File parent_working_dir = GLib.File.new_for_path (".");

    // Create the tar.gz archive named according the the first argument.
    Archive.Write archive = new Archive.Write ();
    archive.add_filter_gzip ();
    archive.set_format_pax_restricted ();
    archive.open_filename (outname);

    // Add all the other arguments into the archive
    for (int i = 2; i < args.length; i++) {
        GLib.File file = GLib.File.new_for_path (args[i]);
        try {
            GLib.FileInfo file_info = file.query_info (GLib.FileAttribute.STANDARD_SIZE, GLib.FileQueryInfoFlags.NONE);
            FileInputStream input_stream = file.read ();
            DataInputStream data_input_stream = new DataInputStream (input_stream);

            // Add an entry to the archive
            Archive.Entry entry = new Archive.Entry ();
            entry.set_pathname (parent_working_dir.get_relative_path (file));
            entry.set_size (file_info.get_size ());
            entry.set_filetype ((uint)Posix.S_IFREG);
            entry.set_perm (0644);
            if (archive.write_header (entry) != Archive.Result.OK) {
                critical ("Error writing '%s': %s (%d)", file.get_path (), archive.error_string (), archive.errno ());
                continue;
            }

            // Add the actual content of the file
            size_t bytes_read;
            uint8[] buffer = new uint8[64];
            while (data_input_stream.read_all (buffer, out bytes_read)) {
                if (bytes_read <= 0) {
                    break;
                }

                archive.write_data (buffer, bytes_read);
            }
        } catch (Error e) {
            critical (e.message);
        }
    }

    if (archive.close () != Archive.Result.OK) {
        error ("Error : %s (%d)", archive.error_string (), archive.errno ());
    }

    return 0;
}
