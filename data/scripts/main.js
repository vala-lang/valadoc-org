function get_path (path) {
	var pos = path.lastIndexOf ('/');
	if (pos < 0) {
		return '';
	}

	return path.substring (pos, -1) + '/';
}

function toggle_box (self, id) {
	var element = document.getElementById (id);
	if (element == null) {
		return ;
	}

	var style = self.currentStyle || window.getComputedStyle (self, false);
	var orig_path = /url[ \t]*\(('(.*)'|"(.*)")\)/.exec (style.backgroundImage)[1].slice(1, -1);
	var orig_dir = get_path (orig_path);
	if (element.style.display == 'block') {
		element.style.display = 'none';
		self.style.backgroundImage = "url('" + orig_dir + 'coll_open.svg' + "')";
	} else {
		element.style.display = 'block';
		self.style.backgroundImage = "url('" + orig_dir + 'coll_close.svg' + "')";
	}
}

