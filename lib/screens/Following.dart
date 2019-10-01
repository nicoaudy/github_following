import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_following/Models/User.dart';
import 'package:github_following/Providers/UserProvider.dart';
import 'package:github_following/Requests/GithubRequest.dart';
import 'package:provider/provider.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  User user;
  List<User> users;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    setState(() {
      user = userProvider.getUser();

      Github(user.login).fetchFollowing().then((following) {
        Iterable list = jsonDecode(following.body);
        setState(() {
          users = list.map((model) => User.fromJson(model)).toList();
        });
      });
    });

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              leading: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
              backgroundColor: Colors.white,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(user.avatar_url),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.login,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 600,
                    child: Container(
                        child: Align(child: Text('Data is loading...'))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
