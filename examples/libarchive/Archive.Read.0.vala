public static int main (string[] args) {
    Archive.Read archive = new Archive.Read ();
    archive.support_filter_all ();
    archive.support_format_all ();

    if (archive.open_filename ("archive.tar", 10240) != Archive.Result.OK) {
        error ("Error: %s (%d)", archive.error_string (), archive.errno ());
    }

    unowned Archive.Entry entry;
    while (archive.next_header (out entry) == Archive.Result.OK) {
        message (entry.pathname ());
        archive.read_data_skip ();
    }

    if (archive.close () != Archive.Result.OK) {
        error ("Error: %s (%d)", archive.error_string (), archive.errno ());
    }

    return 0;
}
