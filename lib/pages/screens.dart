import 'package:flutter/material.dart';

class Library_page extends StatelessWidget {
  const Library_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(251, 39, 10, 44),
        body: Container(
          child: Center(
              child: Text(
            "library page",
            style: TextStyle(color: const Color.fromARGB(219, 255, 255, 255)),
          )),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 22, 8, 45),
                Color.fromARGB(222, 34, 19, 59),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.bottomLeft,
            ),
          ),
        ));
  }
}

class Alarm_page extends StatelessWidget {
  const Alarm_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(251, 39, 10, 44),
        body: Container(
          child: Center(
              child: Text(
            "Alarm page",
            style: TextStyle(color: const Color.fromARGB(219, 255, 255, 255)),
          )),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 22, 8, 45),
                Color.fromARGB(222, 34, 19, 59),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.bottomLeft,
            ),
          ),
        ));
  }
}

class Award_page extends StatelessWidget {
  const Award_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(251, 39, 10, 44),
        body: Container(
          child: Center(
              child: Text(
            "Award page",
            style: TextStyle(color: const Color.fromARGB(219, 255, 255, 255)),
          )),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 22, 8, 45),
                Color.fromARGB(222, 34, 19, 59),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.bottomLeft,
            ),
          ),
        ));
  }
}
