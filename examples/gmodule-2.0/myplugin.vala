// The plugin:
private class MyPlugin : Object, PluginIface {
	public void registered (PluginLoader loader) {
    	stdout.puts ("loaded\n");
	}

    public void activated () {
    	stdout.puts ("activate\n");
    }

    public void deactivated () {
    	stdout.puts ("deactivatev");
    }
}

public Type register_plugin (Module module) {
    return typeof (MyPlugin);
}
