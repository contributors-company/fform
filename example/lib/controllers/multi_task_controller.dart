import 'package:example_fform/controllers/task_controller.dart';
import 'package:flutter/cupertino.dart';

import '../models/models.dart';

class MultiTaskController extends ValueNotifier<List<TaskController>> {
  MultiTaskController() : super([TaskController(TaskModel.zero())]) {
    for (var element in value) {
      element.addListener(notifyListeners);
    }
  }

  add() {
    value.add(TaskController(TaskModel.zero())..addListener(notifyListeners));
    notifyListeners();
  }

  remove(TaskController controller) {
    value.remove(controller..removeListener(notifyListeners));
    notifyListeners();
  }

  clear() {
    for (var element in value) {
      element.removeListener(notifyListeners);
    }
    value.clear();
    notifyListeners();
  }
}
