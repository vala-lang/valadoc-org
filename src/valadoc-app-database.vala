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
			database.options (Mysql.Option.OPT_RECONNECT, "1");
			if (!database.real_connect (hostname, null, null, null, port)) {
				throw new DatabaseError.FAILED (database.error ());
			}
			return true;
		}

		public unowned Mysql.Database get_mysql_database () {
			return database;
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

				var str_dest     = (string) new uint8[2 * str.length + 1];
				var str_dest_len = (long) database.real_escape_string (str_dest, str, str.length);

				if (str_dest_len == -1) {
					throw new DatabaseError.FAILED ("Could not escape the value for position '%u'.", pos);
				}

				if (bool.try_parse (str_dest) || int64.try_parse (str_dest) || double.try_parse (str_dest)) {
					statement_builder.append_len (str_dest, str_dest_len);
				} else {
					statement_builder.append_c ('\'');
					statement_builder.append_len (str_dest, str_dest_len);
					statement_builder.append_c ('\'');
				}

				statement_offset = pos + 1; // just right after the '?'
			}

			/* fill the rest of the statement as-is */
			statement_builder.append (statement[statement_offset:statement.length]);

			_handle_return_code (database.real_query (statement_builder.str, statement_builder.len));

			var result = database.use_result ();

			if (result == null) {
				throw new DatabaseError.FAILED (database.error ());
			}

			return new Result (this, (owned) result);
		}

		public Result? query (string statement, ...) throws DatabaseError {
			return query_valist (statement, va_list ());
		}

		public class Result : Object {

			private         Mysql.Result  result;
			private unowned Mysql.Field[] fields;

			public Database database { construct; get; }

			internal Result (Database database, owned Mysql.Result result) {
				base (database: database);
				this.result = (owned) result;
				this.fields = this.result.fetch_fields ();
			}

			public unowned Mysql.Result get_mysql_result () {
				return result;
			}

			public unowned Mysql.Field[] get_mysql_fields () {
				return fields;
			}

			public ResultIter iterator () {
				return new ResultIter (this);
			}
		}

		public class ResultIter : Object {

			private Row? current_row;

			public Result result { construct; get; }

			internal ResultIter (Result result) {
				base (result: result);
				this.current_row = null;
			}

			public new Row? get () {
				return current_row;
			}

			public bool next () throws DatabaseError {
				var row = result.get_mysql_result ().fetch_row ();
				if (row == null) {
					if (result.get_mysql_result ().eof ()) {
						return false;
					} else {
						throw new DatabaseError.FAILED (result.database.get_mysql_database ().error ());
					}
				}
				current_row = new Row (result, row);
				return true;
			}
		}

		public class Row : Object {

			public Result result { construct; get; }

			public string[] row { construct; get; }

			internal Row (Result result, string[] row) {
				base (result: result, row: row);
			}

			public new string? get (string column) {
				unowned Mysql.Field[] fields = result.get_mysql_fields ();
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
