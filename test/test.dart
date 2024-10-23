import 'package:flutter_test/flutter_test.dart';

import './builder_test.dart' as builder_test;
import './cached_mixin_test.dart' as cached_mixin_test;
import './field_test.dart' as field_test;
import './form_test.dart' as form_test;
import './provider_test.dart' as provider_test;

void main() {
  group('FForm test', () {
    field_test.main();
    form_test.main();
    provider_test.main();
    builder_test.main();
    cached_mixin_test.main();
  });
}
