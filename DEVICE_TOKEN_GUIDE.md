# How to Get Device Token in Flutter Login with Pusher Beams

## Overview
This guide explains how to properly retrieve the device token from Pusher Beams SDK in your Flutter login flow.

## Pusher Beams SDK Methods

The Pusher Beams SDK for Flutter provides several methods to retrieve device information:

### 1. **For `pusher_beams` package (most common)**

```dart
import 'package:pusher_beams/pusher_beams.dart';

Future<void> _initPusherBeams() async {
  try {
    const String beamsInstanceId = '262c7cd2-89a0-41f8-8d45-a3d7a9419f1d';
    final beams = PusherBeams.instance;
    
    // Initialize Pusher Beams
    await beams.start(beamsInstanceId);
    
    // Get device ID (this is your device token)
    final String? deviceId = await beams.getDeviceId();
    
    setState(() {
      if (Platform.isAndroid) {
        strDeviceType = "1";
      } else if (Platform.isIOS) {
        strDeviceType = "2";
      } else {
        strDeviceType = "0";
      }
      strDeviceToken = deviceId; // This is the device token
    });
    
    log("Device Type: $strDeviceType");
    log("Device Token: $strDeviceToken");
  } catch (e) {
    log("Pusher Beams initialization failed: $e");
  }
}
```

### 2. **Alternative Methods**

Depending on your `pusher_beams` package version, you might use:

```dart
// Method 1: getDeviceId()
final String? deviceId = await PusherBeams.instance.getDeviceId();

// Method 2: getDeviceInterests() - for checking subscriptions
final List<String>? interests = await PusherBeams.instance.getDeviceInterests();
```

### 3. **For iOS - Request Push Permissions First**

On iOS, you need to request permission before getting the device token:

```dart
import 'dart:io';

Future<void> _initPusherBeamsIOS() async {
  if (Platform.isIOS) {
    // Request permission first
    await PusherBeams.instance.start(beamsInstanceId);
    
    // The device token will be available after user grants permission
    final String? deviceId = await PusherBeams.instance.getDeviceId();
    
    setState(() {
      strDeviceType = "2"; // iOS
      strDeviceToken = deviceId;
    });
  }
}
```

## Complete Implementation in login.dart

Here's the updated `_initPusherBeams()` method for login.dart:

```dart
Future<void> _initPusherBeams() async {
  try {
    const String beamsInstanceId = '262c7cd2-89a0-41f8-8d45-a3d7a9419f1d';
    final beams = PusherBeams.instance;

    // Start Pusher Beams
    await beams.start(beamsInstanceId);
    log('Pusher Beams started successfully');

    // Get the device ID (this is the device token)
    String? deviceId;
    try {
      deviceId = await beams.getDeviceId();
      log('Device ID retrieved: $deviceId');
    } catch (e) {
      log('Failed to get device ID: $e');
      // Device ID might not be available immediately on some platforms
      // You can retry or proceed without it
    }

    setState(() {
      if (Platform.isAndroid) {
        strDeviceType = "1";
      } else if (Platform.isIOS) {
        strDeviceType = "2";
      } else {
        strDeviceType = "0";
      }
      strDeviceToken = deviceId; // Set the device token
    });

    log("Configured strDeviceType: $strDeviceType");
    log("Configured strDeviceToken: $strDeviceToken");
  } catch (e) {
    log("Pusher Beams initialization failed: $e");
    // Set default values even if Pusher fails
    setState(() {
      if (Platform.isAndroid) {
        strDeviceType = "1";
      } else if (Platform.isIOS) {
        strDeviceType = "2";
      } else {
        strDeviceType = "0";
      }
      strDeviceToken = null; // Will be null if Pusher fails
    });
  }
}
```

## Using Firebase Cloud Messaging (Alternative)

If Pusher Beams doesn't meet your needs, you can use Firebase Cloud Messaging (FCM):

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _initFCM() async {
  try {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    
    // Request permission (iOS)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get FCM token
      final String? fcmToken = await messaging.getToken();
      
      setState(() {
        if (Platform.isAndroid) {
          strDeviceType = "1";
        } else if (Platform.isIOS) {
          strDeviceType = "2";
        }
        strDeviceToken = fcmToken;
      });
      
      log("FCM Token: $fcmToken");
    }
  } catch (e) {
    log("FCM initialization failed: $e");
  }
}
```

## Package Versions

Make sure your `pubspec.yaml` has the correct package:

```yaml
dependencies:
  pusher_beams: ^1.1.3  # or latest version
  # OR for Firebase:
  # firebase_messaging: ^14.0.0
```

## Troubleshooting

### Issue: `getDeviceId()` returns null
- **Cause**: Pusher Beams not fully initialized
- **Solution**: Add a delay or retry mechanism:
  ```dart
  await beams.start(beamsInstanceId);
  await Future.delayed(Duration(seconds: 1));
  final deviceId = await beams.getDeviceId();
  ```

### Issue: Method doesn't exist
- **Cause**: Using wrong package version
- **Solution**: Check package documentation for your specific version

### Issue: iOS not getting token
- **Cause**: Permissions not granted
- **Solution**: Ensure you request notification permissions first

## Summary

**The key method to get device token from Pusher Beams is:**
```dart
final String? deviceToken = await PusherBeams.instance.getDeviceId();
```

This should be called **after** `PusherBeams.instance.start(instanceId)` completes successfully.
