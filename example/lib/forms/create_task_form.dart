import 'package:fform/fform.dart';

import '../fields/fields.dart';

class CreateQuestTaskForm extends FForm {
  final TitleField title;
  final DescriptionField description;
  final DescriptionReportField descriptionReport;
  final IntervalField interval;

  CreateQuestTaskForm({
    required this.title,
    required this.description,
    required this.descriptionReport,
    required this.interval,
  });

  factory CreateQuestTaskForm.zero() {
    return CreateQuestTaskForm(
      title: TitleField.dirty(value: ''),
      description: DescriptionField.dirty(value: ''),
      descriptionReport: DescriptionReportField.dirty(value: ''),
      interval: IntervalField.dirty(value: ''),
    );
  }

  change({
    required String title,
    required String description,
    required String descriptionReport,
    required String interval,
  }) {
    this.title.value = title;
    this.description.value = description;
    this.descriptionReport.value = descriptionReport;
    this.interval.value = interval;
  }

}
