class RegionModel {
  final int id;
  final String name;

  RegionModel({required this.id, required this.name});

  factory RegionModel.zero() => RegionModel(
        id: 0,
        name: '',
      );

  static List<RegionModel> generate() {
    return List.generate(5, (index) => RegionModel.zero());
  }
}
