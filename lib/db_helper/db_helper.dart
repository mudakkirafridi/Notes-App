// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:notes_app/model/notes_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  // first step is database declaration or initialization with static 
  static Database? _db;

  // and second step is database getter 
  Future<Database?> get database async{
    if (_db != null) {
      return _db;
    } 
    //if database is null then create new db or not use else 
      _db = await initDatabase();
      // and then return this _database
      return _db;
    
  }
  initDatabase()async{
 Directory directory = await getApplicationDocumentsDirectory();
              // first add path and then db name
 String path = join(directory.path , 'notes.db');
var db = await openDatabase(path , version:  1 , onCreate: _onCreate);
return db;
  }
  // on create method have parameter 1 database instance 2 version
  _onCreate(Database db , int version)async{
  await db.execute(
    '''
CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT NOT NULL , description TEXT NOT NULL)
'''
  );
  }

  // and then finaly we create methods for crud operations 
  Future<NotesModel> insert (NotesModel notesModel)async{
  var dbClient = await database;
 await dbClient!.insert('notes', notesModel.toJson());
  return notesModel;
  }

Future<List<NotesModel>> getNotesList ()async{
  var dbClient = await database;
 final List<Map<String , Object?>> queryResult = await   dbClient!.query('notes');
 return queryResult.map((e) => NotesModel.fromJson(e)).toList();
  }
  
  Future<int> delete (int id)async{
    var dbClient = await database;
    return await dbClient!.delete('notes',where: 'id = ?' , whereArgs: [id]);
  }

  Future<int> update(NotesModel notesModel)async{
    var dbClient = await database;
    return await dbClient!.update(
      "notes",
       notesModel.toJson(),
       where: "id = ?",
       whereArgs: [notesModel.id]
       );
  }
}