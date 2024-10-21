class InterestModel {
  final int id;
  final String name;

  InterestModel({required this.id, required this.name});

  factory InterestModel.zero() => InterestModel(
        id: 0,
        name: '',
      );

  static List<InterestModel> generate() {
    return List.generate(5, (index) => InterestModel.zero());
  }
}
