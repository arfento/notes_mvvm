import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_mvvm/data/datasources/db/database_helpers.dart';
import 'package:notes_mvvm/presentation/widgets/home/home_list_item_component.dart';

import '../../my_app.dart';
import '../../notes_dummy_data.dart';
import '../test_helpers.mocks.dart';

void main() {
  late MockDatabaseHelpers database;

  setUpAll(() => database = MockDatabaseHelpers());

  group('get notes cases', () {
    testWidgets(
        'Given empty note when note screen open then show loading animation then show text',
        (widgetTester) async {
      when(database.getAllNotes()).thenAnswer((_) async => []);
      await widgetTester.pumpWidget(
        ProviderScope(overrides: [
          databaseProvider.overrideWithValue(database),
        ], child: const MyApp()),
      );

      final loadingAnimation = find.byKey(const Key('smallLoadingAnimation'));
      expect(loadingAnimation, findsOneWidget);
      await widgetTester.pump();
      expect(loadingAnimation, findsNothing);
      expect(find.byType(ListView), findsNothing);
      expect(find.byKey(const Key('noVisualNotes')), findsOneWidget);
    });
  });

  testWidgets(
      'Given 1 note when screen open then show loading animation then show listview with 1 note  ',
      (widgetTester) async {
    when(database.getAllNotes())
        .thenAnswer((realInvocation) async => [dummyNotes[0]]);
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
        ],
        child: const MyApp(),
      ),
    );

    final loadingAnimation = find.byKey(const Key('smallLoadingAnimation'));
    expect(loadingAnimation, findsOneWidget);
    await widgetTester.pump();

    final noteItemComponent = find.byType(HomeListItemComponent);
    expect(loadingAnimation, findsNothing);
    expect(find.byType(ListView), findsOneWidget);
    expect(noteItemComponent, findsOneWidget);
    expect(widgetTester.widgetList(noteItemComponent), [
      isA<HomeListItemComponent>().having(
        (itemComponent) => itemComponent.visualNoteModel.noteId,
        'visualNoteModel.noteId',
        'noteId1',
      ),
    ]);
  });
}
