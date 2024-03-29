import 'dart:io';
import 'dart:math';
import 'package:chat_app/server/uplaod_attachment.dart';
import 'package:chat_app/widget/chat/attachment.dart';
import 'package:chat_app/widget/chat/sound_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/color.dart';
import '../../server/send_massages.dart';

class NewMsg extends StatefulWidget {
  var chats;
  var chatDocId;
  var currentUser;
  var friendName;
  NewMsg(this.chats, this.chatDocId, this.currentUser, this.friendName,
      {Key? key})
      : super(key: key);

  @override
  State<NewMsg> createState() => _NewMsgState();
}

class _NewMsgState extends State<NewMsg> {
  TextEditingController massController = TextEditingController();
  bool isNotAudioIcon = false;
  Icon icon = const Icon(Icons.attach_file_rounded);
  late String _fileName;
  //late FlutterSoundRecorder _myRecorder;
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  @override
  void initState() {
    super.initState();
    initRecordrt();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecordrt() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    await recorder.setSubscriptionDuration(Duration(milliseconds: 10));
  }

  randomNumber() {
    var random = new Random();

    int min = 10;

    int max = 1000;

    int result = min + random.nextInt(max - min);
    return result.toString();
  }

  Future record() async {
    // Request Microphone permission if needed
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted)
      throw RecordingPermissionException("Microphone permission not granted");
    _fileName = widget.chatDocId.toString() + randomNumber();
    await recorder.startRecorder(
      toFile: '$_fileName.mp4',
    );
    setState(() {
      icon = const Icon(Icons.stop);
    });
  }

  Future stop() async {
    final path = await recorder.stopRecorder();
    UploadFile(File(path.toString()), "Audio", _fileName, widget.chats,
        widget.chatDocId, widget.currentUser, widget.friendName);
    setState(() {
      icon = const Icon(Icons.mic);
    });
  }

  Future delete() async {
    await recorder.deleteRecord(fileName: widget.chatDocId.toString());
    stop();
  }

  Future pause() async {
    if (recorder.isPaused) {
      await recorder.startRecorder();
    } else {
      await recorder.pauseRecorder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
          color: dark_blue_op, borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: recorder.isRecording ? RecordBar : NormalBar(context),
      ),
    );
  }

  List<Widget> NormalBar(BuildContext context) {
    return [
      IconButton(onPressed: () {}, icon: const Icon(Icons.emoji_emotions)),
      Expanded(
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            label: Text('send a message ...'),
          ),
          controller: massController,
          onSubmitted: (val) => sendMsg(val, widget.chats, widget.chatDocId,
              widget.currentUser, widget.friendName),
        ),
      ),
      InkWell(
        onTap: () {
          if (!isNotAudioIcon) {
            AddAttachment(context, widget.chats, widget.chatDocId,
                widget.currentUser, widget.friendName);
          } else if (isNotAudioIcon) {
            if (recorder.isRecording) {
              stop();
            } else {
              record();
            }
          }
        },
        onLongPress: () => getIcon(),
        child: Ink(
          child: icon,
        ),
      ),
      IconButton(
          onPressed: () => sendMsg(massController.text, widget.chats,
              widget.chatDocId, widget.currentUser, widget.friendName),
          icon: const Icon(Icons.send)),
    ];
  }

  List<Widget> get RecordBar {
    return [
      StreamBuilder(
        stream: recorder.onProgress,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final duration =
              snapshot.hasData ? snapshot.data!.duration : Duration.zero;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("${duration.inMinutes} : ${duration.inSeconds}"),
          );
        },
      ),
      Expanded(
        child: SoundBar(),
      ),
      IconButton(
          onPressed: () => delete(), icon: const Icon(Icons.delete_rounded)),
      IconButton(
          onPressed: () => pause(),
          icon: recorder.isPaused
              ? const Icon(Icons.play_arrow_rounded)
              : const Icon(Icons.pause_rounded)),
      IconButton(onPressed: () => stop(), icon: const Icon(Icons.send_rounded)),
    ];
  }

  void getIcon() {
    if (!isNotAudioIcon) {
      setState(() {
        icon = Icon(Icons.attach_file_rounded);
      });
    } else {
      setState(() {
        icon = Icon(Icons.mic);
      });
    }
    setState(() {
      isNotAudioIcon = !isNotAudioIcon;
    });
  }

  void sendMsg(String msg, chats, chatDocId, currentUser, friendName) {
    if (msg == '' || msg == null) {
      return;
    } else {
      massController.clear();
      sendMassage('mas', chats, chatDocId, currentUser, friendName, msg);
    }
  }
}
