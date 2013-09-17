// Shared library:
public errordomain PluginError {
	NOT_SUPPORTED,
	UNEXPECTED_TYPE,
	NO_REGISTRATION_FUNCTION,
	FAILED
}

public interface PluginIface : Object {
	public abstract void registered (PluginLoader loader);
    public abstract void activated ();
    public abstract void deactivated ();

	// get_desctiption (), get_name (), ...
}

private class PluginInfo : Object {
	public Module module;
	public Type gtype;

	public PluginInfo (Type type, owned Module module) {
		this.module = (owned) module;
		this.gtype = type;
	}
}

public class PluginLoader : Object {
	[CCode (has_target = false)]
	private delegate Type RegisterPluginFunction (Module module);

	private PluginIface[] plugins = new PluginIface[0];
	private PluginInfo[] infos = new PluginInfo[0];

	public PluginIface load (string path) throws PluginError {
		if (Module.supported () == false) {
			throw new PluginError.NOT_SUPPORTED ("Plugins are not supported");
		}

		Module module = Module.open (path, ModuleFlags.BIND_LAZY);
		if (module == null) {
			throw new PluginError.FAILED (Module.error ());
		}

        void* function;
        module.symbol ("register_plugin", out function);
		if (function == null) {
			throw new PluginError.NO_REGISTRATION_FUNCTION ("register_plugin () not found");
		}

        RegisterPluginFunction register_plugin = (RegisterPluginFunction) function;
		Type type = register_plugin (module);
		if (type.is_a (typeof (PluginIface)) == false) {
			throw new PluginError.UNEXPECTED_TYPE ("Unexpected type");
		}

		PluginInfo info = new PluginInfo (type, (owned) module);
		infos += info;

		PluginIface plugin = (PluginIface) Object.new (type);
		plugins += plugin;
		plugin.registered (this);

		return plugin;
	}

	// ...
}
