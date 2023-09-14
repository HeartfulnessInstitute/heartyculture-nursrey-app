import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../modules/plant_module.dart';

class NotificationController {
  static ReceivedAction? initialAction;
  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple)
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {

    if(
    receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction
    ){

    }
    else {

    }
  }

  static Future<bool> displayNotificationRationale() async {
    return await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> stopNotifications(Plants plants) async {
   await AwesomeNotifications().cancel(plants.id!);
   await AwesomeNotifications().cancelSchedule(plants.id!);
  }

  static Future<void> createNewNotification(Plants plants) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;
    String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    final List<int> imageBytes = base64Decode(plants.image256);
    final Directory tempDir = await getTemporaryDirectory();
    final File tempFile = File('${tempDir.path}/temp_image.png');
    await tempFile.writeAsBytes(imageBytes);

    //Send notification at that time
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: plants.id!, // -1 is replaced by a random number
          channelKey: 'alerts',
          title: '${plants.name} need water!',
          body:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
          bigPicture: 'file://${tempFile.path}',
          //bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
          largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
          //'asset://assets/images/balloons-in-sky.jpg',
          notificationLayout: NotificationLayout.BigPicture,
          payload: {'notificationId': '1234567890'}));

    //Schedule notification periodically
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: plants.id!, // -1 is replaced by a random number
            channelKey: 'alerts',
            title: 'Time to water your plant - ${plants.name}',
            body:
            "A small step for a man, but a giant leap to Flutter's community!",
            bigPicture: 'file://${tempFile.path}',
            //bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
            largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '1234567890'}),
        schedule: NotificationInterval(interval: 60*60, preciseAlarm: true,timeZone: localTimeZone, repeats: true,allowWhileIdle: true),
        /*actionButtons: [
          NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
          NotificationActionButton(
              key: 'REPLY',
              label: 'Reply Message',
              requireInputText: true,
              actionType: ActionType.SilentAction
          ),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ]*/);
  }
}