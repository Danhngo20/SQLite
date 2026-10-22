import 'package:flutter_test/flutter_test.dart';
import 'package:slot14_2_sqlite/models/task.dart';
import 'package:slot14_2_sqlite/repositories/task_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  test('CRUD: insert -> update -> sort mới nhất trước -> delete', () async {
    final repo = TaskRepository();
    await repo.deleteAll();

    await repo.insertTask(Task(id: 'a', title: 'cũ', createdAt: 1));
    await repo.insertTask(Task(id: 'b', title: 'mới', createdAt: 2));
    expect((await repo.getAllTasks()).map((t) => t.id), ['b', 'a']);

    final t = (await repo.getAllTasks()).last..isDone = true..title = 'sửa';
    await repo.updateTask(t);
    final a = (await repo.getAllTasks()).firstWhere((x) => x.id == 'a');
    expect([a.title, a.isDone], ['sửa', true]);

    await repo.deleteTask('a');
    expect((await repo.getAllTasks()).length, 1);
    await repo.deleteAll();
    expect(await repo.getAllTasks(), isEmpty);
  });
}
