import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');
	
class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

class Notifications {

	int _lastNotificationId = 0;

	Future<void> init() async {
	  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
	          Platform.isLinux
	      ? null
	      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
	  // String initialRoute = HomePage.routeName;
	  // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
	  //   selectedNotificationPayload = notificationAppLaunchDetails!.payload;
	  //   initialRoute = SecondPage.routeName;
	  // }

	  const AndroidInitializationSettings initializationSettingsAndroid =
	      AndroidInitializationSettings('app_icon');

	  /// Note: permissions aren't requested here just to demonstrate that can be
	  /// done later
	  final IOSInitializationSettings initializationSettingsIOS =
	      IOSInitializationSettings(
	          requestAlertPermission: false,
	          requestBadgePermission: false,
	          requestSoundPermission: false,
	          onDidReceiveLocalNotification: (
	            int id,
	            String? title,
	            String? body,
	            String? payload,
	          ) async {
	            didReceiveLocalNotificationSubject.add(
	              ReceivedNotification(
	                id: id,
	                title: title,
	                body: body,
	                payload: payload,
	              ),
	            );
	          });
	  const MacOSInitializationSettings initializationSettingsMacOS =
	      MacOSInitializationSettings(
	    requestAlertPermission: false,
	    requestBadgePermission: false,
	    requestSoundPermission: false,
	  );
	  final LinuxInitializationSettings initializationSettingsLinux =
	      LinuxInitializationSettings(
	    defaultActionName: 'Open notification',
	    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
	  );
	  final InitializationSettings initializationSettings = InitializationSettings(
	    android: initializationSettingsAndroid,
	    iOS: initializationSettingsIOS,
	    macOS: initializationSettingsMacOS,
	    linux: initializationSettingsLinux,
	  );
	  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
		    if (payload != null) {
		      debugPrint('notification payload: $payload');
		    }
		    selectedNotificationPayload = payload;
		    selectNotificationSubject.add(payload);
		  });
	}

	Future<void> showNotification(String? title, String? body, payload) async {
	const AndroidNotificationDetails androidPlatformChannelSpecifics =
	    AndroidNotificationDetails('your channel id', 'your channel name',
	        channelDescription: 'your channel description',
	        importance: Importance.max,
	        priority: Priority.high,
	        ticker: 'ticker');
	const NotificationDetails platformChannelSpecifics =
	    NotificationDetails(android: androidPlatformChannelSpecifics);
	await flutterLocalNotificationsPlugin.show(
	    _lastNotificationId++,
	    title,
	    body,
	    platformChannelSpecifics,
	    payload: payload,
	    );
	}
}

Notifications notificationsApi = Notifications();