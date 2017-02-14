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

		public void ping () throws DatabaseError {
			_handle_return_code (database.ping ());
		}

		public Result? query_valist (string statement, va_list list) throws DatabaseError {
			var statement_builder = new GLib.StringBuilder ();
			var statement_offset = 0;

			for (var str = list.arg<string?> (); str != null; str = list.arg<string?> ()) {
				var pos = statement.index_of_char ('?', statement_offset);

				if (pos == -1) {
					throw new DatabaseError.FAILED ("Could not interpolate, no more '?' character to substitute.");
				}

				statement_builder.append (statement[statement_offset:pos]);

				var str_dest = (string) new uint8[2 * str.length];

				if ((long) database.real_escape_string (str_dest, str, str.length) == -1) {
					throw new DatabaseError.FAILED ("Could not escape the value for position '%u'.", pos);
				}

				statement_builder.append_printf ("'%s'", str_dest);

				statement_offset = pos + 1; // just right after the '?'
			}

			/* fill the rest of the statement as-is */
			statement_builder.append (statement[statement_offset:statement.length]);

			_handle_return_code (database.real_query (statement_builder.str, statement_builder.len));

			return new Result (database, database.use_result ());
		}

		public Result? query (string statement, ...) throws DatabaseError {
			return query_valist (statement, va_list ());
		}

		public class Result {

			private unowned Mysql.Database database;
			private Mysql.Result result;

			internal Result (Mysql.Database database, owned Mysql.Result result) {
				this.database = database;
				this.result   = (owned) result;
			}

			public bool is_empty () {
				return result.eof ();
			}

			public ResultIter iterator () {
				return new ResultIter (database, result);
			}
		}

		public class ResultIter {

			private unowned Mysql.Database database;
			private unowned Mysql.Result   result;
			private Mysql.Field[]          fields;
			private Row?                   current_row;

			internal ResultIter (Mysql.Database database, Mysql.Result result) {
				this.database    = database;
				this.result      = result;
				this.fields      = result.fetch_fields ();
				this.current_row = null;
			}

			public Row? get () {
				return current_row;
			}

			public bool next () throws DatabaseError {
				if (result.eof ()) {
					return false;
				} else {
					var fields = result.fetch_fields ();
					var row = result.fetch_row ();
					if (row == null) {
						throw new DatabaseError.FAILED (database.error ());
					}
					current_row = new Row (fields, row);
					return true;
				}
			}
		}

		public class Row {

			private Mysql.Field[] fields;
			private string[]      row;

			internal Row (Mysql.Field[] fields, string[] row) {
				this.fields = fields;
				this.row = row;
			}

			public string? get (string column) {
				for (var i = 0; i < fields.length; i++) {
					if (fields[i].name == column) {
						return row[i];
					}
				}
				critical ("No such column '%s'.", column);
				return null;
			}
		}
	}
}
