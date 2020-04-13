import 'package:em_school/screens/edit_post.dart';
import 'package:flutter/material.dart';
import 'package:em_school/db/post_service.dart';
import 'package:em_school/models/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewPost extends StatefulWidget {
  //ViewPost({Key key}) : super(key: key);
  final Post post;
  ViewPost(this.post);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  //String widgetPostTitle = "ViewPost";
  //int widgetPostDate = 13042020;
  //Map widgetPost_toMap = {"title": "Title", "body": "Body"};
  //String widgetPostBody = "Body";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    timeago.format(
                        DateTime.fromMillisecondsSinceEpoch(widget.post.date)),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    PostService postService = PostService(widget.post.toMap());
                    postService.deletePost();
                    Navigator.pop(context);
                  }),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPost(widget.post)));
                },
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(88.0),
            child: Text(widget.post.body),
          )
        ],
      ),
    );
  }
}
