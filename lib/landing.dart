import 'package:flutter/material.dart';
import 'package:silapor/report.dart';
import './akun.dart';
import './beranda.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [new Beranda(), new Report(), new Akun()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _container[_bottomNavCurrentIndex],
        bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _bottomNavCurrentIndex = index;
            });
          },
          currentIndex: _bottomNavCurrentIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.home,
                color: Colors.green,
              ),
              icon: new Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: new Text('Beranda',
                  style: TextStyle(
                      color: _bottomNavCurrentIndex == 0
                          ? Colors.green
                          : Colors.grey)),
            ),
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.assignment,
                color: Colors.green,
              ),
              icon: new Icon(
                Icons.assignment,
                color: Colors.grey,
              ),
              title: new Text('Report',
                  style: TextStyle(
                      color: _bottomNavCurrentIndex == 1
                          ? Colors.green
                          : Colors.grey)),
            ),
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.people,
                color: Colors.green,
              ),
              icon: new Icon(
                Icons.people,
                color: Colors.grey,
              ),
              title: new Text('Akun',
                  style: TextStyle(
                      color: _bottomNavCurrentIndex == 2
                          ? Colors.green
                          : Colors.grey)),
            ),
          ],
        ));
  }
}