import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_mvvm/data/datasources/db/database_helpers.dart';
import 'package:notes_mvvm/presentation/pages/add_edit_note_page.dart';
import 'package:notes_mvvm/presentation/pages/home_page.dart';
import 'package:notes_mvvm/presentation/widgets/home/edit_button_component.dart';
import 'package:notes_mvvm/presentation/widgets/home/home_list_item_component.dart';

import '../../my_app.dart';
import '../../notes_dummy_data.dart';
import '../test_helpers.mocks.dart';

void main() {
  late MockDatabaseHelpers database;

  setUpAll(() => database = MockDatabaseHelpers());

  testWidgets(
      'Given notes When click on edit button Then navigate to edit screen',
      (tester) async {
    // ARRANGE
    when(database.getAllNotes()).thenAnswer((_) async => [
          dummyNotes[0],
          dummyNotes[1],
        ]);
    when(database.deleteNotes(noteId: anyNamed('noteId')))
        .thenAnswer((_) async => null);

    await tester.pumpWidget(ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
      ],
      child: const MyApp(),
    ));

    await tester.pump();
    final noteItemComponent = find.byType(HomeListItemComponent);
    expect(noteItemComponent, findsNWidgets(2));

    // ACT
    final noteItem1 = find.byKey(const Key('noteId1'));

    await tester.tap(find.byType(EditButtonComponent).last);
    await tester.pumpAndSettle();
    // ASSERT
    expect(find.byType(AddEditNote), findsOneWidget);
    expect(find.text('editNote'), findsOneWidget);

    // ACT
    await tester.tap(find.byKey(const Key('backButton')));
    await tester.pumpAndSettle();
    // ASSERT
    expect(find.byType(AddEditNote), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
