import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mock form to be used in the provider
class MockForm extends FForm {}

void main() {
  group('FFormProvider Tests', () {
    testWidgets('Form is provided to descendants', (tester) async {
      final form = MockForm();

      await tester.pumpWidget(
        FFormProvider<MockForm>(
          form: form,
          child: Builder(
            builder: (context) {
              // Access the form through the provider
              final providedForm = FFormProvider.of<MockForm>(context);

              // Check if the form is correctly retrieved
              expect(providedForm, form);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('maybeOf returns null when no form is provided',
        (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            // Try to access a form that is not provided
            final providedForm = FFormProvider.maybeOf<MockForm>(context);

            // Check if it correctly returns null
            expect(providedForm, isNull);
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('of throws error when no form is provided', (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            // Attempting to access a form without a provider should throw an error
            expect(
              () => FFormProvider.of<MockForm>(context),
              throwsArgumentError,
            );
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('updateShouldNotify returns true when form changes',
        (tester) async {
      final form1 = MockForm();
      final form2 = MockForm();

      final provider = FFormProvider<MockForm>(
        form: form1,
        child: const SizedBox(),
      );

      expect(
          provider.updateShouldNotify(
              FFormProvider(form: form2, child: const SizedBox())),
          true);
    });

    testWidgets('updateShouldNotify returns false when form does not change',
        (tester) async {
      final form = MockForm();

      final provider = FFormProvider<MockForm>(
        form: form,
        child: const SizedBox(),
      );

      expect(
          provider.updateShouldNotify(
              FFormProvider(form: form, child: const SizedBox())),
          false);
    });
  });
}
