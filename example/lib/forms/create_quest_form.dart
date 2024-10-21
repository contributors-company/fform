import 'package:example/fields/fields.dart';
import 'package:fform/fform.dart';

import '../models/models.dart';
import 'create_task_form.dart';

class CreateQuestForm extends FForm {
  final InterestField interests;
  final RegionField region;
  final ActivityField activity;
  final CategoryField category;
  final ChildrenField children;
  final GenderField gender;
  final List<CreateQuestTaskForm> tasks;
  final TitleField title;
  final RewardField reward;
  final RepeatField repeat;
  final CountField count;
  final AgeField age;

  CreateQuestForm({
    required this.interests,
    required this.region,
    required this.activity,
    required this.category,
    required this.children,
    required this.gender,
    required this.tasks,
    required this.title,
    required this.reward,
    required this.repeat,
    required this.count,
    required this.age,
  });

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
      interests: InterestField.dirty(value: interests),
      region: RegionField.dirty(value: region),
      activity: ActivityField.dirty(value: activity),
      category: CategoryField.dirty(value: category),
      children: ChildrenField.dirty(value: children),
      gender: GenderField.dirty(value: gender),
      tasks: [
        CreateQuestTaskForm(
          title: TitleField.dirty(value: ''),
          description: DescriptionField.dirty(value: ''),
          descriptionReport: DescriptionReportField.dirty(value: ''),
          interval: IntervalField.dirty(value: ''),
        ),
      ],
      title: TitleField.dirty(value: title),
      reward: RewardField.dirty(value: reward),
      repeat: RepeatField.dirty(value: repeat),
      count: CountField.dirty(value: count),
      age: AgeField.dirty(value: age),
    );
  }

  void change({
    List<InterestModel> interests = const [],
    List<RegionModel> region = const [],
    List<ActivityModel> activity = const [],
    List<TaskModel> tasks = const [],
    CategoryModel? category,
    Children? children,
    Gender? gender,
    String title = '',
    int? reward,
    int? repeat,
    int? count,
    AgeModel? age,
  }) {
    this.interests.value = interests;
    this.region.value = region;
    this.activity.value = activity;
    this.category.value = category;
    this.children.value = children;
    this.gender.value = gender;
    this.title.value = title;
    this.reward.value = reward;
    this.repeat.value = repeat;
    this.count.value = count;
    this.age.value = age;
    if (tasks.isNotEmpty) {
      this.tasks.asMap().forEach((key, value) {
        final task = tasks[key];
        value.change(
          title: task.title,
          description: task.description,
          descriptionReport: task.descriptionReport,
          interval: task.interval,
        );
      });
    }
  }

  @override
  List<FFormField> get fields => [
        title,
      ];

  @override
  List<FForm> get subForms => [
        ...tasks,
      ];

  @override
  bool get allFieldUpdateCheck => true;
}
