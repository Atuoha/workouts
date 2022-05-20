import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/providers/exercise.dart';
import 'package:workout_app/providers/workout.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../model/workout.dart';
import 'dart:async';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);
  static const routeName = 'single';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late VideoPlayerController _controller;
  var isInit = true;
  var isFetched = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  late WorkOut workout;
  late Exercise exercise;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void didChangeDependencies() async {
    if (isInit) {
      try {
        var data =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        var id = data['id'] as int;
        workout = Provider.of<WorkOutData>(context, listen: false).findById(id);
        exercise =
            Provider.of<ExerciseData>(context, listen: false).findById(id);
      } catch (e) {
        // ignore: avoid_print
        print('error');
      }
    }
    setState(() {
      _controller = VideoPlayerController.network(
        workout.videoUrl
      )..initialize().then((_) {
          setState(
            () {},
          );
        });
    });
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    print('VIDEO URL: ' + workout.videoUrl);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
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
          setState(
            () {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
          );
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
                        backgroundImage: AssetImage(
                          workout.imageUrl,
                        ),
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
                            child: FutureBuilder(
                              future: _initializeVideoPlayerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  // If the VideoPlayerController has finished initialization, use
                                  // the data it provides to limit the aspect ratio of the video.
                                  return 
                                  
                                  
                                  AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    // Use the VideoPlayer widget to display the video.
                                    child: VideoPlayer(_controller),
                                  );
                                } else {
                                  // If the VideoPlayerController is still initializing, show a
                                  // loading spinner.
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
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



