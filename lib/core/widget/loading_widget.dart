import 'package:flutter/material.dart';

class LoadingCircularProgress extends StatelessWidget {
  const LoadingCircularProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)));
  }
}
