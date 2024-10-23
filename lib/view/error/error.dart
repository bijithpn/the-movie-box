import 'package:flutter/material.dart';
import 'package:the_movie_box/core/constants/image.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  const ErrorScreen({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
            )),
        title: Text(
          "Error Screen",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: .6),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.error,
                width: MediaQuery.of(context).size.width / 1.5),
            const SizedBox(height: 15),
            Text(
              "Oops, look like you lost",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(errorMessage, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
