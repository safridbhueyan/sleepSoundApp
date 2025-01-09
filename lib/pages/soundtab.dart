import 'package:flutter/material.dart';

class SoundsTab extends StatelessWidget {
  final List<Map<String, dynamic>> soundList = [
    {'icon': Icons.snowing, 'title': 'Snow Winter'},
    {'icon': Icons.beach_access, 'title': 'Beach'},
    {'icon': Icons.cloud, 'title': 'Cloudy'},
    // Add more sounds here
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: soundList.length,
      itemBuilder: (context, index) {
        var sound = soundList[index];
        return GestureDetector(
          onTap: () {
            // Handle play/pause toggle here
          },
          child: Card(
            color: Colors.grey[800],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(sound['icon'], color: Colors.white),
                Text(
                  sound['title'],
                  style: const TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: () {
                    // Handle sound play/pause
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Saved Sounds will appear here.',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
