import 'package:flutter_test/flutter_test.dart';
import 'package:notes_mvvm/core/utils/validators.dart';

void main() {
  group('Add/Edit Note Form Field Validate', () {
    group('Note Id Validate', () {
      test('Given empty id when validate called then validator is triggered',
          () async {
        const id = '';
        final result = Validators.instance.validateInteger(id);

        expect(result, 'ThisFieldIsEmpty');
      });

      test(
          'Given non-numeric id when validate called then validator is triggered',
          () async {
        const id = 'ABC123';
        final result = Validators.instance.validateInteger(id);

        expect(result, 'pleaseEnterOnlyNumericValues');
      });
      test(
          'Given more tahan 30 character id when validate called then validator is triggered',
          () async {
        const id = '123456789123456789123456789123456789';
        final result = Validators.instance.validateInteger(id);

        expect(result, 'idMustBeAtMost30Numbers');
      });
      test(
          'Given valid id When validate called Then validator is not triggered',
          () async {
        const id = '1234';
        final result = Validators.instance.validateInteger(id);
        expect(result, null);
      });
    });

    /// test title
    group('Note title Validate', () {
      test('Given empty title when validate called then validator is triggered',
          () async {
        const title = '';
        final result = Validators.instance.validateTitle(title);

        expect(result, 'ThisFieldIsEmpty');
      });

      test(
          'Given more tahan 30 character title when validate called then validator is triggered',
          () async {
        const title = '123456789123456789123456789123456789';
        final result = Validators.instance.validateTitle(title);

        expect(result, 'titleMustBeAtMost30Letters');
      });
      test(
          'Given valid title When validate called Then validator is not triggered',
          () async {
        const title = 'title';
        final result = Validators.instance.validateTitle(title);
        expect(result, null);
      });
    });

    /// test description
    group('Note description Validate', () {
      test(
          'Given empty description when validate called then validator is triggered',
          () async {
        const description = '';
        final result = Validators.instance.validateDescription(description);

        expect(result, 'ThisFieldIsEmpty');
      });

      test(
          'Given valid description When validate called Then validator is not triggered',
          () async {
        const description = 'description';
        final result = Validators.instance.validateDescription(description);
        expect(result, null);
      });
    });
  });
}
