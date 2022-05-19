import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/providers/exercise.dart';
import 'package:workout_app/providers/workout.dart';
import 'package:workout_app/screens/details.dart';

class HomePage extends StatelessWidget {
  Widget imageCircleAvatar(Color colored, String assetName, String title) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colored,
                blurRadius: 6,
                spreadRadius: 1,
                blurStyle: BlurStyle.outer,
              )
            ],
          ),
          child: CircleAvatar(
            backgroundColor: colored,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(assetName),
            ),
            radius: 23,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 221, 221),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/menu.png', width: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What can you today?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 15),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              elevation: 5,
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    fillColor: Colors.white,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imageCircleAvatar(
                  Colors.purple,
                  'assets/images/gym1.png',
                  'CrossFit',
                ),
                imageCircleAvatar(
                  Colors.deepOrange,
                  'assets/images/gym3.png',
                  'Gymnastics',
                ),
                imageCircleAvatar(
                  Colors.blue,
                  'assets/images/gym2.png',
                  'Fitness',
                ),
                imageCircleAvatar(
                  Colors.brown,
                  'assets/images/gym4.png',
                  'Aerobics',
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Without Packs',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            height: 200,
                            color: Colors.white,
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'All Exercises',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          Provider.of<ExerciseData>(context)
                                              .exerciseList
                                              .length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            DetailsPage.routeName,
                                            arguments: {
                                              'id': Provider.of<ExerciseData>(
                                                      context,listen: false)
                                                  .exerciseList[index]
                                                  .workOutId
                                            },
                                          );
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'assets/images/gym4.png',
                                              ),
                                            ),
                                          ),
                                          trailing: Image.asset(
                                            'assets/images/medal.png',
                                            width: 15,
                                          ),
                                          title: RichText(
                                            text: TextSpan(
                                                text: 'SQUAT ',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: Provider.of<
                                                            ExerciseData>(
                                                      context,
                                                      listen: false,
                                                    )
                                                        .exerciseList[index]
                                                        .squat,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text('View all exercises '))
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Provider.of<WorkOutData>(
                  context,
                  listen: false,
                ).workOutList.length,
                itemBuilder: ((context, index) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              Provider.of<WorkOutData>(
                                context,
                                listen: false,
                              ).workOutList[index].imageUrl,
                            ),
                          ),
                        ),
                        Positioned(
                          width: 250,
                          top: 15,
                          left: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${Provider.of<WorkOutData>(
                                      context,
                                      listen: false,
                                    ).workOutList[index].time} Hours',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${Provider.of<WorkOutData>(
                                      context,
                                      listen: false,
                                    ).workOutList[index].exercises} Exercises',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '\$${Provider.of<WorkOutData>(
                                      context,
                                      listen: false,
                                    ).workOutList[index].cost}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Provider.of<WorkOutData>(
                                context,
                                listen: false,
                              ).workOutList[index].isTopRated
                                  ? Image.asset(
                                      'assets/images/medal.png',
                                      width: 50,
                                    )
                                  : const Text('')
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 10,
                          child: Text(
                            Provider.of<WorkOutData>(
                              context,
                              listen: false,
                            ).workOutList[index].trainer,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
