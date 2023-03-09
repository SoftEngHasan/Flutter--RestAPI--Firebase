import 'package:flutter/material.dart';
import 'package:softbyhasan/ui/screens/SplashScreen.dart';

main(){
  runApp(TaskManager());
}

class TaskManager extends StatefulWidget {
  TaskManager({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: TaskManager.globalKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
