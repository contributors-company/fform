class TaskModel {
  final String title;
  final String description;
  final String descriptionReport;
  final String interval;

  TaskModel({
    required this.title,
    required this.description,
    required this.descriptionReport,
    required this.interval,
  });

  factory TaskModel.zero() => TaskModel(
        title: '',
        description: '',
        descriptionReport: '',
        interval: '',
      );

  TaskModel copyWith({
    String? title,
    String? description,
    String? descriptionReport,
    String? interval,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      descriptionReport: descriptionReport ?? this.descriptionReport,
      interval: interval ?? this.interval,
    );
  }

  static List<TaskModel> generate() {
    return List.generate(3, (index) => TaskModel.zero());
  }
}
