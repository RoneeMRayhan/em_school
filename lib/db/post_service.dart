import 'package:firebase_database/firebase_database.dart';

class PostService {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  String nodeNamePath = "posts";
  Map postMap;

  PostService(this.postMap);

  addPost() {
    _databaseReference = database.reference().child(nodeNamePath);
    _databaseReference.push().set(postMap);
  }

  deletePost() {
    _databaseReference =
        database.reference().child('$nodeNamePath/${postMap['key']}');
    _databaseReference.remove();
  }

  updatePost() {
    _databaseReference =
        database.reference().child('$nodeNamePath/${postMap['key']}');
    _databaseReference.update({
      "title": postMap['title'],
      "body": postMap['body'],
      "date": postMap['date']
    });
  }
}
