import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/providers/workout.dart';

import '../model/workout.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);
  static const routeName = 'single';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var id = data['id'] as int;

    WorkOut workout = Provider.of<WorkOutData>(context, listen: false).findById(id);

    return Container();
  }
}
