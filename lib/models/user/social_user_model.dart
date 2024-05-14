
class SocialUserModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String phone;
  final bool isEmailVerified;
  String bio;
  String cover;

  SocialUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.cover,
    required this.phone,
    required this.bio,
    required this.isEmailVerified
  });

  // factory use to create an instance of the class from a map object (json object)
  factory SocialUserModel.fromMap(Map<String, dynamic> map) {
    return SocialUserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      phone: map['phone'],
      bio: map['bio'],
      cover: map['cover'],
      isEmailVerified: map['isEmailVerified']
    );
  }

  // toMap method to convert the class object to a map object (json object)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'phone':phone,
      'bio':bio,
      'cover':cover,
      'isEmailVerified':isEmailVerified
    };
  }
  // from json

}