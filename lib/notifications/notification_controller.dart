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
        'resource://drawable/ic_launcher_transparent',
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notifications for the app',
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
     if(receivedNotification.payload?["notification_type"] == Constants.fertilizer_notification_type) {
       notificationModule.notificationDescription = Constants.fertilizer_notification_desc;
       notificationModule.notificationType = Constants.fertilizer_notification_type;
       notificationModule.plantName = Constants.fertilizer_notification_title;
     }else if (receivedNotification.payload?["notification_type"] == Constants.water_notification_type){
       notificationModule.notificationDescription = Constants.water_notification_desc;
       notificationModule.notificationType = Constants.water_notification_type;
       notificationModule.plantName = receivedNotification.payload?["plantName"];
     }
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
       var abc = "avc";
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
    var payLoad = {'plantId': plants.id!.toString(),'plantName': plants.name!.toString(),'notification_type':Constants.water_notification_type};

    var content = NotificationContent(
        id: plants.id!, // -1 is replaced by a random number
        channelKey: 'alerts',
        title: '${plants.name} need water!',
        body:
        Constants.water_notification_desc,
        bigPicture: 'file://${tempFile.path}',
        //bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
        //largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
        largeIcon: 'asset://assets/images/ic_launcher_transparent.png',
        //'asset://assets/images/balloons-in-sky.jpg',
        notificationLayout: NotificationLayout.BigPicture,
        backgroundColor: const Color(0xff378564),
        payload: payLoad);
    //Send notification at that time
    await AwesomeNotifications().createNotification(
      content: content);

    //Schedule notification periodically
    await AwesomeNotifications().createNotification(
        content: content,
        schedule: NotificationInterval(interval: getIntervalFromDays(plants.waterFrequency), preciseAlarm: true,timeZone: localTimeZone, repeats: true,allowWhileIdle: true),
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

  static int getIntervalFromDays(dynamic days){
    var totalSecondsInWeek = 7*24*60*60;
    if(days!=null && days is int){
      int interval = (totalSecondsInWeek/days).round();
      return interval;
    }else{
      int interval = (totalSecondsInWeek/3).round();
      return interval;
    }
  }

  static Future<void> createFertilizerNotification(Plants plants) async {
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
    var payLoad = {'plantId': plants.id!.toString(),'plantName': plants.name!.toString(),'notification_type':Constants.fertilizer_notification_type};
    var content = NotificationContent(
        id: Constants.fertilizer_notification_id, // -1 is replaced by a random number
        channelKey: 'alerts',
        title: Constants.fertilizer_notification_title,
        body: Constants.fertilizer_notification_desc,
        bigPicture: 'file://${tempFile.path}',
        //bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
        //largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
        largeIcon: 'asset://assets/images/ic_launcher_transparent.png',
        //'asset://assets/images/balloons-in-sky.jpg',
        notificationLayout: NotificationLayout.BigPicture,
        backgroundColor: const Color(0xff378564),
        payload: payLoad);

    //Send notification at that time
    await AwesomeNotifications().createNotification(
        content: content);

    //Schedule notification periodically
    await AwesomeNotifications().createNotification(
      content: content,
      schedule: NotificationInterval(interval: Constants.fertilizer_notification_interval, preciseAlarm: true,timeZone: localTimeZone, repeats: true,allowWhileIdle: true));
  }

  static Future<void> stopFertilizerNotifications() async {
    await AwesomeNotifications().cancel(Constants.fertilizer_notification_id);
    await AwesomeNotifications().cancelSchedule(Constants.fertilizer_notification_id);
  }
}