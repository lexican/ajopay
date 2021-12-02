import 'package:ajopay/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void onTap(int pageIndex) {
    setState(() {
      _selectedIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTap,
        selectedLabelStyle: const TextStyle(fontSize: 12, color: primaryColor),
        unselectedLabelStyle: const TextStyle(fontSize: 12, color:  Color(0xFFC6C6C6)),
        selectedItemColor: primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/home.svg",
                color: _selectedIndex == 0 ? primaryColor : const Color(0xFFC6C6C6)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/transactions.svg", color: _selectedIndex == 1 ? primaryColor : const Color(0xFFC6C6C6)),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/profile.svg", color: _selectedIndex == 2 ? primaryColor : const Color(0xFFC6C6C6)),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
