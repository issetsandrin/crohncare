import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/notification_settings.dart';
import 'package:flutter/material.dart';
import 'package:minha_doenca_crohn/models/alarme.dart';

class SetAlarmeService {
  void setAlarme(Alarme alarme) async {
    await configureAlarme(alarme)
        .then((alarmSettings) {
          defineAlarme(alarmSettings);
        })
        .catchError((error) {
          print('Error setting alarm: $error');
        });
  }

  Future<AlarmSettings> configureAlarme(Alarme alarme) async {
    final partes = alarme.hora.split(':');
    final agora = DateTime.now();
    final dateTime = DateTime(
      agora.year,
      agora.month,
      agora.day,
      int.parse(partes[0]),
      int.parse(partes[1]),
    );

    return AlarmSettings(
      id:
          alarme.id ??
          (DateTime.now().millisecondsSinceEpoch %
              2147483647), // Ensure a unique ID
      dateTime: dateTime,
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      volumeSettings: VolumeSettings.fade(
        volume: 0.8,
        fadeDuration: Duration(seconds: 5),
        volumeEnforced: true,
      ),
      notificationSettings: const NotificationSettings(
        title: 'This is the title',
        body: 'This is the body',
        stopButton: 'Stop the alarm',
        icon: 'notification_icon',
        iconColor: Color(0xff862778),
      ),
    );
  }

  Future<void> defineAlarme(AlarmSettings alarme) async {
    await Alarm.set(alarmSettings: alarme);
  }
}
