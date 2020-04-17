import 'package:em_school/models/post.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  final Post post;

  EditPost(this.post);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Text"),
        elevation: 0.0,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.post.title,
                decoration: InputDecoration(
                  labelText: "Post Title",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => widget.post.title = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Text Field can't be empty";
                  }
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.post.body,
                decoration: InputDecoration(
                  labelText: "Post Body",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => widget.post.body = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Body Field can't be empty";
                  } else if (val.length > 16) {
                    return "Body can't have more than 16 characters";
                  }
                  return '';
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
