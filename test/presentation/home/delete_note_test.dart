import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_mvvm/data/datasources/db/database_helpers.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';
import 'package:notes_mvvm/presentation/widgets/home/home_list_item_component.dart';

import '../../my_app.dart';
import '../../notes_dummy_data.dart';
import '../test_helpers.mocks.dart';

void main() {
  late MockDatabaseHelpers client;

  setUpAll(() {
    client = MockDatabaseHelpers();
  });

  group('delete notes cases', () {
    testWidgets('Given notes when dismiss note then delete it',
        (widgetTester) async {
      when(client.getAllNotes()).thenAnswer((_) async => [
            dummyNotes[0],
            dummyNotes[1],
          ]);
      when(client.deleteNotes(noteId: anyNamed('noteId')))
          .thenAnswer((_) async => null);

      await widgetTester.pumpWidget(ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(client),
        ],
        child: const MyApp(),
      ));

      await widgetTester.pump();
      final noteItemComponent = find.byType(HomeListItemComponent);
      expect(noteItemComponent, findsNWidgets(2));
      final noteItem1 = find.byKey(const Key('noteId1'));
      //act

      await widgetTester.drag(noteItem1, const Offset(500.0, 0.0));
      await widgetTester.pumpAndSettle();

      // //assert
      // expect(noteItemComponent, findsNWidgets(1));
      // expect(noteItem1, findsNothing);
    });
  });

  testWidgets(
      'Given notes when select notes adn press delete then delete selected notes and clear selection',
      (widgetTester) async {
    when(client.getAllNotes()).thenAnswer((_) async {
      return [
        dummyNotes[0],
        dummyNotes[1],
      ];
    });
    when(client.deleteMultipleNotes(noteIds: anyNamed('noteIds')))
        .thenAnswer((_) async => null);

    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(client),
        ],
        child: const MyApp(),
      ),
    );

    await widgetTester.pump();
    final noteItemComponent = find.byType(HomeListItemComponent);
    expect(noteItemComponent, findsNWidgets(2));
    final noteItem1 = find.byKey(const Key('noteId1'));
    final noteItem2 = find.byKey(const Key('noteId2'));
    final selectedItems = find.byKey(const Key('selectedItems'));
    final deleteItemsButton = find.byKey(const Key('deleteItemsButton'));

    //act

    await widgetTester.longPress(noteItem1);
    await widgetTester.pump();
    await widgetTester.ensureVisible(noteItem2);
    await widgetTester.pump();
    await widgetTester.tap(noteItem2);
    await widgetTester.pump();
    expect(
      widgetTester.widget(selectedItems),
      isA<CustomText>().having((t) => (t.child as Text).data, 'data', '2'),
    );
    await widgetTester.tap(deleteItemsButton);
    await widgetTester.pump();

    //assert

    expect(selectedItems, findsNothing);
    expect(noteItemComponent, findsNothing);
  });
}
