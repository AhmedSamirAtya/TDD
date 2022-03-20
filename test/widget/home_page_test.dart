import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/business/cubit/cubit/notes_cubit.dart';
import 'package:tdd/presentaion/screens/myhomepage.dart';
import 'package:tdd/presentaion/screens/note_page.dart';

void main() {
  group('home page', () {
    _pumpTestWidget(WidgetTester tester, NotesCubit cubit) => tester.pumpWidget(
          MaterialApp(
            home: MyHomePage(title: 'T', notesCubit: cubit),
          ),
        );

    testWidgets(
      "empty State",
      (WidgetTester tester) async {
        await _pumpTestWidget(tester, NotesCubit());
        expectSync(find.byType(ListView), findsOneWidget);
        expectSync(find.byType(ListTile), findsNothing);
      },
    );
    testWidgets('updated when notes added', (WidgetTester tester) async {
      var cubit = NotesCubit();
      await _pumpTestWidget(tester, cubit);
      cubit.createNote('title', 'body1');
      cubit.createNote('title2', 'body2');
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text('title'), findsOneWidget);
      expect(find.widgetWithText(ListTile, 'title2'), findsOneWidget);
    });

    testWidgets('update when anote deleted', (WidgetTester tester) async {
      var cubit = NotesCubit();
      await _pumpTestWidget(tester, cubit);
      cubit.createNote('title1', 'body1');
      cubit.createNote('title2', 'body2');
      //await tester.pump(); // make exception if not commented
      cubit.deleteNote(1);
      await tester.pump();
      expectSync(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expectSync(find.text('body1'), findsNothing);
      expectSync(find.text('title2'), findsOneWidget);
    });

    testWidgets('navigate to note page', (WidgetTester tester) async {
      var cubit = NotesCubit();
      await _pumpTestWidget(tester, cubit);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
    });

    testWidgets('navigate to notepage in edit mode',
        (WidgetTester tester) async {
      var cubit = NotesCubit();
      await _pumpTestWidget(tester, cubit);
      cubit.createNote('note title', 'note body');
      await tester.pump();
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
      expect(find.text('note title'), findsOneWidget);
    });
  });
}
