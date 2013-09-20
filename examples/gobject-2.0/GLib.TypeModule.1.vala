class MyModule : TypeModule {
	[CCode (has_target = false)]
	private delegate Type PluginInitFunc (TypeModule module);
	private GLib.Module module = null;
	private string name = null;
	
	public MyModule (string name) {
		this.name = name;
	}
	
	public override bool load () {
		string path = Module.build_path (null, name);
		module = Module.open (path, GLib.ModuleFlags.BIND_LAZY);
		if (null == module) {
			error ("Module not found");
		}
	
		void* plugin_init = null;
		if (!module.symbol ("plugin_init", out plugin_init)) {
			error ("No such symbol");
		}
		
		((PluginInitFunc) plugin_init) (this);
		
		return true;
	}
	
	public override void unload () {
		module = null;
		
		message ("Library unloaded");
	}
}

// Never unref instances of GLib.TypeModule
static TypeModule module = null;

public int main (string[] args) {
	module = new MyModule ("plugin");
	module.load ();
	
	var o = GLib.Object.new (Type.from_name ("MyClass"));
	// free last instance, plugin unload
	o = null;	
	return 0;
}
