import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:users_app/JsonModels/users.dart';
import 'package:users_app/JsonModels/note_model.dart';


class DatabaseHelper {
  final databaseName = "note.db";
  //String noteTable = "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP";

  String user = "CREATE TABLE users (userId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, password TEXT)";



  Future<Database> initDB() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async{
      await db.execute(user);
      //await db.execute(noteTable);
    });
  }

  //Login Method
  Future<bool> login(Users users) async {
    final Database db = await initDB();

    var result = await db.rawQuery("select * from users where usrName = '${users.userId}' AND password = '${users.password}'");
    if(result.isNotEmpty) {
      return true;
    } else {
      return false;
    }

  }


  //sign up
  Future<int> signup(Users users) async {
    final Database db = await initDB();

    return db.insert('users', users.toMap());
  }

  //Search Method
  Future<List<NoteModel>> searchNotes(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db
        .rawQuery("select * from notes where noteTitle LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  }


  //CRUD Methods

  //Create Note
  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  //Get notes
  Future<List<NoteModel>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  //Delete Notes
  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

  //Update Notes
  Future<int> updateNote(title, content, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update notes set noteTitle = ?, noteContent = ? where noteId = ?',
        [title, content, noteId]);
  }


}

