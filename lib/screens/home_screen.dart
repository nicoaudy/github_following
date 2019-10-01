import 'package:flutter/material.dart';
import 'package:github_following/Providers/UserProvider.dart';
import 'package:github_following/screens/Following.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    void _getUser() {
      if (_controller.text == '') {
        userProvider.setMessage('Please enter your name');
      } else {
        userProvider.fetchUser(_controller.text).then((value) {
          if (value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FollowingScreen()));
          }
        });
      }
    }

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      'https://icon-library.net/images/github-icon-png/github-icon-png-29.jpg'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Github",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(.1),
                ),
                child: TextField(
                  onChanged: (value) {
                    userProvider.setMessage(null);
                  },
                  controller: _controller,
                  enabled: !userProvider.isLoading(),
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    errorText: userProvider.getMessage(),
                    border: InputBorder.none,
                    hintText: "Github Username",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                padding: EdgeInsets.all(20),
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  child: userProvider.isLoading()
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text(
                          "Get's Your Following Now",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                onPressed: () {
                  _getUser();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
