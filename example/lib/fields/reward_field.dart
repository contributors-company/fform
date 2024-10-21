import 'package:fform/fform.dart';

enum RewardError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'rewardEmpty';
      case min:
        return 'rewardMin';
      default:
        return 'invalidFormatReward';
    }
  }
}

///Todo
class RewardField extends FFormField<int?, RewardError> {
  bool isRequired;

  RewardField.dirty({
    required int? value,
    this.isRequired = true,
  }) : super(value);

  @override
  RewardError? validator(value) {
    if (isRequired) {
      if (value == null) return RewardError.empty;
      if (value < 5) return RewardError.min;
    }
    return null;
  }
}
