import 'package:flutter/cupertino.dart';

import 'controllers.dart';

class MultiDrawController extends ValueNotifier<MultiDrawModel> {
  MultiDrawController({MultiDrawModel? value})
      : super(value ?? MultiDrawModel.zero()) {
    this.value.drawController.addListener(notifyListeners);
    for (var element in this.value.multiDrawControllers) {
      element.addListener(notifyListeners);
    }
  }

  addDraw() {
    value.multiDrawControllers.add(
        MultiDrawController(value: MultiDrawModel.zero())
          ..addListener(notifyListeners));
    notifyListeners();
  }

  removeDraw(MultiDrawController controller) {
    value.multiDrawControllers
        .remove(controller..removeListener(notifyListeners));
    notifyListeners();
  }

}

class MultiDrawModel {
  final DrawController drawController;
  final List<MultiDrawController> multiDrawControllers;

  MultiDrawModel(
      {required this.drawController, required this.multiDrawControllers});

  MultiDrawModel.zero()
      : this(drawController: DrawController(), multiDrawControllers: []);
}
