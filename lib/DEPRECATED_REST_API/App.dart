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
                          final userWithUserNameExists = users.any((u) =>
                              u['username'] == _usernameController.text);
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
    return Container(
      color: Colors.white,
    );
  }
}
