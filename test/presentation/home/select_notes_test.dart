import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_mvvm/data/datasources/db/database_helpers.dart';
import 'package:notes_mvvm/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';
import 'package:notes_mvvm/presentation/widgets/home/home_list_item_component.dart';
import 'package:notes_mvvm/presentation/widgets/home/multi_selection_header_component.dart';

import '../../my_app.dart';
import '../../notes_dummy_data.dart';
import '../test_helpers.mocks.dart';

void main() {
  late MockDatabaseHelpers database;

  setUpAll(() => database = MockDatabaseHelpers());

  group('select notes cases', () {
    testWidgets('Given notes when long tap on notes then select/unselect notes',
        (widgetTester) async {
      when(database.getAllNotes()).thenAnswer((_) async => [
            dummyNotes[0],
            dummyNotes[1],
          ]);
      await widgetTester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(database),
          ],
          child: const MyApp(),
        ),
      );

      await widgetTester.pump();
      final noteItemComponent = find.byType(HomeListItemComponent);
      expect(noteItemComponent, findsNWidgets(2));
      final note1 = find.byKey(const Key('noteId1'));
      final note2 = find.byKey(const Key('noteId2'));
      final selectedItems = find.byKey(const Key('selectedItems'));
      final clearSelectedItems = find.byKey(const Key('clearSelectedItems'));

      await widgetTester.longPress(note1);
      await widgetTester.pump();
      expect(find.byType(MultiSelectionHeaderComponent), findsOneWidget);
      expect(
        widgetTester.widget(selectedItems),
        isA<CustomText>().having((t) => (t.child as Text).data, 'data', '1'),
      );
      await widgetTester.ensureVisible(note2);
      await widgetTester.pump();
      await widgetTester.tap(note2);
      await widgetTester.pump();
      expect(
          widgetTester.widget(selectedItems),
          isA<CustomText>()
              .having((text) => (text.child as Text).data, 'data', '2'));

      await widgetTester.tap(note2);
      await widgetTester.pump();
      expect(
          widgetTester.widget(selectedItems),
          isA<CustomText>()
              .having((text) => (text.child as Text).data, 'data', '1'));
      await widgetTester.tap(clearSelectedItems);
      await widgetTester.pump();
      expect(selectedItems, findsNothing);
    });
  });
}
