import 'package:my_notes/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  late final database;

  DatabaseService() {
    initializeDB();
  }
  initializeDB() async {
    database = openDatabase(join(await getDatabasesPath(), 'contacts.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE IF NOT EXISTS contacts(name string, phno string)");
    }, version: 1);
  }

  Future<void> insertContact(Contact contact) async {
    final db = database;
    await db.insert('contacts', contact.toMap(), ConflictAlgorithm.replace);
  }

  Future<List<Contact>> getContacts() async {
    final db = database;
    final List<Map<String, Object?>> contactsMap = await db.query('contacts');
    return [
      for (final {'name': name as String, 'phno': phno as String}
          in contactsMap)
        Contact(name: name, phno: phno)
    ];
  }
}
