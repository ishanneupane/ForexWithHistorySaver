import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay of 3 seconds (3000 milliseconds)
    Future.delayed(const Duration(seconds: 3), () {
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
              const SizedBox(
                height: 20,
              ),
              const Text(
                'ELITE FOREX',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Money Conversion Made Simpler',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 70,
              ),
              const Row(
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
                    ' Ishaan ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Neupane',
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
