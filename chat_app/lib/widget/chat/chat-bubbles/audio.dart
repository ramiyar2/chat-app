import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../data/color.dart';

class AudioMsg extends StatefulWidget {
  var data;
  AudioMsg({required this.data, Key? key}) : super(key: key);

  @override
  State<AudioMsg> createState() => _AudioMsgState();
}

class _AudioMsgState extends State<AudioMsg> {
  final audioPlayer = AudioPlayer();
  bool isPlayed = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    //listen to audio state
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlayed = (state = PlayerState.playing) as bool;
      });
    });

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = Duration.zero;
      });
    });

    //listen to audio duration
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    //listen to audio position
    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () async {
                if (isPlayed) {
                  await audioPlayer.pause();
                  setState(() {
                    isPlayed = !isPlayed;
                  });
                } else {
                  await audioPlayer.play(UrlSource(widget.data['msg']));
                  setState(() {
                    isPlayed = !isPlayed;
                  });
                }
              },
              icon: Icon(
                isPlayed ? Icons.pause_rounded : Icons.play_arrow_rounded,
              ),
              iconSize: 30,
            ),
            Expanded(
                child: Slider(
              onChanged: (double value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
                setState(() {
                  isPlayed = true;
                });
              },
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.toDouble(),
            )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatDate(_duration - _position),
              style: TextStyle(color: white_op, fontSize: 10),
            ),
            Text(
              '10:10 PM',
              style: TextStyle(color: white_op, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  String formatDate(Duration duration) {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final hour = twoDigit(duration.inHours);
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final secound = twoDigit(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hour,
      minutes,
      secound,
    ].join(':');
  }
}
