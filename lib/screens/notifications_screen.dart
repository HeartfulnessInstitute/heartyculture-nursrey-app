import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../modules/notification_module.dart';
import '../preference_storage/notification_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List<NotificationModule> notificationList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var notificationPreference = Provider.of<NotificationNotifier>(
        context, listen: true);
    notificationPreference.setNotificationList();
    notificationList = notificationPreference.notificationList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Notifications",
                style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400))),
            ElevatedButton(
                onPressed: () {
                  NotificationPreferenceHelper.clearAllNotification();
                },
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.2)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding:
                    MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(16, 3, 16, 3)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(50.0)))),
                child: Text(
                  "CLEAR ALL",
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: Theme
                            .of(context)
                            .primaryColor,
                        fontWeight: FontWeight.w700,
                      )),
                ))
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                return notificationListChild(index);
              }),
        ),
      ),
    );
  }

  Widget notificationListChild(int index) {
    return Container(
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset("assets/images/insect_eating_leaf.png",height: MediaQuery.of(context).size.height*.08),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notificationList[index].notificationType.toString(),
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff1976D2), fontWeight: FontWeight.w400))),
                Text(notificationList[index].plantName.toString(),
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Color(0xff212121), fontWeight: FontWeight.w400))),
                Text(notificationList[index].notificationDescription.toString(),
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff9E9E9E), fontWeight: FontWeight.w400))),
                ElevatedButton(
                    onPressed: () {
                      NotificationPreferenceHelper.removePlantFromList(notificationList[index]);
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        padding:
                        MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(20, 5, 20, 5)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(4.0)))),
                    child: Text(
                      "DONE",
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
