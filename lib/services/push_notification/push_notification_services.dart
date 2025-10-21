// import 'dart:io';
// import 'package:flutter/material.dart';



// class PushNotificationService {
//   static final PushNotificationService _instance =
//   PushNotificationService._internal();
//   factory PushNotificationService() => _instance;
//   PushNotificationService._internal();

//   final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     // Request permission (iOS)
//     await _requestPermission();

//     // Init local notifications
//     await _initializeLocalNotifications();

//     // Register background handler (top-level function)
//     FirebaseMessaging.onBackgroundMessage(
//         _firebaseMessagingBackgroundHandler);

//     // Foreground notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint("📩 Foreground: ${message.notification?.title}");
//       _showNotification(
//         message.notification?.title,
//         message.notification?.body,
//       );
//     });

//     // App opened from background (user taps notification)
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint("📲 Notification opened: ${message.notification?.title}");
//       _showNotification(
//         message.notification?.title,
//         message.notification?.body,
//       );
//     });

//     // App opened from terminated state
//     RemoteMessage? initialMessage =
//     await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage != null) {
//       debugPrint("💀 Terminated state: ${initialMessage.notification?.title}");
//       _showNotification(
//         initialMessage.notification?.title,
//         initialMessage.notification?.body,
//       );
//     }

//     // Handle APNs + FCM token flow
//     await _initFCMToken();
//   }

//   Future<void> _requestPermission() async {
//     NotificationSettings settings =
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       criticalAlert: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       debugPrint("✅ Permission granted");
//     } else {
//       debugPrint("❌ Permission denied");
//     }
//   }

//   Future<void> _initFCMToken() async {
//     if (Platform.isIOS) {
//       // Wait until APNs token is available
//       String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//       debugPrint("📡 Current APNs token: $apnsToken");
//       if (apnsToken == null) {
//         debugPrint("⏳ Waiting for APNs token...");
//         FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
//           debugPrint("📱 iOS FCM Token (via refresh): $newToken");
//         });
//         return;
//       }
//     }

//     // Once APNs token exists (or Android), get FCM token
//     final fcmToken = await FirebaseMessaging.instance.getToken();
//     debugPrint("📱 FCM Token: $fcmToken");
//   }

//   Future<void> _initializeLocalNotifications() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = DarwinInitializationSettings();

//     const initSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );

//     await _localNotificationsPlugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (response) {
//         if (response.payload != null) {
//           debugPrint('🔔 Payload: ${response.payload}');
//         }
//       },
//     );
//   }

//   Future<void> _showNotification(String? title, String? body) async {
//     const androidDetails = AndroidNotificationDetails(
//       'default_channel_id',
//       'Default Channel',
//       channelDescription: 'For general notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const iosDetails = DarwinNotificationDetails();

//     const notificationDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await _localNotificationsPlugin.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique id
//       title ?? 'No Title',
//       body ?? 'No Body',
//       notificationDetails,
//     );
//   }
// }

// // Background handler (must be a top-level function, outside the class)
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//   const iosSettings = DarwinInitializationSettings();

//   const initSettings = InitializationSettings(
//     android: androidSettings,
//     iOS: iosSettings,
//   ); 

//   await flutterLocalNotificationsPlugin.initialize(initSettings);

//   const androidDetails = AndroidNotificationDetails(
//     'default_channel_id',
//     'Default Channel',
//     channelDescription: 'For general notifications',
//     importance: Importance.max,
//     priority: Priority.high,
//   );

//   const iosDetails = DarwinNotificationDetails();

//   const notificationDetails = NotificationDetails(
//     android: androidDetails,
//     iOS: iosDetails,
//   );

//   await flutterLocalNotificationsPlugin.show(
//     DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique id
//     message.notification?.title ?? "No Title",
//     message.notification?.body ?? "No Body",
//     notificationDetails,
//   );
// }
