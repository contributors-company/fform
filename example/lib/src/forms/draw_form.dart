import 'package:fform/fform.dart';

import '../fields/description_field.dart';
import '../fields/title_field.dart';

class DrawForm extends FForm {
  TitleField title;
  DescriptionField description;

  DrawForm({
    required this.title,
    required this.description,
  }) : super(fields: [title, description]);

  DrawForm.zero()
      : this(
          title: TitleField.dirty(value: ''),
          description: DescriptionField(value: ''),
        );

  void changeFields({
    String? title,
    String? description,
  }) {
    this.title.value = title ?? this.title.value;
    this.description.value = description ?? this.description.value;
  }
}
