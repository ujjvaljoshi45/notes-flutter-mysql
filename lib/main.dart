import 'package:flutter/material.dart';
import 'package:my_notes/DatabaseService.dart';
import 'package:my_notes/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Database db =
      await openDatabase(join(await getDatabasesPath(), 'contacts.db'),
          onCreate: (db, version) async {
    return await db
        .execute("CREATE TABLE IF NOT EXISTS contacts(name text, phno text)");
  }, version: 1);
  print("Database path : ${await getDatabasesPath()}");
  //db.initializeDB();
  Contact contact = Contact(name: 'ujjval', phno: '123');

  await insertContact(db, contact);

  print(await getContacts(db));
  List<Contact> c = await getContacts(db);
  for (var contact in c) {
    print(contact.name);
    print(contact.phno);
  }
  runApp(const MyApp());
}

Future<void> insertContact(Database database, Contact contact) async {
  final db = database;
  var ans = await db.insert('contacts', contact.toMap());
  print(ans);
}

Future<List<Contact>> getContacts(Database database) async {
  final db = database;
  final List<Map<String, Object?>> contactsMap = await db.query('contacts');
  return [
    for (final {'name': name as String, 'phno': phno as String} in contactsMap)
      Contact(name: name, phno: phno)
  ];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


/*

E/flutter (14019): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: NoSuchMethodError: Class 'Future<Database>' has no instance method 'insert'.

*/