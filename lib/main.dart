import 'package:flutter/material.dart';
import 'package:group_profile_app/app.dart';
import 'package:group_profile_app/services/firebase_initializer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.initialize();
  runApp(const GroupProfileApp());
}
