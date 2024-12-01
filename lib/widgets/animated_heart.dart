import 'package:flutter/material.dart';

class AnimatedHeart extends StatefulWidget {
  final VoidCallback onTap;
  final bool isLiked;

  const AnimatedHeart({
    super.key,
    required this.onTap,
    required this.isLiked,
  });

  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _moveAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _wobbleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    final upwardCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    );

    final downwardCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 2.0),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 2.0, end: 1.0),
        weight: 70,
      ),
    ]).animate(_controller);

    _wobbleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 15),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 15, end: -15),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -15, end: 10),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 10, end: -10),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -10, end: 0),
        weight: 15,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.8),
    ));

    _moveAnimation = Tween<double>(
      begin: 0,
      end: widget.isLiked ? 100 : -150,
    ).animate(widget.isLiked ? downwardCurve : upwardCurve);

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0),
    ));

    _colorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: Colors.red[400],
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4),
    ));
  }

  @override
  void didUpdateWidget(AnimatedHeart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLiked != widget.isLiked) {
      _moveAnimation = Tween<double>(
        begin: 0,
        end: widget.isLiked ? 100 : -150,
      ).animate(widget.isLiked
          ? CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
            )
          : CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
            ));
    }
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            widget.isLiked ? Icons.favorite : Icons.favorite_border,
            size: 30,
            color: widget.isLiked ? Colors.red[400] : Colors.grey[400],
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: _moveAnimation.value,
                left: widget.isLiked ? _wobbleAnimation.value : 0,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Icon(
                      widget.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _colorAnimation.value,
                      size: 30,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
