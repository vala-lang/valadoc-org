public class MyContainer : Gtk.Container {
    private Gtk.Widget _title;
    private Gtk.Widget _child;

    public MyContainer () {
        base.set_has_window (false);
        base.set_can_focus (true);
        base.set_redraw_on_allocate (false);

        this._title = new Gtk.Label.with_mnemonic ("Title");
        this._title.set_parent (this);

        this._child = null;
    }

    public override void add (Gtk.Widget widget) {
        if ( this._child == null ) {
            widget.set_parent (this);
            this._child = widget;
        }
    }

    public override void remove (Gtk.Widget widget) {
        if (this._child == widget) {
            widget.unparent ();
            this._child = null;
            if (this.get_visible () && widget.get_visible ()) {
                this.queue_resize_no_redraw ();
            }
        }
    }

    public override void forall_internal (bool include_internals, Gtk.Callback callback) {
        if (this._title != null) {
            callback (this._title);
        }
        if (this._child != null) {
            callback (this._child);
        }
    }

    public override Gtk.SizeRequestMode get_request_mode () {
        if (this._child != null) {
            return this._child.get_request_mode ();
        } else {
            return Gtk.SizeRequestMode.HEIGHT_FOR_WIDTH;
        }
    }

    public Gtk.Widget get_child () {
        return this._child;
    }

    public override void size_allocate (Gtk.Allocation allocation) {
        Gtk.Allocation title_allocation = Gtk.Allocation ();
        Gtk.Allocation child_allocation = Gtk.Allocation ();
        uint border_width = this.get_border_width ();
        if (this._title != null && this._title.get_visible ()) {
            title_allocation.x = allocation.x + (int) border_width;
            title_allocation.y = allocation.y + (int) border_width;
            title_allocation.width = allocation.width - 2 * (int) border_width;
            title_allocation.height = 24;
            this._title.size_allocate (title_allocation);
            if (this.get_realized ()) {
                this._title.show ();
            }
        }
        if (this._child != null && this._child.get_visible ()) {
            child_allocation.x = allocation.x + (int) border_width;
            child_allocation.y = allocation.y + 24 + (int) border_width;
            child_allocation.width = allocation.width - 2 * (int) border_width;
            child_allocation.height = allocation.height - 24 - 2 * (int) border_width;
            this._child.size_allocate (child_allocation);
            if (this.get_realized ()) {
                this._child.show ();
            }
        }
        if (this.get_realized ()) {
            if (this._title != null) {
                this._title.set_child_visible (true);
            }
            if (this._child != null) {
                this._child.set_child_visible (true);
            }
        }
        base.size_allocate (allocation);
    }

    public new void get_preferred_size (out Gtk.Requisition minimum_size,
										out Gtk.Requisition natural_size)
	{
        Gtk.Requisition title_minimum_size = {0, 0};
        Gtk.Requisition title_natural_size = {0, 0};
        Gtk.Requisition child_minimum_size = {0, 0};
        Gtk.Requisition child_natural_size = {0, 0};

        if (this._title != null && this._title.get_visible ()) {
            this._title.get_preferred_size (out title_minimum_size, out title_natural_size);
        }
        if (this._child != null && this._child.get_visible ()) {
            this._child.get_preferred_size (out child_minimum_size, out child_natural_size);
        }

        minimum_size = {0, 0};
        natural_size = {0, 0};

        minimum_size.width = int.max (title_minimum_size.width, child_minimum_size.width);
        minimum_size.height = title_minimum_size.height + child_minimum_size.height;
        natural_size.width = int.max (title_natural_size.width, child_natural_size.width);
        natural_size.height = title_natural_size.height + child_natural_size.height;
    }

    public override bool draw (Cairo.Context cr) {
        base.draw (cr);
        return false;
    }
}

public static int main (string[] args) {
    Gtk.init (ref args);

    Gtk.Window window = new Gtk.Window();
    window.set_title ("Custom container");
    window.set_default_size (500, 300);

    MyContainer custom = new MyContainer ();
    Gtk.Button button = new Gtk.Button.with_label ("Child");
    button.set_visible (true);
    custom.add (button);

    window.add (custom);
    window.show_all();
    window.destroy.connect( s => Gtk.main_quit());

    Gtk.main ();
    return 0;
}
