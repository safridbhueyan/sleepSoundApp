import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sleep_sound/models/database.dart';

class MixPage extends StatefulWidget {
  const MixPage({super.key});

  @override
  State<MixPage> createState() => _MixPageState();
}

class _MixPageState extends State<MixPage> {
  final List<Map<String, dynamic>> availableSounds = [
    {'title': 'Rain', 'audio': 'rain.mp3'},
    {'title': 'Wind', 'audio': 'windtype.mp3'},
    {'title': 'Thunder', 'audio': 'thunder.mp3'},
    {'title': 'Forest', 'audio': 'forest.mp3'},
    {'title': 'sea', 'audio': 'sea.mp3'},
    {'title': 'storm', 'audio': 'storm.mp3'},
    {'title': 'chill', 'audio': 'wm.mp3'},
  ];

  final List<Map<String, dynamic>> activeSounds = [];

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Add sound to the custom mix
  void _addToMix(Map<String, dynamic> sound) {
    setState(() {
      activeSounds.add(
          {'title': sound['title'], 'audio': sound['audio'], 'volume': 0.5});
    });
  }

  // Remove sound from the custom mix
  void _removeFromMix(int index) {
    setState(() {
      activeSounds.removeAt(index);
    });
  }

  // Play the entire mix of sounds
  Future<void> _playMix() async {
    for (var sound in activeSounds) {
      await _audioPlayer.play(AssetSource(sound['audio']));
    }
    setState(() {
      _isPlaying = true;
    });
  }

  // Stop all sounds in the mix
  Future<void> _stopMix() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  // Save the mix to the database
  Future<void> _saveMix() async {
    List<String> soundTitles =
        activeSounds.map((sound) => sound['title'] as String).toList();
    List<String> soundVolumes =
        activeSounds.map((sound) => sound['volume'].toString()).toList();

    Map<String, dynamic> mix = {
      'name': 'Custom Mix',
      'sounds': soundTitles.join(','),
      'volumes': soundVolumes.join(','),
    };

    await DatabaseHelper.instance.insertMix(mix);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Mix saved!')));
  }

  Future<void> _loadMixes() async {
    List<Map<String, dynamic>> mixes =
        await DatabaseHelper.instance.getAllMixes();
    print('Loaded mixes: $mixes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 39, 10, 44),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Your Mix',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Available Sounds',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: availableSounds.length,
              itemBuilder: (context, index) {
                var sound = availableSounds[index];
                return ListTile(
                  title: Text(
                    sound['title'],
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: const Color.fromARGB(255, 123, 33, 179),
                    ),
                    onPressed: () {
                      _addToMix(sound);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your Custom Mix',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: activeSounds.length,
              itemBuilder: (context, index) {
                var sound = activeSounds[index];
                return ListTile(
                  title: Text(
                    sound['title'],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: sound['volume'],
                          min: 0,
                          max: 1,
                          onChanged: (value) {
                            setState(() {
                              sound['volume'] = value;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle,
                            color: Color.fromARGB(255, 100, 67, 150)),
                        onPressed: () {
                          _removeFromMix(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _playMix,
                  child: Text(_isPlaying ? 'Pause Mix' : 'Play Mix'),
                ),
                ElevatedButton(
                  onPressed: _stopMix,
                  child: const Text('Stop Mix'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _saveMix,
              child: const Text('Save Your Mix'),
            ),
          ),
        ],
      ),
    );
  }
}
