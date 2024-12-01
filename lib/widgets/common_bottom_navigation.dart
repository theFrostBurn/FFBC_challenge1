import 'package:flutter/material.dart';

class CommonBottomNavigation extends StatelessWidget {
  final VoidCallback? onLikePressed;

  const CommonBottomNavigation({
    super.key,
    this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        if (index == 3 && onLikePressed != null) {
          onLikePressed!();
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: '',
        ),
      ],
    );
  }
}
