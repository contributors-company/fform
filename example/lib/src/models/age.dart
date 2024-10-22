class AgeModel {
  final int min;
  final int max;

  AgeModel({
    required this.min,
    required this.max,
  });

  factory AgeModel.zero() => AgeModel(
        min: 0,
        max: 100,
      );
}
