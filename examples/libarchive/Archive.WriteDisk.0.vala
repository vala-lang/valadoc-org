public static int main (string[] args) {
    Archive.WriteDisk archive = new Archive.WriteDisk ();
    archive.set_options (Archive.ExtractFlags.TIME);

    Archive.Entry entry = new Archive.Entry ();
    entry.set_pathname("my_file.txt");
    entry.set_filetype ((uint)Posix.S_IFREG);
    entry.set_size (5);
    entry.set_mtime (123456789, 0);

    archive.write_header (entry);
    archive.write_data ("abcde".data, 5);
    if (archive.close () != Archive.Result.OK) {
        error ("Error : %s (%d)", archive.error_string (), archive.errno ());
    }

    return 0;
}
