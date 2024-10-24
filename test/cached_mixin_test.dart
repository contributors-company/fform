// Тестовый класс
import 'package:fform/fform.dart';
import 'package:flutter_test/flutter_test.dart';

class TestFormField extends FFormField<String, String>
    with CacheField<String, String> {
  TestFormField(String value) : super(value);

  int validationCallCount = 0;

  @override
  String? validator(String value) {
    validationCallCount++;
    if (value.isEmpty) {
      return 'Value cannot be empty';
    }
    return null;
  }
}

// Класс для тестирования с Map<String, dynamic>
class MapFormField extends FFormField<Map<String, dynamic>, String>
    with CacheField<Map<String, dynamic>, String> {
  MapFormField(Map<String, dynamic> value) : super(value);

  int validationCallCount = 0;

  @override
  String? validator(Map<String, dynamic> value) {
    validationCallCount++;
    if (value.isEmpty) {
      return 'Map cannot be empty';
    }
    return null;
  }
}

void main() {
  group('ValidationCachingMixin Tests', () {
    late TestFormField field;
    late MapFormField mapField;

    setUp(() {
      field = TestFormField('initial');
    });

    test('Caches validation results for the same value', () async {
      // Первичная проверка
      await field.check();
      expect(field.isValid, isTrue);
      expect(field.validationCallCount, equals(1));

      // Повторная проверка с тем же значением
      await field.check();
      expect(field.isValid, isTrue);
      expect(field.validationCallCount, equals(1),
          reason: 'Validator should not be called again for the same value');

      // Изменение значения на невалидное
      field.value = '';
      await field.check();
      expect(field.isValid, isFalse);
      expect(field.exception, equals('Value cannot be empty'));
      expect(field.validationCallCount, equals(2));

      // Повторная проверка с тем же невалидным значением
      await field.check();
      expect(field.isValid, isFalse);
      expect(field.validationCallCount, equals(2),
          reason:
              'Validator should not be called again for the same invalid value');

      // Возврат к предыдущему значению
      field.value = 'initial';
      await field.check();
      expect(field.isValid, isTrue);
      expect(field.validationCallCount, equals(2),
          reason: 'Validator should use cached result for previous value');
    });

    test('Enforces cache size limit', () async {
      // Наполняем кэш до предела
      field.validationCallCount = 0;

      for (var i = 0; i < 50; i++) {
        field.value = 'value$i';
        await field.check();
      }
      expect(field.validationCallCount, equals(50));

      // Следующее значение должно вызвать удаление самой старой записи
      field.value = 'value_new';
      await field.check();
      expect(field.validationCallCount, equals(51));
      expect(field.isValid, isTrue);

      // Проверяем, что первое значение удалено из кэша
      field.value = 'value0';
      await field.check();
      expect(field.validationCallCount, equals(52),
          reason: 'Validator should be called again after cache eviction');
    });

    setUp(() {
      mapField = MapFormField({'key': 'value'});
    });

    test('Handles deep equality for complex values', () async {
      // Используем поле с Map<String, dynamic>

      expect(mapField.isValid, isTrue);
      expect(mapField.validationCallCount, equals(1));

      // Повторная проверка с тем же значением
      await mapField.check();
      expect(mapField.validationCallCount, equals(1));

      // Изменение значения
      mapField.value = {'key': 'value', 'newKey': 'newValue'};
      await mapField.check();
      expect(mapField.validationCallCount, equals(2));

      // Возврат к предыдущему значению
      mapField.value = {'key': 'value'};
      await mapField.check();
      expect(mapField.validationCallCount, equals(2),
          reason: 'Validator should use cached result for previous value');
    });
  });
}
