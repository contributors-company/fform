import 'package:fform/fform.dart';

import '../fields/fields.dart';

class DrawForm extends FForm {
  TitleField title;
  DescriptionField description;

  DrawForm({
    required this.title,
    required this.description,
  });

  DrawForm.zero()
      : this(
          title: TitleField.dirty(value: ''),
          description: DescriptionField.dirty(value: ''),
        );

  void changeFields({
    String? title,
    String? description,
  }) {
    this.title.value = title ?? this.title.value;
    this.description.value = description ?? this.description.value;
  }

  @override
  List<FFormField> get fields => [title, description];
}
