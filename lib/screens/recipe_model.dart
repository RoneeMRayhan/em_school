import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class PostList {
  List<PostDetailListItem> postList;

  PostList({this.postList});

  factory PostList.fromJSON(Map<dynamic, dynamic> json) {
    return PostList(postList: parsePosts(json));
  }

  static List<PostDetailListItem> parsePosts(postJSON) {
    var rList = postJSON['posts'] as List;
    List<PostDetailListItem> postList =
        rList.map((data) => PostDetailListItem.fromJson(data)).toList();
    return postList;
  }
}

class PostDetailListItem {
  String title;
  String body;

  PostDetailListItem({this.title, this.body});

  factory PostDetailListItem.fromJson(Map<dynamic, dynamic> parsedJson) {
//    print(parsedJson);
    return PostDetailListItem(
        title: parsedJson['title'], body: parsedJson['body']);
  }
}

class MakeCall {
  List<PostDetailListItem> listItems = [];

  Future<List<PostDetailListItem>> firebaseCalls(
      DatabaseReference databaseReference) async {
    PostList postList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value['posts'][dataSnapshot];//[0]['content'];
    postList = new PostList.fromJSON(jsonResponse);
    listItems.addAll(postList.postList);

    return listItems;
  }
}
