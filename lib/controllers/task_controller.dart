import 'package:get/get.dart';
import 'package:taskkey/db/db_helper.dart';
import 'package:taskkey/models/task.dart';

/// Kontroler nam bo pomagal procesirati data to database, to je vmesn del med UI pa med Modelom kontroler pošle na models models pa vezan na bazo
class TaskController extends GetxController {

  //ta bo držu data pa updateal UI

  @override
  void onReady() {
    getTasks(); // geta taske
    super.onReady();
  }

  var taskList = <Task>[].obs;

  //drugi oklepaji pomenjo da so poimenovani kot optional parametr
  // add data to table
  Future<void> addTask({Task task}) async {
    return await DBHelper.insert(task); // inserta v bazo
  }

  // get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  // delete data from tablee
  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  // update data int table
  void markTaskCompleted(int id) async {
    await DBHelper.update(id); //db Hellper
    getTasks();
  }
}
