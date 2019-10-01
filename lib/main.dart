import 'package:flutter/material.dart';
import 'package:github_following/Providers/UserProvider.dart';
import 'package:github_following/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<UserProvider>(
        builder: (context) => UserProvider(),
        child: MaterialApp(
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
