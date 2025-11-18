# Device Token Flow - Visual Guide

## 🎯 Your Question
**"In this login how can get devicetoken"**

## 📱 The Complete Flow

```
╔════════════════════════════════════════════════════════════════╗
║                     APP STARTS                                  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  LOGIN PAGE (login.dart)                                        ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ initState() {                                            │  ║
║  │   _initPusherBeams(); ← CALLED HERE                      │  ║
║  │ }                                                         │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  _initPusherBeams() METHOD                                      ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ Step 1: await beams.start(instanceId)                    │  ║
║  │         ↓                                                 │  ║
║  │ Step 2: await Future.delayed(500ms)                      │  ║
║  │         ↓                                                 │  ║
║  │ Step 3: deviceId = await beams.getDeviceId() ⭐⭐⭐      │  ║
║  │         ↓                                                 │  ║
║  │ Step 4: strDeviceToken = deviceId                        │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  DEVICE TOKEN IS NOW AVAILABLE!                                 ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ strDeviceToken = "abc123xyz..."                          │  ║
║  │ strDeviceType = "1" (Android) or "2" (iOS)               │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  USER ENTERS PHONE NUMBER                                       ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ Phone: +1234567890                                       │  ║
║  │ [Continue Button]                                        │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  codeSend() METHOD                                              ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ Navigator.push(                                          │  ║
║  │   Otp(                                                   │  ║
║  │     deviceType: strDeviceType,    ← PASSED               │  ║
║  │     deviceToken: strDeviceToken,  ← PASSED ⭐            │  ║
║  │   )                                                      │  ║
║  │ )                                                        │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  OTP PAGE (otp.dart)                                            ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ Received:                                                │  ║
║  │   widget.deviceToken = "abc123xyz..."                   │  ║
║  │   widget.deviceType = "1"                                │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  USER ENTERS OTP                                                ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ OTP: 1 2 3 4 5 6 (static for testing)                   │  ║
║  │ [Login Button]                                           │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  _checkOTPAndLogin() METHOD                                     ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ if (otp == "123456") {                                   │  ║
║  │   _login(                                                │  ║
║  │     mobile,                                              │  ║
║  │     widget.deviceType,   ← USING TOKEN                   │  ║
║  │     widget.deviceToken   ← USING TOKEN ⭐                │  ║
║  │   )                                                      │  ║
║  │ }                                                        │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  _login() METHOD                                                ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ await gp.login(                                          │  ║
║  │   "1",              // type (mobile login)               │  ║
║  │   "",               // email (empty for mobile)          │  ║
║  │   mobile,           // phone number                      │  ║
║  │   deviceType,       // "1" or "2"                        │  ║
║  │   deviceToken,      // "abc123xyz..." ⭐⭐⭐             │  ║
║  │   countrycode,      // country code                      │  ║
║  │   countryName       // country name                      │  ║
║  │ )                                                        │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  BACKEND API RECEIVES                                           ║
║  ┌──────────────────────────────────────────────────────────┐  ║
║  │ POST /api/login                                          │  ║
║  │ {                                                        │  ║
║  │   "mobile": "+1234567890",                               │  ║
║  │   "deviceType": "1",                                     │  ║
║  │   "deviceToken": "abc123xyz...",  ⭐⭐⭐                 │  ║
║  │   "countryCode": "+1",                                   │  ║
║  │   "countryName": "US"                                    │  ║
║  │ }                                                        │  ║
║  └──────────────────────────────────────────────────────────┘  ║
╚════════════════════════════════════════════════════════════════╝
                              ↓
╔════════════════════════════════════════════════════════════════╗
║  SUCCESS! USER LOGGED IN                                        ║
║  Device token is now stored on backend for push notifications   ║
╚════════════════════════════════════════════════════════════════╝
```

## 🔑 The Key Code

### In login.dart:
```dart
Future<void> _initPusherBeams() async {
  final beams = PusherBeams.instance;
  await beams.start('262c7cd2-89a0-41f8-8d45-a3d7a9419f1d');
  
  // ⭐ THIS IS HOW YOU GET THE DEVICE TOKEN ⭐
  String? deviceId = await beams.getDeviceId();
  
  setState(() {
    strDeviceToken = deviceId; // Store it!
  });
}
```

### Pass it to OTP page:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => Otp(
      deviceToken: strDeviceToken, // ⭐ Pass it here
    ),
  ),
);
```

### Send it to backend:
```dart
await gp.login(
  "1",
  "",
  mobile,
  deviceType,
  deviceToken, // ⭐ Send it here
  countrycode,
  countryName
);
```

## 📊 Data Flow Table

| Step | Location | Action | Result |
|------|----------|--------|--------|
| 1 | login.dart | `beams.start()` | Pusher initialized |
| 2 | login.dart | `beams.getDeviceId()` | **Device token retrieved** ⭐ |
| 3 | login.dart | `strDeviceToken = deviceId` | Token stored in state |
| 4 | login.dart | Navigate to OTP | Token passed via params |
| 5 | otp.dart | Receive in constructor | Token available in widget |
| 6 | otp.dart | `_login()` called | Token sent to backend |
| 7 | Backend | API receives data | Token stored for push notifications |

## 🎯 Summary

**Question:** "How can get devicetoken?"

**Answer in 3 steps:**
1. `await beams.start(instanceId)`
2. `String? token = await beams.getDeviceId()` ← **THIS IS IT!**
3. `strDeviceToken = token`

**That's all!** The token flows through navigation to OTP page and then to your backend. 🚀
