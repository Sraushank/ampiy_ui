import 'package:ampiy_ui/utils/app_color/colors.dart';
import 'package:ampiy_ui/views/widget/view_coins.dart';
import 'package:flutter/material.dart';

import '../homeScreen.dart';

class AppBarUi extends StatefulWidget {
  AppBarUi({
    super.key,
  });

  @override
  State<AppBarUi> createState() => _AppBarUiState();
}

class _AppBarUiState extends State<AppBarUi> {
  late int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: HomeScreen()),
    const Center(child: ViewAllCoins()),
    const Center(child: Text('swipe')),
    const Center(child: Text('Wallet')),
    const Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        backgroundColor: AppColor().brightBlue,
        child: const Icon(
          Icons.swap_vert,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != 2) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swipe_left_alt_outlined),
            label: 'Coins',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'You',
          ),
        ],
        selectedItemColor: AppColor().brightBlue,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black,
      ),
    );
  }
}
