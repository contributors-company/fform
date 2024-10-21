import 'package:flutter/cupertino.dart';
import '../models/models.dart';

class TaskController extends ValueNotifier<TaskModel> {
  TaskController(super.value);

  change({
    String? title,
    String? description,
    String? descriptionReport,
    String? interval,
  }) {
    value = value.copyWith(
      title: title,
      description: description,
      descriptionReport: descriptionReport,
      interval: interval,
    );
    notifyListeners();
  }
}
