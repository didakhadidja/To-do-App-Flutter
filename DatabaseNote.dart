import 'package:sqflite/sqflite.dart';
import 'package:to_to_app/Models/Note.dart';
import 'package:get/get.dart';

class DatabaseNote{
  static Database _db;
  static final int _version=1;
  static final String _name="notes";
  static var notesListe=<Note>[].obs;
  static var notesListeOfDay=<Note>[].obs;
  static Future<void> initDb()async{
    if(_db!=null){
      return;
    }
    try {
      String _path=await getDatabasesPath()+"notes.db";
      _db=await openDatabase(
          _path,
        version: _version,
        onCreate: (db,version){
            db.execute(""
                "CREATE TABLE $_name ("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "title STRING ,"
                "description TEXT,"
                "date String,"
                "time String,"
                "reminder String,"
                "isCompleted INTEGER"
                ")"
                );
        }
      );
    }catch(e){
      print(e);
    }
  }

  static Future<void> insertNote(Note note)async{
    await _db.insert(_name, note.toJson()??1);
    DatabaseNote.getNotes();
  }
  static Future<void> getNotes()async{
    List<Map<String,dynamic>> notes=await _db.query(_name);
    notesListe.assignAll(notes.map((e) => new Note.fromJson(e)).toList());
  }
  
  static Future<void> deleteNote(Note note)async{
     await _db.delete(_name,where: "id=?",whereArgs: [note.id]);
     DatabaseNote.getNotes();
  }

  static Future<void> updateNote(Note note)async{
    await _db.rawUpdate("update notes set isCompleted=? where id=?",[1,note.id]);
    DatabaseNote.getNotes();
  }

  static Future<void> getNotesOfDay(String day,int type)async{
    if(type==0){
      List<Map<String,dynamic>> notes=await _db.query(
          _name,//table name
          where: "date=?",
          whereArgs: [day]
      );
      notesListeOfDay.assignAll(notes.map((e) => new Note.fromJson(e)).toList());
    }else{
      if(type==1){
        List<Map<String,dynamic>> notes=await _db.query(
            _name,//table name
            where: "date=? and isCompleted=?",
            whereArgs: [day,0]
        );
        notesListeOfDay.assignAll(notes.map((e) => new Note.fromJson(e)).toList());
      }else{
        List<Map<String,dynamic>> notes=await _db.query(
            _name,//table name
            where: "date=? and isCompleted=?",
            whereArgs: [day,1]
        );
        notesListeOfDay.assignAll(notes.map((e) => new Note.fromJson(e)).toList());
      }
    }
  }

  static Future<void> getNotesOfDayToDo(String day)async{
    List<Map<String,dynamic>> notes=await _db.query(
        _name,//table name
        where: "date=? and isCompleted=?",
        whereArgs: [day,0]
    );
    notesListeOfDay.assignAll(notes.map((e) => new Note.fromJson(e)).toList());
  }

  static Future<void> getNotesOfDayCompleted(String day)async{
    List<Map<String,dynamic>> notes=await _db.query(
        _name,//table name
        where: "date=? and isCompleted=?",
        whereArgs: [day,1]
    );
    notesListeOfDay.assignAll(notes.map((e) => new Note.fromJson(e)).toList());
  }


}