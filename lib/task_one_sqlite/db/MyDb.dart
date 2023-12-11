import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb{
  Database? db;


  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''

                  CREATE TABLE user_profiles(
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        firstname varchar(255) NOT NULL,
                        lastname varchar(255) NOT NULL,
                        email varchar(255) NOT NULL,
                        dateofbirth varchar(255) NOT NULL,
                        mobilenumber int NOT NULL,
                        address varchar(255) NOT NULL
                    );
                    //create more table here
                ''');
          print("Table Created"+db.toString());
        });
  }

  Future<Map<dynamic, dynamic>?> getUserdetails(int mobilenumber) async {
    if(db==null){
      return null;
    }else{
      List<Map> maps = await db!.query('user_profiles',
          where: 'mobilenumber = ?',
          whereArgs: [mobilenumber]);
      if (maps.length > 0) {
        return maps.first;
      }
      return null;
    }

  }
}
