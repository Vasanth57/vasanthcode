# How to Get Device Token - Quick Answer

## The Answer to Your Question

**Question:** "In this login how can get devicetoken"

**Answer:** Use Pusher Beams' `getDeviceId()` method after initializing:

```dart
Future<void> _initPusherBeams() async {
  try {
    const String beamsInstanceId = '262c7cd2-89a0-41f8-8d45-a3d7a9419f1d';
    final beams = PusherBeams.instance;

    // Step 1: Start Pusher Beams
    await beams.start(beamsInstanceId);
    
    // Step 2: Wait for initialization (optional but recommended)
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Step 3: Get device ID - THIS IS YOUR DEVICE TOKEN! ⭐
    String? deviceId = await beams.getDeviceId();
    
    // Step 4: Store it in your state variable
    setState(() {
      strDeviceToken = deviceId; // This is the device token
      // Also set device type
      if (Platform.isAndroid) {
        strDeviceType = "1";
      } else if (Platform.isIOS) {
        strDeviceType = "2";
      }
    });
    
    log("Device Token: $strDeviceToken"); // Log it for verification
    
  } catch (e) {
    log("Failed to get device token: $e");
  }
}
```

## The Key Method

```dart
String? deviceToken = await PusherBeams.instance.getDeviceId();
```

This method returns the device ID which serves as your device token for push notifications.

## Complete Flow

1. **In login.dart `initState()`:**
   ```dart
   @override
   void initState() {
     super.initState();
     _initPusherBeams(); // Call this to get device token
   }
   ```

2. **Device token is stored in `strDeviceToken`**

3. **Pass it to OTP page:**
   ```dart
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (_) => Otp(
         // ... other params
         deviceType: strDeviceType,
         deviceToken: strDeviceToken, // ⭐ Passed here
       ),
     ),
   );
   ```

4. **OTP page receives it and sends to backend:**
   ```dart
   await gp.login("1", "", mobile, deviceType, deviceToken, countrycode, countryName);
   ```

## Implementation Files

- ✅ **login.dart** - Contains `_initPusherBeams()` with proper device token retrieval
- ✅ **otp.dart** - Receives and uses the device token
- ✅ **DEVICE_TOKEN_GUIDE.md** - Comprehensive guide with alternatives and troubleshooting
- ✅ **README_LOGIN.md** - Complete implementation documentation

## Verification

After implementing, check your logs for:
```
✓ Pusher Beams started successfully
✓ Device ID retrieved: [device-id-here]
✓ Configured strDeviceToken: [device-id-here]
```

Then in OTP page:
```
Device Token being sent: [same-device-id]
```

## Package Requirement

Make sure you have in `pubspec.yaml`:
```yaml
dependencies:
  pusher_beams: ^1.1.3  # or latest version
```

---

**That's it!** The key is calling `await PusherBeams.instance.getDeviceId()` after starting Pusher Beams.
