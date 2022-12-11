
class UserModel{

  String? id;
  String fullName;
  String email;
  String password;

  UserModel({

    this.id,
    required this.fullName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> ToJson()=>{
    "id": id,
    "fullName": fullName,
    "email": email,
  };
}