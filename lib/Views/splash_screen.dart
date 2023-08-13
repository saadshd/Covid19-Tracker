import 'dart:async';
import 'package:covid19_tracker/Views/world_stats_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 5),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorldStatsScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 1,
                height: MediaQuery.sizeOf(context).height * .3,
                child: const Center(
                  child: Image(
                    fit: BoxFit.cover,
                      image: AssetImage('images/virus.png'),
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                child: child,
                );
              },
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * .08,),
            Align(
              alignment: Alignment.center,
                child: Text('Covid 19\nTracker',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
