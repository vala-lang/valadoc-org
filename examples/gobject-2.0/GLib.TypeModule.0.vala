public class MyClass : Object {
	static construct {
		message("MyClass init");
	}
	
	static ~MyClass() {
		message("MyClass deinit");
	}
}

[ModuleInit]
Type plugin_init(GLib.TypeModule type_modul) {
	return typeof(MyClass);
}
