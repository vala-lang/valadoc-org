// The plugin:
private class MyPlugin : Object, PluginIface {
	public void registered (PluginLoader loader) {
        print ("Loaded\n");
	}

    public void activated () {
    	print ("Activate\n");
    }

    public void deactivated () {
    	print ("Deactivate");
    }
}

public Type register_plugin (Module module) {
    return typeof (MyPlugin);
}
