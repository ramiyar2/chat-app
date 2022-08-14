import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class AudioCallScreen extends StatefulWidget {
  String channelName;
  AudioCallScreen(this.channelName, {Key? key}) : super(key: key);

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  late int _remoteUid = 0;
  late RtcEngine _engine;
  late String _channelId;
  String appId = 'c1aebea155444d2aa1604dd2e6389b5c';

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: _renderRemoteAudio(),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.call_end_rounded)),
          ],
        ),
      ),
    );
  }

  Future<void> initAgora() async {
// get token
    final link =
        'https://agora-node-tokenserver.ramyaryusf.repl.co/access_token?channelName=${widget.channelName}';
    Response _response = await get(Uri.parse(link));
    Map data = jsonDecode(_response.body);
    String token = data['token'];

// permission request
    await [Permission.microphone, Permission.camera].request();

    //join a channel
    _engine = await RtcEngine.create(appId);
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('local user $uid joined successfully');
        },
        userJoined: (int uid, int elapsed) {
          print('remote user $uid joined successfully');
          setState(() {
            _remoteUid = uid;
            _channelId = widget.channelName;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('remote user $uid left call');
          setState(() => _remoteUid = 0);
          Navigator.of(context).pop(true);
        },
      ),
    );
    await _engine.joinChannel(token, widget.channelName, null, 0);
  }

  Widget _renderRemoteAudio() {
    if (_remoteUid != 0) {
      return Text(
        'Calling with $_remoteUid',
      );
    } else {
      return Text(
        'Calling …',
      );
    }
  }
}
