class DrawModel {
  String title;
  String description;

  DrawModel({
    required this.title,
    required this.description,
  });

  DrawModel.zero()
      : this(
          title: '',
          description: '',
        );
}
