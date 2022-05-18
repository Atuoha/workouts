import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/providers/exercise.dart';
import 'package:workout_app/screens/details.dart';
import 'providers/workout.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExerciseData()),
        ChangeNotifierProvider(create: (context) => WorkOutData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.purple,
        ),
        home: HomePage(),
        routes: {
          DetailsPage.routeName: (context) => const DetailsPage(),
        },
      ),
    );
  }
}
