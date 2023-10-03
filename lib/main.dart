import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hive_state_master/presentation/router/router.dart';
import 'package:flutter_hive_state_master/util/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox(likeDB);

  runApp(FlutterHiveMaster(
    router: AppRouter(),
  ));
}

class FlutterHiveMaster extends StatelessWidget {
  final AppRouter? router;

  const FlutterHiveMaster({this.router, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: router!.generateRoute,
    );
  }
}
