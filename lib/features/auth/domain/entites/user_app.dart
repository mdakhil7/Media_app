// step 1 create the model

class AppUser {
  final String uid;
  final String name;
  final String email;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
  });

//covert userData to json

  Map<String, dynamic> tojson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  //convert json to appData
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      name: jsonUser['name'],
      email: jsonUser['email'],
    );
  }
}
