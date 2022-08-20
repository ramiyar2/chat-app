import 'package:chat_app/data/color.dart';
import 'package:flutter/material.dart';
import 'package:music_visualizer/music_visualizer.dart';

class SoundBar extends StatelessWidget {
  const SoundBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [green, dark_green, green_op, dark_blue_op];

    final List<int> duration = [900, 700, 600, 800, 500];
    return MusicVisualizer(
      barCount: 30,
      colors: colors,
      duration: duration,
    );
  }
}
