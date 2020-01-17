import 'package:dto_flutter_learning_f_captain/DEPRECATED_REST_API/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  bool isLoading = false;
  TextEditingController _usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: 'UserName'),
            ),
            isLoading
                ? Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: RaisedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final users = await ApiService.getUserList();
                        setState(() {
                          isLoading = false;
                        });
                        if (users == null) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Erorr'),
                                  content:
                                      Text('Check Your Internet Conncection'),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          final userWithUserNameExists = users.any(
                              (u) => u['username'] == _usernameController.text);
                          if (userWithUserNameExists) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => posts()));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Erorr'),
                                    content:
                                        Text('Check Your Internet Conncection'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Text('Login'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class posts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPost(),
              ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          title: Text(
        'Posts',
      )),
      body: FutureBuilder(
        future: ApiService.getPostList(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.done) {
            final posts = snapshots.data;
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 2,
                  color: Colors.black,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    posts[index]['title'],
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(posts[index]['body']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              posts_details(posts[index]['id']),
                        ));
                  },
                );
              },
              // ignore: missing_return
              itemCount: posts.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class posts_details extends StatelessWidget {
  final int _id;

  posts_details(this._id);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          FutureBuilder(
            future: ApiService.getPost(_id),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.done) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshots.data['title'] as String,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshots.data['body'] as String,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 20),
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          FutureBuilder(
            future: ApiService.getCommentForPosts(_id),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.done) {
                final comments = snapshots.data;
                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 2,
                      color: Colors.black,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        comments[index]['name'],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(comments[index]['body']),
                    );
                  },
                  // ignore: missing_return
                  itemCount: 10,
                );
              }
              return Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NewPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewPost();
  }
}

class _NewPost extends State<NewPost> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('NewPost'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(hintText: 'Body'),
            ),
            isloading
                ? Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (_bodyController.text.isEmpty ||
                            _titleController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "is Empty EditText",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          int i = 0;
                          final post = {
                            'title': _titleController.text,
                            'body': _bodyController.text,
                          };

                          ApiService.addPost(post).then((success) {
                            setState(() {
                              isloading = true;
                            });
                            String title, text;
                            if (success) {
                              setState(() {
                                isloading = false;
                              });
                              title = "Success";
                              text = "Your Post has Been success";
                            } else {
                              title = "Error";
                              text = "some thing is wrong";
                            }
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('${title}'),
                                    content: Text('${text}'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                });
                          });
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
