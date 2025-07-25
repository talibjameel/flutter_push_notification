import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';



class NotificationHandler extends StatefulWidget {
  const NotificationHandler({super.key});

  @override
  State<NotificationHandler> createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _deviceToken;

  @override
  void initState() {
    super.initState();
    _initFCM();
    _listenToForegroundMessages();
  }

  Future<void> _initFCM() async {
    _deviceToken = await _firebaseMessaging.getToken();
    debugPrint("🔐 FCM Token: $_deviceToken");
    setState(() {}); // Refresh UI to show token
  }

  void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📩 Foreground Message: ${message.data}");

      if (message.notification != null) {
        _showNotificationDialog(
          title: message.notification!.title ?? 'No Title',
          body: message.notification!.body ?? 'No Body',
        );
      }
    });
  }

  void _showNotificationDialog({required String title, required String body}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(body),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  Widget _buildTokenSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "📲 Your FCM Device Token",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurple.shade100),
          ),
          child: SelectableText(
            _deviceToken ?? "Fetching token...",
            style: const TextStyle(fontSize: 13, fontFamily: 'Courier'),
          ),
        ),
      ],
    );
  }

  Widget _buildGuideSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 24),
        Text(
          "🛠 How to Use This Token",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "1. Copy the FCM token shown above.\n"
              "2. Open Firebase Console → Cloud Messaging → Send Test.\n"
              "3. Paste the token and send a test notification.\n"
              "4. When your app is in foreground, a dialog will appear.\n"
              "5. In background, the OS handles the notification display.",
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF), // Light lavender background
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAD4FF), // Soft purple
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "🚀 Firebase Push Notifications",
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: const [
                        Icon(Icons.notifications_active, size: 60, color: Color(0xFF6A5AE0)),
                        SizedBox(height: 12),
                        Text(
                          "Welcome to Notification Demo",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Integrate Firebase Push Notifications easily!",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTokenSection(),
                  _buildGuideSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
