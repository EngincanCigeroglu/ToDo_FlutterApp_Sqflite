import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp_flutter_sqlite/pages/mytasks_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirectPage();
  }

  void _redirectPage() async {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyTasksPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF004e92), Color(0xFF000428)],
          begin: Alignment.bottomCenter,
          end:Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                child: Column(
                  children: [
                    Text("What To-Do ?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 40)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Icon(Icons.calendar_today_rounded,size: 100,color: Colors.white,)
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text("© Copyright 2023\nAll Rights Reserved", style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
