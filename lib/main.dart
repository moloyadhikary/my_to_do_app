import 'package:flutter/material.dart';
import 'package:my_to_do_app/app.dart';
import 'package:my_to_do_app/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(() => const App());
}
