import 'package:example_fform/forms/forms.dart';
import 'package:fform/fform.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FForm Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      for (var element in form.allExceptions) {
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
    _titleController = TextEditingController();
    _multiTaskController = MultiTaskController();
    super.initState();
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
                          ..._multiTaskController.value
                              .mapWithIndex((e, index) {
                            CreateQuestTaskForm taskForm = form.tasks[index];
                            return CardTask(
                              index: index,
                              controller: e,
                              form: taskForm,
                            );
                          }),
                        ],
                      );
                    }),
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

extension ListMapWithIndex<T> on List<T> {
  List<E> mapWithIndex<E>(E Function(T element, int index) f) {
    return asMap()
        .map((index, element) => MapEntry(index, f(element, index)))
        .values
        .toList();
  }
}

class CardTask extends StatefulWidget {
  final CreateQuestTaskForm form;
  final TaskController controller;
  final int index;

  const CardTask(
      {super.key,
      required this.controller,
      required this.form,
      required this.index});

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
                TextField(
                  key: form.description.key,
                  decoration: InputDecoration(
                    errorText: form.hasCheck
                        ? form.description.exception.toString()
                        : null,
                  ),
                  onChanged: (value) {
                    widget.controller.change(description: value);
                  },
                ),
                TextField(
                  key: form.descriptionReport.key,
                  decoration: InputDecoration(
                    errorText: form.hasCheck
                        ? form.descriptionReport.exception.toString()
                        : null,
                  ),
                  onChanged: (value) {
                    widget.controller.change(descriptionReport: value);
                  },
                ),
                TextField(
                  key: form.interval.key,
                  decoration: InputDecoration(
                    errorText: form.hasCheck
                        ? form.interval.exception.toString()
                        : null,
                  ),
                  onChanged: (value) {
                    widget.controller.change(interval: value);
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

class MultiTaskController extends ValueNotifier<List<TaskController>> {
  MultiTaskController() : super([TaskController(TaskModel.zero())]) {
    for (var element in value) {
      element.addListener(notifyListeners);
    }
  }

  add() {
    value.add(TaskController(TaskModel.zero())..addListener(notifyListeners));
    notifyListeners();
  }

  remove(TaskController controller) {
    value.remove(controller..removeListener(notifyListeners));
    notifyListeners();
  }

  clear() {
    for (var element in value) {
      element.removeListener(notifyListeners);
    }
    value.clear();
    notifyListeners();
  }
}

class TaskController extends ValueNotifier<TaskModel> {
  TaskController(super.value);

  change({
    String? title,
    String? description,
    String? descriptionReport,
    String? interval,
  }) {
    value = value.copyWith(
      title: title,
      description: description,
      descriptionReport: descriptionReport,
      interval: interval,
    );
    notifyListeners();
  }
}

class TaskModel {
  final String title;
  final String description;
  final String descriptionReport;
  final String interval;

  TaskModel({
    required this.title,
    required this.description,
    required this.descriptionReport,
    required this.interval,
  });

  factory TaskModel.zero() => TaskModel(
        title: '',
        description: '',
        descriptionReport: '',
        interval: '',
      );

  TaskModel copyWith({
    String? title,
    String? description,
    String? descriptionReport,
    String? interval,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      descriptionReport: descriptionReport ?? this.descriptionReport,
      interval: interval ?? this.interval,
    );
  }

  static List<TaskModel> generate() {
    return List.generate(3, (index) => TaskModel.zero());
  }
}
