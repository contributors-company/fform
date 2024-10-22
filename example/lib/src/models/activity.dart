class ActivityModel {
  final int id;
  final String name;

  ActivityModel({required this.id, required this.name});

  factory ActivityModel.zero() => ActivityModel(
        id: 0,
        name: '',
      );

  static List<ActivityModel> generate() {
    return List.generate(5, (index) => ActivityModel.zero());
  }
}
