class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.zero() => CategoryModel(
        id: 0,
        name: '',
      );

  static List<CategoryModel> generate() {
    return List.generate(5, (index) => CategoryModel.zero());
  }
}
