import 'package:example_fform/extension/list_map_with_index.dart';
import 'package:fform/fform.dart';
import 'package:flutter/material.dart';

import '../controllers/controllers.dart';
import '../forms/forms.dart';
import '../widgets/widgets.dart';

class CreateQuestScreen extends StatefulWidget {
  const CreateQuestScreen({super.key});

  @override
  State<CreateQuestScreen> createState() => _CreateQuestScreenState();
}

class _CreateQuestScreenState extends State<CreateQuestScreen> {
  late MultiTaskController _multiTaskController;
  late TextEditingController _titleController;
  CreateQuestForm form = CreateQuestForm.parse();

  _checkForm() {
    form.change(
      title: _titleController.value.text,
      tasks: _multiTaskController.value.map((e) => e.value).toList(),
    );

    if (form.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Row(
            children: [
              Icon(
                Icons.lock_open,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text('Welcome', style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      );
    } else {
      for (var element in form.exceptions) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(
              milliseconds: 500,
            ),
            backgroundColor: Colors.red,
            content: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  element.toString(),
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
      }
      Scrollable.ensureVisible(
        form.firstInvalidField!.key.currentContext!,
        alignment: 0.2,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  _addForm() {
    form.tasks.add(CreateQuestTaskForm.zero());
    _multiTaskController.add();
  }

  _removeForm() {
    form.tasks.removeLast();
    _multiTaskController.remove(_multiTaskController.value.last);
  }

  @override
  void initState() {
    _titleController = TextEditingController()..addListener(_changeTitle);
    _multiTaskController = MultiTaskController();
    super.initState();
  }

  _changeTitle() {
    form.change(title: _titleController.value.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _multiTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerApp(),
      appBar: AppBar(
        title: const Text('FForm'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FFormBuilder<CreateQuestForm>(
          form: form,
          builder: (BuildContext context, CreateQuestForm form) {
            return Column(
              children: [
                TextField(
                  key: form.title.key,
                  controller: _titleController,
                  decoration: InputDecoration(
                    errorText:
                        form.hasCheck ? form.title.exception.toString() : null,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _multiTaskController,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        ..._multiTaskController.value.mapWithIndex(
                          (e, index) {
                            CreateQuestTaskForm taskForm = form.tasks[index];
                            return CardTask(
                              index: index,
                              controller: e,
                              form: taskForm,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: _addForm,
                      child: const Text('add sub Form'),
                    ),
                    ElevatedButton(
                      onPressed: _checkForm,
                      child: const Text('Check Form'),
                    ),
                    ElevatedButton(
                      onPressed: _removeForm,
                      child: const Text('Remove Last Form'),
                    )
                  ],
                ),
                Text(form.isValid ? 'Form is valid' : 'Form is invalid'),
                const SizedBox(height: 200),
              ],
            );
          },
        ),
      ),
    );
  }
}
