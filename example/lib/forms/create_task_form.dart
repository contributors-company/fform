import 'package:fform/fform.dart';

import '../fields/fields.dart';

class CreateQuestTaskForm extends FForm {
  final TitleField title;

  CreateQuestTaskForm({
    required this.title,
  }) : super(fields: [
          title,
        ]);

  factory CreateQuestTaskForm.zero() {
    return CreateQuestTaskForm(
      title: TitleField.dirty(value: ''),
    );
  }

  change({
    required String title,
  }) {
    this.title.value = title;
  }
}
