import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:volo_consumer/services/navigation_service.dart';

class IntroScreen extends StatelessWidget {
  static const routeName = 'intro';
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Title of first page",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Click on "),
                Icon(Icons.edit),
                Text(" to edit a post"),
              ],
            ),
            image: const Center(child: Icon(Icons.android)),
          ),
          PageViewModel(
            title: "Title of second page",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Click on "),
                Icon(Icons.edit),
                Text(" to edit a post"),
              ],
            ),
            image: const Center(child: Icon(Icons.android)),
          ),
          PageViewModel(
            title: "Title of third page",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Click on "),
                Icon(Icons.edit),
                Text(" to edit a post"),
              ],
            ),
            image: const Center(child: Icon(Icons.android)),
          ),
        ],
        onDone: () {
          GetIt.instance
              .get<NavigationService>()
              .pushreplacementNamed(routeName: "/login");
        },
        showDoneButton: true,
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        showNextButton: true,
        next: const Text("Next"),
        showSkipButton: true,
        skip: const Text("Skip"),
      ),
    );
  }
}
