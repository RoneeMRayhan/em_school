import 'package:em_school/db/post_service.dart';
import 'package:em_school/models/post.dart';
import 'package:em_school/screens/edit_post.dart';
import 'package:em_school/screens/home.dart';
import 'package:em_school/screens/name.dart';
import 'package:em_school/screens/view_post.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formKey = GlobalKey();
  Post post = Post(0, " ", " ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        elevation: 0.0,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Post Title",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => post.title = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Title filled can't be empty";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Post Body",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => post.body = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Body filled can't be empty";
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertPost();
          //Navigator.pop(context);
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPost(post)));
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewPost(post)));
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Name()));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.purple,
        tooltip: "Add a post",
      ),
    );
  }

  void insertPost() {
    final FormState form = formKey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService = PostService(post.toMap());
      postService.addPost();
      Fluttertoast.showToast(
        msg: "Data inserted successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }
}
