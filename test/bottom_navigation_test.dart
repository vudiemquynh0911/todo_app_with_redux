// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child ui.widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:manabietodo/main.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../lib/models/task_model.dart';

void initialiseHive() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(TaskModelAdapter());

}

void main() async {
  initialiseHive() ;
  testWidgets('Bottom navigation bar testing', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // All-tasks tab
    final firstTab = find.byKey(Key('all-task'));
    await tester.tap(firstTab);
    await tester.pump();
    final allFinder = find.text('You have no task');
    expect(allFinder, findsOneWidget);

    // Pending tab
    final secondTab = find.byKey(Key('todo'));
    await tester.tap(secondTab);
    await tester.pump();
    final toDoFinder = find.text('You have no pending task');
    expect(toDoFinder, findsOneWidget);

    // Done tasks tab
    final thirdTab = find.byKey(Key('done-task'));
    await tester.tap(thirdTab);
    await tester.pump();
    final doneFinder = find.text('You have no complete task');
    expect(doneFinder, findsOneWidget);
  });
}
