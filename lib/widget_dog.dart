import 'package:flutter/material.dart';

import 'dog_model.dart';

class WidgetDog extends StatelessWidget {
  const WidgetDog({Key? key,this.dogs}) : super(key: key);
  final Dog? dogs;



  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("${dogs!.name}"),

        subtitle: Text("${dogs!.age}"),
      ),
    );
  }
}
