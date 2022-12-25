import 'package:flutter/material.dart';

class Controls extends StatelessWidget {
  final Function() rightHandler;
  final Function() leftHandler;
  final Function() downHandler;
  final Function() upHandler;

  const Controls({
    required this.rightHandler,
    required this.leftHandler,
    required this.downHandler,
    required this.upHandler,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: IconButton(
            onPressed: leftHandler,
            icon: const Icon(
              Icons.arrow_circle_left_rounded,
              color: Colors.pink,
              size: 40,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          fit: FlexFit.tight,
          child: IconButton(
            onPressed: upHandler,
            icon: const Icon(
              Icons.arrow_circle_up,
              color: Colors.pink,
              size: 40,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          fit: FlexFit.tight,
          child: IconButton(
            onPressed: downHandler,
            icon: const Icon(
              Icons.arrow_circle_down_rounded,
              color: Colors.pink,
              size: 40,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          fit: FlexFit.tight,
          child: IconButton(
            onPressed: rightHandler,
            icon: const Icon(
              Icons.arrow_circle_right_rounded,
              color: Colors.pink,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
