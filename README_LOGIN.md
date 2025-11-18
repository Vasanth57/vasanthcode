# Flutter Login with Device Token Implementation

This repository demonstrates how to implement a Flutter login flow with proper device token retrieval from Pusher Beams.

## Overview

The implementation includes:
1. **Login Page** (`lib/pages/login.dart`) - Handles phone number input and Pusher Beams device token retrieval
2. **OTP Page** (`lib/pages/otp.dart`) - Validates static OTP and completes login with device token
3. **Device Token Guide** (`DEVICE_TOKEN_GUIDE.md`) - Comprehensive guide on retrieving device tokens

## Key Changes Made

### ✅ Proper Device Token Retrieval in login.dart

The critical change is in the `_initPusherBeams()` method:

```dart
Future<void> _initPusherBeams() async {
  try {
    const String beamsInstanceId = '262c7cd2-89a0-41f8-8d45-a3d7a9419f1d';
    final beams = PusherBeams.instance;

    // Start Pusher Beams
    await beams.start(beamsInstanceId);
    
    // ⭐ KEY CHANGE: Get device ID (this is the device token)
    await Future.delayed(const Duration(milliseconds: 500));
    String? deviceId = await beams.getDeviceId();
    
    setState(() {
      if (Platform.isAndroid) {
        strDeviceType = "1";
      } else if (Platform.isIOS) {
        strDeviceType = "2";
      }
      strDeviceToken = deviceId; // ⭐ This is the actual device token
    });
  } catch (e) {
    log("Pusher Beams initialization failed: $e");
  }
}
```

### How Device Token is Retrieved

**The Answer to "How can I get device token?":**

1. **Initialize Pusher Beams:**
   ```dart
   await PusherBeams.instance.start(beamsInstanceId);
   ```

2. **Wait for initialization (optional but recommended):**
   ```dart
   await Future.delayed(const Duration(milliseconds: 500));
   ```

3. **Get the device ID (this IS the device token):**
   ```dart
   String? deviceId = await PusherBeams.instance.getDeviceId();
   strDeviceToken = deviceId; // Store it
   ```

### Device Token Flow

```
Login Page (login.dart)
    ↓
_initPusherBeams() called in initState()
    ↓
await beams.start(instanceId)
    ↓
await beams.getDeviceId() ← ⭐ This returns the device token
    ↓
Store in strDeviceToken variable
    ↓
Pass to OTP page via navigation
    ↓
OTP Page (otp.dart)
    ↓
Receive deviceToken in constructor
    ↓
Pass to login API
    ↓
Backend receives device token for push notifications
```

## Important Methods

### In login.dart:
- `_initPusherBeams()` - Initializes Pusher Beams and retrieves device token
- `codeSend()` - Navigates to OTP page with device token

### In otp.dart:
- `_checkOTPAndLogin()` - Validates OTP and calls login
- `_login()` - Sends device token to backend API

## Device Token Logging

The implementation includes comprehensive logging:

```dart
// In login.dart
log("✓ Device ID retrieved: $deviceId");
log("✓ Configured strDeviceType: $strDeviceType");
log("✓ Configured strDeviceToken: $strDeviceToken");

// In otp.dart
log("Device Type being sent: ${widget.deviceType}");
log("Device Token being sent: ${widget.deviceToken}");
log("click on Submit deviceToken => $deviceToken");
```

## Alternative: Firebase Cloud Messaging

If Pusher Beams doesn't work for your needs, you can use Firebase Cloud Messaging:

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _initFCM() async {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final String? fcmToken = await messaging.getToken();
  setState(() {
    strDeviceToken = fcmToken;
  });
}
```

## Troubleshooting

### Device Token is null

**Causes:**
- Pusher Beams not fully initialized
- Platform permissions not granted (iOS)
- Package version incompatibility

**Solutions:**
1. Add a delay after `start()`:
   ```dart
   await beams.start(instanceId);
   await Future.delayed(Duration(seconds: 1));
   final deviceId = await beams.getDeviceId();
   ```

2. Request permissions first (iOS):
   ```dart
   // Request notification permissions before getting device ID
   ```

3. Check package version in `pubspec.yaml`

### Method doesn't exist error

**Cause:** Using wrong package version

**Solution:** Check the exact package and version:
```yaml
dependencies:
  pusher_beams: ^1.1.3  # Verify this version
```

## Testing

To test the device token retrieval:

1. Run the app
2. Check logs for:
   ```
   ✓ Pusher Beams started successfully
   ✓ Device ID retrieved: [some-device-id]
   ✓ Configured strDeviceToken: [some-device-id]
   ```
3. Enter phone number and proceed to OTP
4. Check logs for:
   ```
   Device Token being sent: [same-device-id]
   click on Submit deviceToken => [same-device-id]
   ```

## Security Notes

⚠️ **Important:**
- Never log device tokens in production
- Use HTTPS for all API calls
- Validate tokens on the backend
- Implement proper error handling

## Summary

**To get the device token in your login flow:**

1. Call `await PusherBeams.instance.start(instanceId)` in `initState()`
2. Call `await PusherBeams.instance.getDeviceId()` to get the device token
3. Store it in a variable (`strDeviceToken`)
4. Pass it through navigation to the OTP page
5. Send it to your backend API during login

The device token is now properly retrieved and passed through the login flow!

## Files Structure

```
lib/
├── pages/
│   ├── login.dart      # Login page with device token retrieval
│   └── otp.dart        # OTP page that receives and uses device token
├── provider/
│   └── generalprovider.dart
├── utils/
│   ├── color.dart
│   ├── constant.dart
│   ├── dimens.dart
│   ├── sharedpre.dart
│   └── utils.dart
├── widget/
│   ├── myimage.dart
│   └── mytext.dart
└── webservice/
    └── socketmanager.dart

DEVICE_TOKEN_GUIDE.md  # Comprehensive guide on device token retrieval
README_LOGIN.md         # This file
```

## Next Steps

1. Test the implementation on both Android and iOS
2. Replace static OTP with real OTP verification
3. Implement proper error handling for failed token retrieval
4. Add retry mechanism for Pusher Beams initialization
5. Test push notifications with the retrieved device token

---

**Need Help?**

Refer to `DEVICE_TOKEN_GUIDE.md` for detailed information about device token retrieval methods and troubleshooting.
