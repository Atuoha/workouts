import 'package:flutter/cupertino.dart';
import '../model/exercise.dart';

class ExerciseData extends ChangeNotifier {

  // You can still make this a list if two or more Exercises can be categorized under a particular workout
  Exercise exercise(int id) {
    return exerciseList.firstWhere((exercise) => exercise.workOutId == id);
  }

  //Method to get the lists
  final List<Exercise> exerciseList = [
    Exercise(
      workOutId: 0,
      squat: '3 x 15',
      legPress: '2 x 8',
      lunge: '4 x 30',
      legExtension: '3 x 12',
    ),
    Exercise(
      workOutId: 1,
      squat: '4 x 15',
      legPress: '3 x 8',
      lunge: '5 x 30',
      legExtension: '3 x 12',
    ),
    Exercise(
      workOutId: 2,
      squat: '2 x 15',
      legPress: '4 x 8',
      lunge: '6 x 30',
      legExtension: '4 x 12',
    ),
    Exercise(
      workOutId: 3,
      squat: '4 x 15',
      legPress: '5 x 8',
      lunge: '7 x 30',
      legExtension: '4 x 12',
    ),
  ];
}
