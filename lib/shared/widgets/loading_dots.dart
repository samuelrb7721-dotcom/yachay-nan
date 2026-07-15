import 'dart:async';

import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  const LoadingDots({
    super.key,
    this.color = const Color(0xFF2FAAA7),
    this.dotSize = 18,
  });

  final Color color;
  final double dotSize;

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots> {
  int activeDot = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (!mounted) return;

      setState(() {
        activeDot = (activeDot + 1) % 3;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.dotSize + 18,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          final isActive = index == activeDot;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 11),
            transform: Matrix4.translationValues(0, isActive ? -14 : 0, 0)
              ..scaleByDouble(
                isActive ? 1.2 : 1.0,
                isActive ? 1.2 : 1.0,
                1.0,
                1.0,
              ),
            width: widget.dotSize,
            height: widget.dotSize,
            decoration: BoxDecoration(
              color: widget.color.withValues(alpha: isActive ? 1 : 0.7),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
