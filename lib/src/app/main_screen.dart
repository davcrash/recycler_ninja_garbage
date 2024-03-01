import 'package:flutter/material.dart';
import 'package:garbage_game/src/app/widgets/bloc_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hello ? !@#",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.green,
                shadows: [
                  const Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("BUTTON"),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(),
              child: const Text('Beveled Rectangle'),
            ),
            BlockButton(
              onPressed: () {},
              label: "asd",
            ),
          ],
        ),
      ),
    );
  }
}
