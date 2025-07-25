# Flutter Push Notification Demo with Firebase

_A lightweight demo project to help you quickly integrate **Firebase Push Notifications** in your Flutter app. Get working code, clear instructions, and answers to common issues—from requesting notification permissions to handling FCM messages and displaying dialogs._

---

## 🚀 Project Overview

This repository demonstrates a minimal yet production-ready approach to implementing **Firebase Cloud Messaging (FCM)** in Flutter. It covers:

- Requesting notification permissions
- Generating and displaying the device's FCM token
- Handling foreground push notifications
- Displaying incoming messages using dialogs
- Subscribing to topics for targeted notifications

Perfect for developers searching for:
- **Firebase Push Notifications Flutter**
- **Flutter FCM Example**
- **Firebase Messaging Setup**
- **Send test push notifications Flutter**

---

## ✨ Features

- Request Android/iOS notification permissions
- Retrieve and print FCM device token
- Handle foreground push notifications with custom dialogs
- Subscribe/unsubscribe to topics (e.g., "news")
- Tested integration for both Android & iOS platforms
- Simple, readable code with comments

---

## 🛠️ Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/talibjameel/flutter_push_notification.git
cd flutter_push_notification
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

#### Android

- [Create a Firebase project](https://console.firebase.google.com/)
- Add your Android app and download `google-services.json`
- Place `google-services.json` in `android/app/`
- Update your `android/build.gradle`:
  ```gradle
  classpath 'com.google.gms:google-services:4.3.15'
  ```
- In `android/app/build.gradle` (at the bottom):
  ```gradle
  apply plugin: 'com.google.gms.google-services'
  ```
- Set minSdkVersion to **19** or higher.

#### iOS

- Add your iOS app in Firebase console and download `GoogleService-Info.plist`
- Place `GoogleService-Info.plist` in `ios/Runner/`
- In `ios/Podfile`, set platform to **10.0** or higher:
  ```ruby
  platform :ios, '10.0'
  ```
- Run:
  ```bash
  cd ios && pod install
  ```
- In Xcode, enable push notifications and background modes (Remote notifications).

---

## 🔥 Firebase Messaging Integration (Code Snippets)

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^2.0.0
  firebase_messaging: ^14.0.0
```

**Initialize Firebase and Messaging:**

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

**Request Permissions & Get Token:**

```dart
void initNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permissions (iOS)
  NotificationSettings settings = await messaging.requestPermission();
  // Get device token
  String? token = await messaging.getToken();
  print('FCM Token: $token');
}
```

**Handle Foreground Messages:**

```dart
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  if (message.notification != null) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(message.notification!.title ?? ''),
        content: Text(message.notification!.body ?? ''),
      ),
    );
  }
});
```

**Subscribe to a Topic:**

```dart
await FirebaseMessaging.instance.subscribeToTopic('news');
// To unsubscribe:
await FirebaseMessaging.instance.unsubscribeFromTopic('news');
```

---

## 📲 Testing Push Notifications

1. **Run the app on your device.**
2. **Copy the FCM device token** printed in the console.
3. **Send a test notification** via Firebase Console:
   - Go to Firebase > Cloud Messaging > Send your first message.
   - Set a title/body, and under "Target", choose "Single device" and paste the token.
4. **Or use cURL/Postman**:
   ```bash
   curl -X POST --header "Authorization: key=YOUR_SERVER_KEY" \
     --header "Content-Type: application/json" \
     https://fcm.googleapis.com/fcm/send \
     -d '{
       "to": "YOUR_DEVICE_TOKEN",
       "notification": {
         "title": "Test",
         "body": "Test message from cURL"
       }
     }'
   ```

---

## 🖼️ Screenshots

<img width="332" height="750" alt="Push Notification SS" src="https://github.com/user-attachments/assets/ea486bdb-77b2-444a-9aba-628c123c3974" />


---

## 📚 Topic Subscription Example

Want to send notifications to multiple users? Subscribe devices to topics like "news":

```dart
await FirebaseMessaging.instance.subscribeToTopic('news');
```
Then, send a message to that topic from the Firebase Console or via API by targeting `/topics/news`.

---

## ❓ Common Issues & FAQ

**Q: Notifications not received on iOS when app is in background/terminated?**  
A: Ensure you have enabled Background Modes > Remote Notifications in Xcode and APNS is set up correctly.

**Q: Device token is null or not showing?**  
A: Double-check Firebase initialization and permissions. For iOS, ensure permissions are granted.

**Q: Foreground messages not showing notification?**  
A: You must handle foreground messages in code (see snippet above)—they aren’t shown by default.

**Q: How to test on emulator/simulator?**  
A: Push notifications work best on real devices. Some emulators/simulators may not support FCM.

---


_#Firebase Push Notifications Flutter, #Flutter FCM Example, #Firebase Messaging Setup, #Send test push notifications Flutter_
