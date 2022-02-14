import 'dart:async';
import 'dart:io';

import 'package:media/features/play_song/song.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SongDatabase {
  static final _databaseName = "Song.db";
  static final _databaseVersion = 1;

  static final table = 'song';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnSinger = 'singer';
  static final columnPath = 'path';
  static final columnType = 'type';
  static final columnPathAvatar = 'pathAvatar';

  SongDatabase._privateConstructor();
  static final SongDatabase instance = SongDatabase._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    print('Init database....');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print('Cretate database...');
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT,
            $columnSinger TEXT,
            $columnType TEXT,
            $columnPathAvatar TEXT
            $columnPath TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    print('start insert....');
    return await _database!.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(int id) async {
    return await _database!.query(table,
        where: '$columnId = ?',
        whereArgs: [id],
        columns: [columnName, columnPath]);
  }

  Future<int?> queryRowCount() async {
    return Sqflite.firstIntValue(
        await _database!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Song song) async {
    print('id update = ${song.id}');
    return await _database!.update(table, song.toMap(),
        where: '$columnId = ?', whereArgs: [song.id]);
  }

  Future<int> delete(int? id) async {
    return await _database!
        .delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryRecordByPage(
      int pageIndex, int pageSize) async {
    print(
        'start get data with pageIndex = $pageIndex , pageSize = $pageSize....');
    return await _database!.rawQuery(
        'select $columnId, $columnSinger, $columnPath, $columnName from $table limit $pageSize offset $pageIndex');
  }

  Future<List<Map<String, dynamic>>> queryByString(String keyword) async {
    String str = '%$keyword%';
    return await _database!.rawQuery(
        'select * from $table where $columnName like "$str" limit 10');
  }
}
