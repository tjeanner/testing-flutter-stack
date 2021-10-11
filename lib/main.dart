import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  int _currIndex = 0;
  late final AnimationController _controller1 = AnimationController(
    duration: const Duration(milliseconds: 350),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation1 = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller1,
    curve: Curves.fastOutSlowIn,
  ));
  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(milliseconds: 350),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller2,
    curve: Curves.fastOutSlowIn,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }


  void _setIndex(int index) async {
    if (index != _currIndex) {
      Future.delayed(Duration(milliseconds: (350 / 2).round()), () {
        setState(() {
          _currIndex = index;
        });
      });
      if (index == 0) {
        _controller1.reverse();
        await _controller2.reverse();
      } else {
        _controller1.forward();
        await _controller2.forward();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing Flutter Stack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => _setIndex(index),
          currentIndex: _currIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.details), label: 'Details'),
          ],
        ),
        body: Stack(
          children: [
            SlideTransition(
              position: _offsetAnimation1,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Testing Flutter Stack'),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SlideTransition(
              position: _offsetAnimation2,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
