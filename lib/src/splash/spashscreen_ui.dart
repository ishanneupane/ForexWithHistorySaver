import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay of 3 seconds (3000 milliseconds)
    Future.delayed(Duration(seconds: 3), () {
      Provider.of<SplashState>(context, listen: false).getContext = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashState>(builder: (context, state, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        // You can customize the splash screen UI here
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/ic_launcher.png'),
              SizedBox(
                height: 20,
              ),
              Text(
                'ELITE FOREX',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Money Conversion Made Simpler',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BY ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' Elite ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'InfoTech',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Image.asset('assets/images/ktm.png'),
      );
    });
  }
}
