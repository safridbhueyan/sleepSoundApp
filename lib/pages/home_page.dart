import 'package:flutter/material.dart';
import 'package:sleep_sound/components/homeDecor.dart';
import 'package:sleep_sound/pages/mix_page.dart';
import 'package:sleep_sound/pages/screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final screens = [
    Homedecor(),
    Library_page(),
    MixPage(),
    Alarm_page(),
    Award_page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 39, 10, 44),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 22, 8, 45),
            const Color.fromARGB(222, 34, 19, 59)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.bottomLeft,
        )),
        child: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 27, 9, 57),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(159, 89, 57, 144),
        unselectedItemColor: Colors.grey.shade600,
        iconSize: 30,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_outlined),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rounded),
            label: 'Awards',
          ),
        ],
      ),
    );
  }
}
