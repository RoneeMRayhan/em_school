/* import 'package:flutter/material.dart';
import 'package:em_school/screens/home.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
      primaryColor: Colors.amber,
    ),
  ));
}
 */
/* 

// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'EMSchool',
    options: const FirebaseOptions(
      googleAppID: '1:764839444814:android:08563c9ce96a2446d29e1f',
      gcmSenderID: '764839444814',
      apiKey: 'AIzaSyDlu325cSUy2QOEtkOunU0TwIEGPxmULy4',
      projectID: 'emschool-95101',
    ),
  );
  final Firestore firestore = Firestore(app: app);

  runApp(MaterialApp(
      title: 'Firestore Example', home: MyHomePage(firestore: firestore)));
}

class MessageList extends StatelessWidget {
  MessageList({this.firestore});

  final Firestore firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("messages")
          .orderBy("created_at", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final int messageCount = snapshot.data.documents.length;
        return ListView.builder(
          itemCount: messageCount,
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            final dynamic message = document['message'];
            return ListTile(
              trailing: IconButton(
                onPressed: () => document.reference.delete(),
                icon: Icon(Icons.delete),
              ),
              title: Text(
                message != null ? message.toString() : '<No message retrieved>',
              ),
              subtitle: Text('Message ${index + 1} of $messageCount'),
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({this.firestore});

  final Firestore firestore;

  CollectionReference get messages => firestore.collection('messages');

  Future<void> _addMessage() async {
    await messages.add(<String, dynamic>{
      'message': 'Hello world!',
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _runTransaction() async {
    firestore.runTransaction((Transaction transaction) async {
      final allDocs = await firestore.collection("messages").getDocuments();
      final toBeRetrieved =
          allDocs.documents.sublist(allDocs.documents.length ~/ 2);
      final toBeDeleted =
          allDocs.documents.sublist(0, allDocs.documents.length ~/ 2);
      await Future.forEach(toBeDeleted, (DocumentSnapshot snapshot) async {
        await transaction.delete(snapshot.reference);
      });

      await Future.forEach(toBeRetrieved, (DocumentSnapshot snapshot) async {
        await transaction.update(snapshot.reference, {
          "message": "Updated from Transaction",
          "created_at": FieldValue.serverTimestamp()
        });
      });
    });

    await Future.forEach(List.generate(2, (index) => index), (item) async {
      await firestore.runTransaction((Transaction transaction) async {
        await Future.forEach(List.generate(10, (index) => index), (item) async {
          await transaction.set(firestore.collection("messages").document(), {
            "message": "Created from Transaction $item",
            "created_at": FieldValue.serverTimestamp()
          });
        });
      });
    });
  }

  Future<void> _runBatchWrite() async {
    final batchWrite = firestore.batch();
    final querySnapshot = await firestore
        .collection("messages")
        .orderBy("created_at")
        .limit(12)
        .getDocuments();
    querySnapshot.documents
        .sublist(0, querySnapshot.documents.length - 3)
        .forEach((DocumentSnapshot doc) {
      batchWrite.updateData(doc.reference, {
        "message": "Batched message",
        "created_at": FieldValue.serverTimestamp()
      });
    });
    batchWrite.setData(firestore.collection("messages").document(), {
      "message": "Batched message created",
      "created_at": FieldValue.serverTimestamp()
    });
    batchWrite.delete(
        querySnapshot.documents[querySnapshot.documents.length - 2].reference);
    batchWrite.delete(querySnapshot.documents.last.reference);
    await batchWrite.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Example'),
        actions: <Widget>[
          FlatButton(
            onPressed: _runTransaction,
            child: Text("Run Transaction"),
          ),
          FlatButton(
            onPressed: _runBatchWrite,
            child: Text("Batch Write"),
          )
        ],
      ),
      body: MessageList(firestore: firestore),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMessage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
} */

import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'model.dart';
import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form Demo'),
        ),
        body: TestForm(),
      ),
    );
  }
}

class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    hintText: 'First Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.firstName = value;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    hintText: 'Last Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.lastName = value;
                    },
                  ),
                )
              ],
            ),
          ),
          MyTextFormField(
            hintText: 'Email',
            isEmail: true,
            validator: (String value) {
              if (!validator.isEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onSaved: (String value) {
              model.email = value;
            },
          ),
          MyTextFormField(
            hintText: 'Password',
            isPassword: true,
            validator: (String value) {
              if (value.length < 7) {
                return 'Password should be minimum 7 characters';
              }
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) {
              model.password = value;
            },
          ),
          MyTextFormField(
            hintText: 'Confirm Password',
            isPassword: true,
            validator: (String value) {
              if (value.length < 7) {
                return 'Password should be minimum 7 characters';
              } else if (model.password != null && value != model.password) {
                print(value);
                print(model.password);
                return 'Password not matched';
              }
              return null;
            },
          ),
          RaisedButton(
            color: Colors.blueAccent,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Result(model: this.model)));
              }
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
