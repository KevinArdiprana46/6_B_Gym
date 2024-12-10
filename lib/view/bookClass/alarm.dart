import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  late DateTime alert;
  final player = AudioPlayer();
  bool alarmSounding = false;

  void initState() {
    alarmSounding = false;

    alert = DateTime.now().add(Duration(seconds: 15));
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var reached = now.compareTo(alert) == 0;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromARGB(255, 0, 68, 170),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  reached ? Icons.alarm_on : Icons.alarm,
                  color: reached
                      ? Colors.red
                      : const Color.fromARGB(255, 255, 255, 255),
                  size: 98,
                ),
                SizedBox(
                  height: 15,
                ),
                !reached
                    ? TimerBuilder.periodic(Duration(seconds: 1),
                        alignment: Duration.zero, builder: (context) {
                        var now = DateTime.now();
                        var remaining = alert.difference(now);

                        if (remaining.inSeconds == 0 && !alarmSounding) {
                          // Alarm waktu habis, mulai pemutaran audio
                          player.play(AssetSource('audio/audio_alarm.mp3'));
                        }

                        return Text(
                          formatDuration(remaining),
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        );
                      })
                    : Text(""),
                SizedBox(
                  height: 20,
                ),
                SafeArea(
                  child: ElevatedButton(
                    child: Text("Okey",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      setState(() {
                        alert = DateTime.now().add(Duration(seconds: 15));
                        final AudioPlayer audioPlayer = AudioPlayer();
                        player.stop();
                      });

                      // Memeriksa apakah timer telah habis
                      if (reached) {
                        // Memainkan suara bel saat timer habis
                        // Ganti 'assets/bell.mp3' dengan lokasi file suara bel yang sesuai
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    if (d.inSeconds == 0 && alarmSounding) {
      // Alarm waktu habis, hentikan pemutaran audio dan atur kembali alarmSounding ke false
      player.stop();
      alarmSounding = false;
    }
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }
}
