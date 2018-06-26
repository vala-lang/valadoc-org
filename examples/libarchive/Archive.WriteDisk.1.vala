public void extract (string filename) {
    // Select which attributes we want to restore.
    Archive.ExtractFlags flags;
    flags = Archive.ExtractFlags.TIME;
    flags |= Archive.ExtractFlags.PERM;
    flags |= Archive.ExtractFlags.ACL;
    flags |= Archive.ExtractFlags.FFLAGS;

    Archive.Read archive = new Archive.Read ();
    archive.support_format_all ();
    archive.support_compression_all ();

    Archive.WriteDisk extractor = new Archive.WriteDisk ();
    extractor.set_options (flags);
    extractor.set_standard_lookup ();

    if (archive.open_filename (filename, 10240) != Archive.Result.OK) {
        critical ("Error opening %s: %s (%d)", filename, archive.error_string (), archive.errno ());
        return;
    }

    unowned Archive.Entry entry;
    Archive.Result last_result;
    while ((last_result = archive.next_header (out entry)) == Archive.Result.OK) {
        if (extractor.write_header (entry) != Archive.Result.OK) {
            continue;
        }

        void* buffer = null;
        size_t buffer_length;
        Posix.off_t offset;
        while (archive.read_data_block (out buffer, out buffer_length, out offset) == Archive.Result.OK) {
            if (extractor.write_data_block (buffer, buffer_length, offset) != Archive.Result.OK) {
                break;
            }
        }
    }

    if (last_result != Archive.Result.EOF) {
        critical ("Error: %s (%d)", archive.error_string (), archive.errno ());
    }
}

public static int main (string[] args) {
    for (int i = 1; i < args.length; i++) {
        extract (args[i]);
    }

    return 0;
}
