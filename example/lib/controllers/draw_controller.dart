import 'package:flutter/cupertino.dart';

import '../models/models.dart';

class DrawController extends ValueNotifier<DrawModel> {
  DrawController() : super(DrawModel.zero());

  change({String? title, String? description}) {
    value
      ..title = title ?? value.title
      ..description = description ?? value.description;
    notifyListeners();
  }
}
