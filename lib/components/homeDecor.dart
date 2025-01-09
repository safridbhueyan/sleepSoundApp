import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sleep_sound/components/neubutton.dart';

class Homedecor extends StatefulWidget {
  const Homedecor({super.key});

  @override
  State<Homedecor> createState() => _HomedecorState();
}

class _HomedecorState extends State<Homedecor> {
  final List<bool> activeStates = List.generate(12, (index) => false);

  final List<Map<String, dynamic>> buttonData = [
    {'icon': Icons.tornado, 'label': 'Typhoon', 'audio': 'storm.mp3'},
    {'icon': Icons.cloudy_snowing, 'label': 'Sleet', 'audio': 'rain.mp3'},
    {'icon': Icons.sunny, 'label': 'Heavenly Drift', 'audio': 'windtype.mp3'},
    {'icon': Icons.star, 'label': 'Star', 'audio': 'thunder.mp3'},
    {'icon': Icons.snowing, 'label': 'Snow Winter', 'audio': 'wm.mp3'},
    {
      'icon': Icons.cloud_circle_rounded,
      'label': 'Cloudiness',
      'audio': 'thunder.mp3'
    },
    {
      'icon': Icons.wind_power_rounded,
      'label': 'Desert Wind',
      'audio': 'windtype.mp3'
    },
    {'icon': Icons.nightlife, 'label': 'Starry Nights', 'audio': 'forest.mp3'},
    {
      'icon': Icons.local_fire_department_outlined,
      'label': 'Tribal Drums',
      'audio': 'wm.mp3'
    },
    {'icon': Icons.alarm, 'label': 'Alarm', 'audio': 'rain.mp3'},
    {'icon': Icons.beach_access, 'label': 'Beach', 'audio': 'sea.mp3'},
    {'icon': Icons.coffee, 'label': 'Coffee', 'audio': 'sea.mp3'},
  ];

  // Audio player instance
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentPlayingSound; // Track which sound is currently playing
  // ignore: unused_field
  bool _isPlaying = false; // Track the play/pause state of the audio

  @override
  void dispose() {
    _audioPlayer.dispose(); // Clean up the audio player
    super.dispose();
  }

  // Function to handle audio play/pause
  Future<void> _playPauseAudio(String soundPath) async {
    if (_currentPlayingSound == soundPath) {
      // If the same sound is clicked, toggle pause
      if (_audioPlayer.state == PlayerState.playing) {
        await _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        await _audioPlayer.resume();
        setState(() {
          _isPlaying = true;
        });
      }
    } else {
      // Play a new sound
      await _audioPlayer.stop(); // Stop previous sound
      await _audioPlayer.play(AssetSource(soundPath)); // Play the new sound
      setState(() {
        _currentPlayingSound = soundPath; // Set the new sound path
        _isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 32),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with Image and Buttons
            Stack(
              children: [
                // Background Image
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/bg.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                // Blurred Background
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                // Buttons on top of the image
                Positioned(
                  top: 20,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(0, 216, 212, 212)
                                  .withOpacity(0.3),
                        ),
                        onPressed: () {
                          print("Upgrade pressed");
                        },
                        icon: const Icon(Icons.lock,
                            color: Color.fromARGB(255, 215, 209, 209)),
                        label: const Text("Upgrade",
                            style: TextStyle(
                                color: Color.fromARGB(255, 215, 209, 209))),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.8),
                        ),
                        onPressed: () {
                          print("Search pressed");
                        },
                        icon: const Icon(Icons.search,
                            color: Color.fromARGB(255, 25, 24, 24)),
                        label: const Text("Search",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Categories Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            const SizedBox(height: 10),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip("All"),
                  _buildCategoryChip("Water"),
                  _buildCategoryChip("Rain"),
                  _buildCategoryChip("Instrument"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rest of the Buttons
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: buttonData.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> button = entry.value;

                return SizedBox(
                  width: 80,
                  child: Neubutton(
                    ontap: () {
                      setState(() {
                        activeStates[index] = !activeStates[index];
                      });
                      // Call the audio play/pause function on button tap
                      _playPauseAudio(button['audio']);
                    },
                    icons: button['icon'],
                    label: button['label'],
                    isActive: activeStates[index],
                    activeBorderColor: const Color.fromARGB(255, 70, 21, 143),
                    inactiveBorderColor:
                        const Color.fromARGB(255, 124, 120, 120),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build each category chip
  Widget _buildCategoryChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor:
            const Color.fromARGB(255, 32, 17, 34), // Purple background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
      ),
    );
  }
}
