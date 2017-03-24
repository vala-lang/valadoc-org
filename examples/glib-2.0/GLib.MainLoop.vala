public static int main (string[] args) {
    MainLoop loop = new MainLoop ();
    TimeoutSource time = new TimeoutSource (2000);

    time.set_callback (() => {
        print ("Time!\n");
        loop.quit ();
        return false;
    });

    time.attach (loop.get_context ());

    loop.run ();
	return 0;
}
