import 'package:fform/fform.dart';

import '../fields/fields.dart';
import '../models/models.dart';
import 'create_task_form.dart';

class CreateQuestForm extends FForm {
  final List<CreateQuestTaskForm> tasks;
  final TitleField title;

  CreateQuestForm({
    required this.tasks,
    required this.title,
  }) : super(
          fields: [
            title,
          ],
          subForms: tasks,
        );

  factory CreateQuestForm.parse({
    List<InterestModel> interests = const [],
    List<RegionModel> region = const [],
    List<ActivityModel> activity = const [],
    CategoryModel? category,
    Children? children,
    Gender? gender,
    String title = '',
    int? reward,
    int? repeat,
    int? count,
    AgeModel? age,
  }) {
    return CreateQuestForm(
      tasks: [
        CreateQuestTaskForm(
          title: TitleField.dirty(value: ''),
        ),
      ],
      title: TitleField.dirty(value: title),
    );
  }

  void change({
    List<TaskModel> tasks = const [],
    required String title,
  }) {
    this.title.value = title;
    if (tasks.isNotEmpty) {
      this.tasks.asMap().forEach((key, value) {
        final task = tasks[key];
        value.change(
          title: task.title,
        );
      });
    }
  }
}
