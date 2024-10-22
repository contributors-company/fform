import 'package:fform/fform.dart';
import 'package:flutter/material.dart';

import '../controllers/controllers.dart';
import '../forms/forms.dart';

class CardTask extends StatefulWidget {
  final CreateQuestTaskForm form;
  final TaskController controller;
  final int index;

  const CardTask({
    super.key,
    required this.controller,
    required this.form,
    required this.index,
  });

  @override
  State<CardTask> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Card(
        child: FFormBuilder<CreateQuestTaskForm>(
          form: widget.form,
          builder: (context, form) {
            return Column(
              children: [
                Text('Task ${widget.index + 1}'),
                TextField(
                  key: form.title.key,
                  decoration: InputDecoration(
                    errorText:
                        form.hasCheck ? form.title.exception.toString() : null,
                  ),
                  onChanged: (value) {
                    widget.controller.change(title: value);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
