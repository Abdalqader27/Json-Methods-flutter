import 'package:dto_flutter_learning_f_captain/DEPRECATED_REST_API/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
