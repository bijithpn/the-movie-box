import 'package:flutter/material.dart';

class CircularRating extends StatelessWidget {
  final double rating;

  const CircularRating({super.key, required this.rating});

  Color getRatingColor(double rating) {
    if (rating >= 9) {
      return Colors.green[900]!;
    } else if (rating >= 7) {
      return Colors.green[400]!;
    } else if (rating >= 5) {
      return Colors.yellow[700]!;
    } else if (rating >= 3) {
      return Colors.orange[700]!;
    } else {
      return Colors.red[600]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: CircularProgressIndicator(
            value: rating / 10, // Rating max is 10
            strokeWidth: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(getRatingColor(rating)),
          ),
        ),
        Text(rating.toStringAsFixed(1), // Show 1 decimal place
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
