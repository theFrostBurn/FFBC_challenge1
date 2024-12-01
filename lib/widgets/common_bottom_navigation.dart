import 'package:flutter/material.dart';
import 'animated_heart.dart';

class CommonBottomNavigation extends StatelessWidget {
  final VoidCallback? onLikePressed;
  final bool isLiked;

  const CommonBottomNavigation({
    super.key,
    this.onLikePressed,
    this.isLiked = false,
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
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search, size: 30),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: onLikePressed != null
              ? AnimatedHeart(
                  onTap: onLikePressed!,
                  isLiked: isLiked,
                )
              : const Icon(Icons.favorite_border, size: 30),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: '',
        ),
      ],
    );
  }
}
