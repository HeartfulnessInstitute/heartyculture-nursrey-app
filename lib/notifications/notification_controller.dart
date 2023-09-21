import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../constants.dart';
import '../modules/notification_module.dart';
import '../modules/plant_module.dart';
import '../preference_storage/notification_preferences.dart';
import '../preference_storage/storage_notifier.dart';

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
    startListeningNotificationEvents();
  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod,
        onNotificationDisplayedMethod:onNotificationDisplayedMethod);
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
     NotificationModule notificationModule = NotificationModule();
     notificationModule.id= DateTime.now().microsecondsSinceEpoch.toString();
     notificationModule.notificationDescription = "Your Plant needs water. Kindly  water it, before it dies!";
     notificationModule.notificationType = "Water";
     notificationModule.plantName = receivedNotification.payload?["plantName"];
     NotificationPreferenceHelper.addNotificationToList(notificationModule);
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
    Dio dio = Dio();
    Response response = await dio.get(
      '${Constants.imageBaseURL}${plants.id.toString()}&field=image_256', // Replace with your image URL
      options: Options(responseType: ResponseType.bytes,
      headers: {'Cookie': await SessionTokenPreference.getSessionToken()}),
    );
    final Directory tempDir = await getTemporaryDirectory();
    final File tempFile = File('${tempDir.path}/temp_image.png');
    await tempFile.writeAsBytes(response.data);
    var payLoad = {'plantId': plants.id!.toString(),'plantName': plants.name!.toString()};
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
          payload: payLoad));

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
            payload: payLoad),
        schedule: NotificationInterval(interval: 60*1, preciseAlarm: true,timeZone: localTimeZone, repeats: true,allowWhileIdle: true),
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