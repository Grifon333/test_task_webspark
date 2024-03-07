import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_task/domain/entity/point.dart';
import 'package:test_task/domain/entity/way.dart';
import 'package:test_task/ui/navigation/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PointAdapter());
  Hive.registerAdapter(ResultAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = MainNavigation();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: false,
      ),
      routes: navigation.routes,
      initialRoute: navigation.initialRoute,
      onGenerateRoute: navigation.onGenerateRoute,
    );
  }
}