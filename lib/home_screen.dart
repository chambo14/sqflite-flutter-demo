import 'package:flutter/material.dart';
import 'package:formation_flutter/dog_model.dart';
import 'package:formation_flutter/new_dog_screen.dart';
import 'package:formation_flutter/widget_dog.dart';

import 'helpers/database_helper.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key,}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Dog>? dog;
  bool isLoading = false;

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    refreshDogList();
  }

  @override
  void initState() {
    super.initState();
    refreshDogList();
  }

  @override
  void dispose() {
    //DatabaseHelper.instance.close();
    super.dispose();
  }

  Future refreshDogList() async {
    setState(() => isLoading = true);
    this.dog = await DatabaseHelper.instance.readAllDog();
    print("ceci est $dog");
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List dogs"),
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : dog!.isEmpty
                    ? Text("Pas de chiens")
                    : buildDog()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewDogScreen()));
          refreshDogList();
          //  Get.to(NewTeacher() );
        },
        icon: Icon(Icons.add),
        label: Text('Ajout'),
      ),
    );
  }

  Widget buildDog() => ListView.builder(
        itemCount: dog?.length,
        itemBuilder: (BuildContext context, int index) {
          final vardog = dog![index];
          print("le nom esr ${dog?[index].name}");
          print(vardog);
          return WidgetDog(dogs: vardog,);

        },
      );
}
