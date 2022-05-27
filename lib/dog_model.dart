class Dog {
   int? id;
   String? name;
   String? age;

   Dog({
    this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

   Dog.fromJson(Map<String, dynamic> json){
     id = json['id'];
     name = json['name'];
     age = json['age'];
   }

   // Implement toString to make it easier to see information about
  // each dog when using the print statement.

}