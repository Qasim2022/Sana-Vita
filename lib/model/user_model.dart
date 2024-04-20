class AddUserModel {

  String? name;
  int? id;
  String? email;
  String? password;
  int? age;
 // String? gender;
  double? height;
  double? weight;
  String? doc;
  String? experience;
  String? goals;
  String? trainPlace;
  String? diet;





  AddUserModel({
    this.email,
    this.name,
    this.password,
    this.age,
  //  this.gender,
    this.height,
    this.weight,
    this.experience,
    this.goals,
    this.trainPlace,
    this.diet,
    this.doc,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "password": password,
      "age": age,
     // "gender": gender,
      "height": height,
      "weight": weight,
      "experience": experience,
      "trainPlace": trainPlace,
      "diet": diet,
      "goals": goals,
      "doc": doc,
      "id": id,

    };
  }

  factory AddUserModel.fromJson(Map<String, dynamic> json) {
    return AddUserModel(
      email: json["email"] ?? "",
      name: json["name"] ?? "",
       password: json["password"] ?? "",
        age: json["age"] ??"",
      // gender: json["gender"] ?? "",
       height: json["height"] ??"",
       weight: json["weight"] ??"",
       experience: json["experience"] ?? "",
       trainPlace: json["trainPlace"] ?? "",
      diet: json["diet"] ?? "",

       goals: json["goals"] ?? "",

      doc: json["doc"] ?? "",
      id: json["id"] as int,

    );
  }
}
