import 'package:flutter/material.dart';
import 'package:formation_flutter/dog_model.dart';

import 'helpers/database_helper.dart';

class NewDogScreen extends StatefulWidget {
  const NewDogScreen({Key? key,this.dog}) : super(key: key);
  final Dog? dog;

  @override
  _NewDogScreenState createState() => _NewDogScreenState();
}

class _NewDogScreenState extends State<NewDogScreen> {
  final dbHelper = DatabaseHelper.instance;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameDog = TextEditingController();
  TextEditingController age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(top: 100, left: 30, right: 30),
          children: [
            nameTextField(),
            SizedBox(height: 30,),
            ageTextField(),
            SizedBox(height: 30,),
            buildButton()
          ],
        ),
      ),
    );
  }
  Widget ageTextField() {
    return TextFormField(
      controller: age,
      validator: (value) {
        if (value!.isEmpty) return "Veuillez saisir son age";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.date_range,
          color: Colors.indigo,
        ),
        labelText: "Age",
        hintText: "Ex: 5 mois",
      ),
      keyboardType: TextInputType.number,
    );
  }
  Widget nameTextField() {
    return TextFormField(
      controller: nameDog,
      validator: (value) {
        if (value!.isEmpty) return "Veuillez saisir le nom";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.indigo,
        ),
        labelText: "Nom",
        hintText: "Ex: Johnny",
      ),

    );
  }
  Widget buildButton() {
    final isFormValid = nameDog.text.isNotEmpty && age.text.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.indigo,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          minimumSize: Size(20, 50),
        ),
        onPressed:addOrUpdateInformationDog ,
        child: Text('Enregistrer',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
      ),
    );
  }

  void addOrUpdateInformationDog() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.dog != null;

      if (isUpdating) {
        await updateDog();
      } else {
        await addTeacher();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateDog() async {
    final dog = Dog(
      name: nameDog.text,
      age : age.text,

    );

    await DatabaseHelper.instance.updateDog(dog);
  }
  Future addTeacher() async {
    final dog = Dog(
      name: nameDog.text,
      age: age.text,

    );
    await DatabaseHelper.instance.createNewDog(dog);
  }

}
