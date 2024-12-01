import 'package:flutter/material.dart';

class AnimatedBookmark extends StatefulWidget {
  final VoidCallback onTap;
  final bool isBookmarked;

  const AnimatedBookmark({
    super.key,
    required this.onTap,
    required this.isBookmarked,
  });

  @override
  State<AnimatedBookmark> createState() => _AnimatedBookmarkState();
}

class _AnimatedBookmarkState extends State<AnimatedBookmark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.8),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: 1.2),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 30,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: widget.isBookmarked ? -10.0 : 10.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: widget.isBookmarked ? 0.2 : -0.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    widget.onTap();
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Transform.rotate(
              angle: _rotateAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Icon(
                  widget.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  size: 30,
                  color: widget.isBookmarked ? Colors.black : Colors.grey[600],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
