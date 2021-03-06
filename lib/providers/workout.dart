import 'package:flutter/cupertino.dart';
import '../model/workout.dart';

class WorkOutData extends ChangeNotifier {

  WorkOut findById(int id) {
    return workOutList.firstWhere((workout) => workout.id == id);
  }

  //method to fetch workout list
  final List<WorkOut> workOutList = [
    WorkOut(
      id: 0,
      imageUrl: 'https://atuoha.github.io/project-assets.github.io/workout-assets/images/img1.jpg',
      trainer: 'Jane Philips',
      title: 'Crossfit',
      time: 2,
      exercises: 12,
      cost: 12000,
      description:
          'A form of high intensity interval training, CrossFit is a strength and conditioning workout that is made up of functional movement performed at a high intensity level.',
      videoUrl: 'https://atuoha.github.io/project-assets.github.io/workout-assets/videos/crossfit.mp4',
      isTopRated: true,
    ),
    WorkOut(
      id: 1,
      imageUrl: 'https://atuoha.github.io/project-assets.github.io/workout-assets/images/img2.jpg',
      trainer: 'Mary Daniels',
      title: 'Fitness',
      time: 3.6,
      exercises: 15,
      cost: 15800,
      description:
          'Fitness is the ability to function efficiently in an active environment that suits your personal interests and goals.',
      videoUrl: 'https://atuoha.github.io/project-assets.github.io/workout-assets/videos/fitness.mp4',
      isTopRated: false,
    ),
    WorkOut(
      id: 2,
      imageUrl: 'https://atuoha.github.io/project-assets.github.io/workout-assets/images/img3.jpg',
      trainer: 'Janet Cruiz',
      title: 'Gymnastics',
      time: 2.4,
      exercises: 11,
      cost: 13500,
      description:
          'Gymnastics is a sport that includes physical exercises requiring balance, strength, flexibility, agility, coordination, dedication and endurance. ',
      videoUrl: 'https://atuoha.github.io/project-assets.github.io/workout-assets/videos/gymnastics.mp4',
      isTopRated: false,
    ),
    WorkOut(
      id: 3,
      imageUrl: 'https://atuoha.github.io/project-assets.github.io/workout-assets/images/img4.jpg',
      trainer: 'Lilian Whyte',
      title: 'Aerobics',
      time: 4.0,
      exercises: 16,
      cost: 16000,
      description:
          'Aerobics is a form of physical exercise that combines rhythmic aerobic exercise with stretching and strength training routines with the goal of improving all elements of fitness.',
      videoUrl: 'https://atuoha.github.io/project-assets.github.io/workout-assets/videos/aerobics.mp4',
      isTopRated: true,
    ),
  ];
}
