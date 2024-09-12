import 'package:example_fform/extension/list_map_with_index.dart';
import 'package:fform/fform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../controllers/controllers.dart';
import '../fields/fields.dart';
import '../forms/forms.dart';
import '../widgets/drawer.dart';

MultiDrawForm builderForm(MultiDrawController controller) {
  return MultiDrawForm(
    drawForm: DrawForm(
      title:
          TitleField.dirty(value: controller.value.drawController.value.title),
      description: DescriptionField.dirty(
          value: controller.value.drawController.value.description),
    ),
    drawForms: controller.value.multiDrawControllers.map((e) {
      return builderForm(e);
    }).toList(),
  );
}

class MultiScreen extends StatefulWidget {
  const MultiScreen({super.key});

  @override
  State<MultiScreen> createState() => _MultiScreenState();
}

class _MultiScreenState extends State<MultiScreen> {
  late MultiDrawController _multiDrawController;
  late MultiDrawForm _form;

  @override
  void initState() {
    super.initState();
    _multiDrawController = MultiDrawController();
    _form = builderForm(_multiDrawController);
  }

  @override
  void dispose() {
    super.dispose();
    _multiDrawController.dispose();
  }

  void _check() {
    if (_form.isValid) {
      if (kDebugMode) {
        print('Form is valid');
      }
    } else {
      for (var element in _form.exceptions) {
        if (kDebugMode) {
          print(element.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerApp(),
      appBar: AppBar(
        title: const Text('Draw Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FFormBuilder<MultiDrawForm>(
          form: _form,
          builder: (context, form) {
            return Column(
              children: [
                DrawCard(form: form, controller: _multiDrawController),
                ElevatedButton(
                  onPressed: _check,
                  child: const Text('Check'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DrawCard extends StatefulWidget {
  final MultiDrawForm form;
  final MultiDrawController controller;

  const DrawCard({
    super.key,
    required this.form,
    required this.controller,
  });

  @override
  State<DrawCard> createState() => _DrawCardState();
}

class _DrawCardState extends State<DrawCard> {
  _addDraw() {
    widget.form.drawForms.add(builderForm(widget.controller));
    widget.controller.addDraw();
  }

  _removeDraw(MultiDrawController controller, MultiDrawForm form) => () {
        widget.controller.removeDraw(controller);
        widget.form.drawForms.remove(form);
      };

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 20,
            color: Colors.grey,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: widget.controller,
              builder: (context, value, child) {
                return Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        errorText:
                            widget.form.drawForm.title.exception?.toString(),
                      ),
                      onChanged: (value) {
                        widget.form.drawForm.title.value = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        errorText: widget.form.drawForm.description.exception
                            ?.toString(),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: _addDraw, icon: const Icon(Icons.add)),
                      ],
                    ),
                    ...value.multiDrawControllers.mapWithIndex(
                      (controller, index) {
                        MultiDrawForm form = widget.form.drawForms[index];

                        return Column(
                          children: [
                            DrawCard(
                              controller: controller,
                              form: form,
                            ),
                            IconButton(
                                onPressed: _removeDraw(controller, form),
                                icon: const Icon(Icons.remove)),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
