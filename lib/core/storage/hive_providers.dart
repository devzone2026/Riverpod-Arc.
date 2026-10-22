import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'hive_boxes.dart';

part 'hive_providers.g.dart';

// Boxes are exposed as providers so data sources never touch the global
// `Hive` object, and tests can override them with in-memory boxes.

@Riverpod(keepAlive: true)
Box<dynamic> todosBox(Ref ref) => Hive.box<dynamic>(HiveBoxes.todos);

@Riverpod(keepAlive: true)
Box<dynamic> chatBox(Ref ref) => Hive.box<dynamic>(HiveBoxes.chat);

@Riverpod(keepAlive: true)
Box<dynamic> settingsBox(Ref ref) => Hive.box<dynamic>(HiveBoxes.settings);
