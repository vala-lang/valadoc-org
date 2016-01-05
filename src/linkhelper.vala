/* linkhelper.vala
 *
 * Copyright (C) 20012 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


public class Valadoc.ValadocOrgLinkHelper : Valadoc.Html.LinkHelper {
	public override string? get_package_link (Api.Package package, Settings settings) {
		return Path.build_filename ("/", package.name, "index.htm");
	}

	protected override string? from_package_to_package (Api.Package from, Api.Package to) {
		return Path.build_filename ("/", to.name, "index.htm");
	}

	protected override string? from_package_to_wiki (Api.Package from, WikiPage to) {
		return Path.build_filename ("/", _settings.pkg_name, translate_wiki_name (to));
	}

	protected override string? from_package_to_node (Api.Package from, Api.Node to) {
		return Path.build_filename ("/", to.package.name, to.get_full_name () + ".html");
	}

	protected override string? from_wiki_to_package (WikiPage from, Api.Package to) {
		return Path.build_filename ("/", to.name, "index.htm");
	}

	protected override string? from_wiki_to_wiki (WikiPage from, WikiPage to) {
		return Path.build_filename ("/", _settings.pkg_name, translate_wiki_name (to));
	}

	protected override string? from_wiki_to_node (WikiPage from, Api.Node to) {
		return Path.build_filename ("/", to.package.name, to.get_full_name () + ".html");
	}

	protected override string? from_node_to_package (Api.Node from, Api.Package to) {
		return Path.build_filename ("/", to.name, "index.htm");
	}

	protected override string? from_node_to_wiki (Api.Node from, WikiPage to) {
		return Path.build_filename ("/", _settings.pkg_name, translate_wiki_name (to));
	}

	protected override string? from_node_to_node (Api.Node from, Api.Node to) {
		return Path.build_filename ("/", to.package.name, to.get_full_name() + ".html");
	}
 }
