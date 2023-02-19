import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, "bytebank.db");
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDAO.tableSQL);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}
