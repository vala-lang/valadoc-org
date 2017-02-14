namespace Valadoc.App {

	public errordomain DatabaseError {
		FAILED
	}

	public class Database : GLib.Object, GLib.Initable {

		private Mysql.Database database;

		public string hostname { construct; get; }

		public uint port { construct; get; }

		public Database (string hostname, uint16 port) throws Error {
			base (hostname: hostname, port: port);
			init ();
		}

		construct {
			database = new Mysql.Database ();
		}

		public bool init (Cancellable? cancellable = null) throws Error {
			if (!database.real_connect (hostname, null, null, null, port)) {
				throw new DatabaseError.FAILED (database.error ());
			}
			return true;
		}

		private void _handle_return_code (int rc) throws DatabaseError {
			if (rc != 0)  {
				throw new DatabaseError.FAILED (database.error ());
			}
		}

		public void ping () throws Error {
			_handle_return_code (database.ping ());
		}

		public Result? query (string statement, ...) throws Error {
			var statement_builder = new StringBuilder ();
			var statement_offset = 0;

			var list = va_list ();
			for (var str = list.arg<string?> (); str != null; str = list.arg<string?> ()) {
				var pos = statement.index_of_char ('?', statement_offset);

				if (pos == -1) {
					break; /* no more '?' to fill */
				}

				statement_builder.append (statement[statement_offset:pos]);

				var str_dest = (string) new uint8[2 * str.length];

				assert (-1 != (long) database.real_escape_string (str_dest, str, str.length));

				statement_builder.append_printf ("'%s'", str_dest);

				statement_offset = pos + 1; // just right after the '?'
			}

			/* fill the rest of the statement as-is */
			statement_builder.append (statement[statement_offset:statement.length]);

			_handle_return_code (database.real_query (statement_builder.str, statement_builder.len));

			return new Result (database.use_result ());
		}

		public class Result : Object {

			private Mysql.Result result;
			private string[]? row;

			internal Result (owned Mysql.Result result) {
				this.result = (owned) result;
				this.row    = null;
			}

			public bool is_empty () {
				return result.eof ();
			}

			public string? get (string column) {
				if (result.eof ()) {
					return null;
				}
				for (var i = 0; i < result.num_fields (); i++) {
					if (result.fetch_field_direct (i).name == column) {
						return row[i];
					}
				}
				assert_not_reached ();
			}

			public bool next () {
				return (row = result.fetch_row ()) != null;
			}
		}
	}
}
