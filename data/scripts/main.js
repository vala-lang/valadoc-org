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
	if (element.style.display == 'block') {
		element.style.display = 'none';
		self.style.backgroundImage = style.backgroundImage.replace('coll_close', 'coll_open');
	} else {
		element.style.display = 'block';
		self.style.backgroundImage = style.backgroundImage.replace('coll_open', 'coll_close');
	}
}
