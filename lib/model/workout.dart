class WorkOut {
  //model variables
  final int id;
  final String imageUrl;
  final String title;
  final String trainer;
  final double time;
  final int exercises;
  final int cost;
  final String description;
  final String videoUrl;
  final bool isTopRated;

  //model constructor
  WorkOut({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.trainer,
    required this.time,
    required this.exercises,
    required this.cost,
    required this.description,
    required this.videoUrl,
    required this.isTopRated,
  });
}
