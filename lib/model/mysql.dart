import 'package:mysql1/mysql1.dart';
import 'package:mysql_client/mysql_client.dart';

class Mysql {
  static String host = '10.0.2.2',
                user = 'root',
                password = 'Sunny#0145',
                db = 'csn_database';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db
    );
    return await MySqlConnection.connect(settings);
  }

}

