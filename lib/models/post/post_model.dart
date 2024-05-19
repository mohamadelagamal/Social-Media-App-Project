
class PostModel {
  final String id;
  final String name;
  final String photoUrl;
  String dateTime;
  String text;
  String postImage;

  PostModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  // factory use to create an instance of the class from a map object (json object)
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        id: map['id'],
        name: map['name'],
        photoUrl: map['photoUrl'],
        dateTime: map['dateTime'],
        text: map['text'],
        postImage: map['postImage'],

    );
  }

  // toMap method to convert the class object to a map object (json object)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
// from json

}