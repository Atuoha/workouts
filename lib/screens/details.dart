import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/providers/exercise.dart';
import 'package:workout_app/providers/workout.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../model/workout.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);
  static const routeName = 'single';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late VideoPlayerController _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  late WorkOut workout;
  late Exercise exercise;

  // @override
  // void didChangeDependencies() {
   
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    super.initState();

   var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var id = data['id'] as int;

    Future.delayed(Duration.zero, () {
      setState(() {
        workout = Provider.of<WorkOutData>(context, listen: false).findById(id);
        exercise =
            Provider.of<ExerciseData>(context, listen: false).findById(id);

        _controller = VideoPlayerController.network(
          workout.videoUrl,
        )..initialize().then(
            (_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {});
            },
          );
      });
    });
  }

  Widget customListTile(String title, String duration) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        duration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.purple,
                ),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: workout.isTopRated
                ? Image.asset(
                    'assets/images/medal.png',
                    width: 30,
                  )
                : const Text(''),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  workout.imageUrl,
                ),
              ),
            ),
          ),
          SlidingUpPanel(
            backdropEnabled: true,
            minHeight: 80,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            panelBuilder: (ScrollController sc) => Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.trainer,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(workout.imageUrl),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('Coach')
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    workout.description,
                    textAlign: TextAlign.justify,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),

                          // VIDEO
                          Center(
                            child: _controller.value.isInitialized
                                ? AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 230,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.purple,
                                            blurRadius: 6,
                                            spreadRadius: 1,
                                            blurStyle: BlurStyle.outer,
                                          )
                                        ],
                                        // border: Border.all(
                                        //   width: 2,
                                        //   color: Colors.purple,
                                        // ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/oops.jpg',
                                          width: 180,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          //

                          const Divider(),
                          customListTile('Squat', exercise.squat),
                          const Divider(),
                          customListTile('Leg Press', exercise.legPress),
                          const Divider(),
                          customListTile('Lunge', exercise.lunge),
                          const Divider(),
                          customListTile(
                              'Leg Extension', exercise.legExtension),

                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.purple,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                              ),
                              onPressed: null,
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
