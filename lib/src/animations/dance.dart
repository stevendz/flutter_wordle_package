import 'package:flutter/material.dart';

class Dance extends StatefulWidget {
  const Dance({
    required this.child,
    required this.animate,
    required this.delay,
    super.key,
  });

  final Widget child;
  final bool animate;
  final int delay;

  @override
  State<Dance> createState() => _DanceState();
}

class _DanceState extends State<Dance> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(begin: Offset.zero, end: const Offset(0, -0.80)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0, -0.80), end: Offset.zero),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween(begin: Offset.zero, end: const Offset(0, -0.30)),
        weight: 12,
      ),
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0, -0.30), end: Offset.zero),
        weight: 8,
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Dance oldWidget) {
    if (widget.animate) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}