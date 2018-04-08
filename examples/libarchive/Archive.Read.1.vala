public static int main (string[] args) {
    int8[] buffer = null;
    Archive.Read archive = new Archive.Read ();
    archive.support_filter_all ();
    archive.support_format_raw ();

    if (archive.open_filename ("archive.tar.gz", 16384) != Archive.Result.OK) {
        error ("Error: %s (%d)", archive.error_string (), archive.errno ());
    }

    unowned Archive.Entry entry;
    if (archive.next_header (out entry) != Archive.Result.OK) {
        error ("Error: %s (%d)", archive.error_string (), archive.errno ());
    }

    ssize_t size;
    while ((size = archive.read_data (buffer, buffer.length)) > 0) {
        // Write the content of the buffer
    }

    if (archive.close () != Archive.Result.OK) {
        error ("Error: %s (%d)", archive.error_string (), archive.errno ());
    }

    return 0;
}
