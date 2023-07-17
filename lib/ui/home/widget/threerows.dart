import 'package:flutter/material.dart';
import 'package:weather_app/ui/weekday_page/weekday_page.dart';

class weekrowsthree extends StatelessWidget {
  const weekrowsthree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Today',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Tomorrow',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeekDayPage(),
                ),);
          },
          child: const Row(
            children: [
              Text(
                'Next 7 days',
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              )
            ],
          ),
        ),
      ],
    );
  }
}
