import '../dictionary_translator_data.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class Sql {
  static Database _db;
  static const String TABLE = 'tab';
  //static const String ID = 'id';
  static const String WORD = 'word';
  static const String DEFINITION_OR_TRANSLATION = 'definitionTranslation';
  static const String FROM_WHERE = 'froWhere';
  static const String DB_NAME = 'table.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    var db = await openDatabase('${directory.path}/$DB_NAME',
        version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $TABLE($WORD TEXT, $DEFINITION_OR_TRANSLATION TEXT, $FROM_WHERE TEXT)');
  }

  Future<void> save(DictionaryTranslatorData data) async {
    var dbTask = await db;
    for (int i = 0; i < data.definitionOrTranslation.length; i++) {
      await dbTask.insert(TABLE, {
        WORD: data.word,
        DEFINITION_OR_TRANSLATION: data.definitionOrTranslation[i],
        FROM_WHERE: data.fromWhere
      });
    }
  }

  Future<List<DictionaryTranslatorData>> getTasks() async {
    var dbTask = await db;
    List<Map> maps = await dbTask
        .query(TABLE, columns: [WORD, DEFINITION_OR_TRANSLATION, FROM_WHERE]);
    List<DictionaryTranslatorData> data = [];
    if (maps.length > 0) {
      List<String> defOrTran = [];
      for (int i = 0; i < maps.length; i++) {
        if (maps.length == 1) {
          data.add(
            DictionaryTranslatorData(
              word: maps[i][WORD],
              definitionOrTranslation: [maps[i][DEFINITION_OR_TRANSLATION]],
              fromWhere: maps[i][FROM_WHERE],
            ),
          );
        } else if (i < maps.length - 1) {
          if (maps[i][WORD] == maps[i + 1][WORD] &&
              maps[i][FROM_WHERE] == maps[i + 1][FROM_WHERE]) {
            defOrTran.add(maps[i][DEFINITION_OR_TRANSLATION]);
          } else {
            defOrTran.add(maps[i][DEFINITION_OR_TRANSLATION]);
            data.add(
              DictionaryTranslatorData(
                word: maps[i][WORD],
                definitionOrTranslation: defOrTran,
                fromWhere: maps[i][FROM_WHERE],
              ),
            );
            defOrTran = [];
          }
        } else {
          if (maps[i - 1][WORD] == maps[maps.length - 1][WORD] &&
              maps[i - 1][FROM_WHERE] == maps[maps.length - 1][FROM_WHERE]) {
            defOrTran.add(maps[maps.length - 1][DEFINITION_OR_TRANSLATION]);
            data.add(
              DictionaryTranslatorData(
                word: maps[i][WORD],
                definitionOrTranslation: defOrTran,
                fromWhere: maps[i][FROM_WHERE],
              ),
            );
          } else {
            data.add(
              DictionaryTranslatorData(
                word: maps[i][WORD],
                definitionOrTranslation: [
                  maps[maps.length - 1][DEFINITION_OR_TRANSLATION]
                ],
                fromWhere: maps[i][FROM_WHERE],
              ),
            );
            defOrTran = [];
          }
        }
      }
    }
    return data;
  }

  Future<List<String>> getWords() async {
    var dbTask = await db;
    List<Map> maps = await dbTask.query(TABLE, columns: [WORD, FROM_WHERE]);
    List<String> data = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        if (!data.contains('${maps[i][WORD]}${maps[i][FROM_WHERE]}')) {
          data.add('${maps[i][WORD].toLowerCase()}${maps[i][FROM_WHERE]}');
        }
      }
    }
    return data;
  }

  Future<int> delete(String word, String fromWhere) async {
    var dbTask = await db;
    return await dbTask.delete(TABLE,
        where: '$WORD = ? and $FROM_WHERE = ?', whereArgs: [word, fromWhere]);
  }
}
