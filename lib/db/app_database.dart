import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  static const String _dbName = 'smart_task_manager.db';
  static const int _dbVersion = 1;

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _openDb();
    return _db!;
  }

  Future<Database> _openDb() async {
    // Desktop (dev): lưu ngay trong project, thư mục local_data/.
    // Mobile: dùng thư mục databases mặc định của hệ điều hành.
    final isDesktop = Platform.isWindows || Platform.isLinux;
    final dbPath = isDesktop
        ? join(Directory.current.path, 'local_data')
        : await getDatabasesPath();
    if (isDesktop) await Directory(dbPath).create(recursive: true);
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            is_done INTEGER NOT NULL,
            created_at INTEGER NOT NULL
          );
        ''');
      },
    );
  }
}
