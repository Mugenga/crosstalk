// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:crosstalk/api/sound_player.dart';
import 'package:crosstalk/api/sound_recorder.dart';
import 'package:crosstalk/helpers/constants.dart';
import 'package:crosstalk/provider/words.dart';
import 'package:crosstalk/screens/score.dart';
import 'package:crosstalk/widgets/icon_avatar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class PronounceScreen extends StatefulWidget {
  static const routeName = '/pronounce';

  const PronounceScreen({Key? key}) : super(key: key);

  @override
  _PronounceScreenState createState() => _PronounceScreenState();
}

class _PronounceScreenState extends State<PronounceScreen> {
  final recorder = SoundRecorder();
  final player = SoundPlayer();
  // final audioPlayer = AssetsAudioPlayer();
  String filePath = '';
  bool _play = false;
  bool _isRecording = false;
  bool _hasRecorded = false;
  String recorderTxt = '00:00:00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recorder.init();
    player.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    recorder.dispose();
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    var word = Provider.of<Words>(context, listen: false).word;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('PRONOUNCE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: screenHeight / 7,
              decoration: BoxDecoration(
                color: const Color(0xffF391A0).withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: ListTile(
                  title: Text(
                    word['text_en'],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: const Text('Word(s) in English'),
                ),
              ),
            ),
            SizedBox(height: screenHeight / 30),
            Container(
              width: double.infinity,
              height: screenHeight / 7,
              decoration: BoxDecoration(
                color: const Color(0xffF391A0).withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: ListTile(
                  title: Text(
                    word['text_kin'],
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: const Text('Word(s) to spell, in Kinyarwanda'),
                  trailing: GestureDetector(
                    onTap: () async {
                      await player.playUrl(word['audio_url']);
                      // await player.togglePlaying(
                      //     whenFinished: () => setState(() {}));
                    },
                    child: IconAvatar(
                      height: 50,
                      width: 50,
                      iconSize: 40,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight / 30),
            Container(
              width: double.infinity,
              height: screenHeight / 2.3,
              decoration: BoxDecoration(
                color: powderBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: !_isRecording
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          _hasRecorded
                              ? Text(recorderTxt)
                              : const SizedBox(height: 1),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                _isRecording = true;
                                _hasRecorded = true;
                              });
                              await recorder.record();
                            },
                            child: IconAvatar(
                              height: screenHeight / 4.6,
                              width: screenHeight / 4.6,
                              icon: Icons.mic_none,
                              color: Colors.white,
                              iconSize: screenHeight / 7.8,
                            ),
                          ),
                          const Text("Tap to record"),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          _hasRecorded
                              ? Text(recorderTxt)
                              : const SizedBox(height: 1),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                _isRecording = false;
                              });
                              await recorder.stop();
                              Navigator.of(context).pushNamed(
                                ScoreScreen.routeName,
                                arguments: {
                                  'score': '65',
                                },
                              );
                            },
                            child: IconAvatar(
                              height: screenHeight / 4.6,
                              width: screenHeight / 4.6,
                              icon: Icons.stop,
                              color: const Color(0xffF391A0),
                              iconSize: screenHeight / 7.8,
                            ),
                          ),
                          const Text("Tap to stop Recording"),
                        ],
                      ),
                // child: ListTile(
                //   title: Text("Long press to record"),
                //   trailing: IconAvatar(
                //     height: 50,
                //     width: 50,
                //     icon: Icons.mic,
                //     iconSize: 40,
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> record() async {
  //   print('yeah lets start recording!');
  //   Directory dir = Directory(path.dirname(filePath));
  //   if (!dir.existsSync()) {
  //     dir.createSync();
  //   }
  //   _myRecorder.openAudioSession();
  //   await _myRecorder.startRecorder(
  //     toFile: filePath,
  //     codec: Codec.pcm16WAV,
  //   );

  //   setState(() {
  //     _isRecording = true;
  //     _hasRecorded = true;
  //   });

  //   StreamSubscription _recorderSubscription =
  //       _myRecorder.onProgress!.listen((e) {
  //     var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
  //         isUtc: true);
  //     var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

  //     setState(() {
  //       recorderTxt = txt.substring(0, 8);
  //       print('recorderText $recorderTxt');
  //     });
  //   });
  //   _recorderSubscription.cancel();
  // }

  // Future<String?> stopRecord() async {
  //   setState(() {
  //     _isRecording = false;
  //   });
  //   _myRecorder.closeAudioSession();
  //   return await _myRecorder.stopRecorder();
  // }

  // Future<void> startPlaying() async {
  //   // audioPlayer.open(
  //   //   Audio.file(filePath),
  //   //   autoStart: true,
  //   //   showNotification: true,
  //   // );
  // }

  // Future<void> stopPlaying() async {
  //   // audioPlayer.stop();
  // }
}
