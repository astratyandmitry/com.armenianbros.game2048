import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final int current;
  final int step;

  const Score({
    required this.current,
    required this.step,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Card(
            elevation: 0,
            color: Colors.black.withOpacity(0.12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    current.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Current Score",
                    style: TextStyle(color: Colors.black.withOpacity(0.64)),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          fit: FlexFit.tight,
          child: Card(
            elevation: 0,
            color: Colors.black.withOpacity(0.12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    step.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.80),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Best Score",
                    style: TextStyle(color: Colors.black.withOpacity(0.64)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
