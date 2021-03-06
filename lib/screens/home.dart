import 'package:em_school/models/post.dart';
import 'package:em_school/screens/add_post.dart';
import 'package:em_school/screens/view_post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  final String title = 'EMSchool Blog';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "posts";
  List<Post> postsList = <Post>[];

  @override
  void initState() {
    super.initState();
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoved);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      backgroundColor: Colors.amber[200],
      body: SwipeDetector(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                  heightFactor: 4.0,
                ),
              ),
              Visibility(
                visible: postsList.isEmpty,
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Visibility(
                visible: postsList.isNotEmpty,
                child: Flexible(
                    child: FirebaseAnimatedList(
                        query: _database.reference().child('posts'),
                        itemBuilder: (_, DataSnapshot snap,
                            Animation<double> animation, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.blue,
                              child: ListTile(
                                title: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewPost(postsList[index])));
                                  },
                                  title: Text(
                                    postsList[index].title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    timeago.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            postsList[index].date)),
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black45),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 12.0, left: 12.0),
                                    child: Text(
                                      postsList[index].body,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
              ),
            ],
          ),
        ),
        onSwipeRight: () {
          _selectedIndex >= 2
              ? setState(() {
                  _selectedIndex = 0;
                })
              : setState(() {
                  _selectedIndex++;
                });
        },
        onSwipeLeft: () {
          _selectedIndex <= 0
              ? setState(() {
                  _selectedIndex = 2;
                })
              : setState(() {
                  _selectedIndex--;
                });
        },
        onSwipeDown: () {},
        onSwipeUp: () {},
        swipeConfiguration: SwipeConfiguration(
            verticalSwipeMinVelocity: 100.0,
            verticalSwipeMinDisplacement: 50.0,
            verticalSwipeMaxWidthThreshold: 100.0,
            horizontalSwipeMaxHeightThreshold: 50.0,
            horizontalSwipeMinDisplacement: 50.0,
            horizontalSwipeMinVelocity: 200.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        tooltip: "Add a Post",
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "BlogApp",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text("roneemrayhan@rayhanworld.com"),
            ),
            ListTile(
              title: Text(
                "About",
                style: TextStyle(fontSize: 10.0),
              ),
              leading: Icon(
                Icons.details,
                color: Colors.purple,
              ),
            ),
            Divider(
              height: 10.0,
              color: Colors.black,
            ),
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _childAdded(Event event) {
    setState(() {
      postsList.add(Post.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoved(Event event) {
    var deletedPost = postsList.singleWhere((post) {
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList.removeAt(postsList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = postsList.singleWhere((post) {
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList[postsList.indexOf(changedPost)] =
          Post.fromSnapshot(event.snapshot);
    });
  }
}
