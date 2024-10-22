import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mock form to be used in the builder
class MockForm extends FForm {}

void main() {
  group('FFormBuilder Tests', () {
    testWidgets('FFormBuilder builds form and provides it to builder',
        (tester) async {
      final form = MockForm();

      await tester.pumpWidget(
        FFormBuilder<MockForm>(
          form: form,
          builder: (context, providedForm) {
            // Check that the form is correctly provided to the builder
            expect(providedForm, form);
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('FFormBuilder listens to form updates', (tester) async {
      final form = MockForm();
      var didRebuild = false;

      await tester.pumpWidget(
        FFormBuilder<MockForm>(
          form: form,
          builder: (context, providedForm) {
            // Mark as rebuilt when the builder is called
            didRebuild = true;
            return const SizedBox();
          },
        ),
      );

      // Check that the builder has been initially called
      expect(didRebuild, true);

      // Reset rebuild flag and trigger notification
      didRebuild = false;
      form.notifyListeners();

      await tester.pump();

      // Check that the builder was called again after form update
      expect(didRebuild, true);
    });

    testWidgets('FFormBuilder provides form through FFormProvider',
        (tester) async {
      final form = MockForm();

      await tester.pumpWidget(
        FFormBuilder<MockForm>(
          form: form,
          builder: (context, providedForm) {
            // Try accessing form from FFormProvider
            final formFromProvider = FFormProvider.of<MockForm>(context);

            // Check that the form is provided correctly via FFormProvider
            expect(formFromProvider, form);
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('FFormBuilder rebuilds only when form updates', (tester) async {
      final form = MockForm();
      var rebuildCount = 0;

      await tester.pumpWidget(
        FFormBuilder<MockForm>(
          form: form,
          builder: (context, providedForm) {
            rebuildCount++;
            return const SizedBox();
          },
        ),
      );

      // Check that the builder was initially called once
      expect(rebuildCount, 1);

      // Notify listeners to trigger a rebuild
      form.notifyListeners();
      await tester.pump();

      // Check that the builder was called again after form update
      expect(rebuildCount, 2);
    });

    testWidgets('FFormBuilder does not rebuild if form does not update',
        (tester) async {
      final form = MockForm();
      var rebuildCount = 0;

      await tester.pumpWidget(
        FFormBuilder<MockForm>(
          form: form,
          builder: (context, providedForm) {
            rebuildCount++;
            return const SizedBox();
          },
        ),
      );

      // Check that the builder was initially called once
      expect(rebuildCount, 1);

      // Perform a pump without triggering form updates
      await tester.pump();

      // Ensure that the builder was not called again
      expect(rebuildCount, 1);
    });
  });
}
