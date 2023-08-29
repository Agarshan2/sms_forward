import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:sms_advanced/sms_advanced.dart';

void main() {
  runApp(SmsForwarderApp());
}

class SmsForwarderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS Forwarder',
      home: SmsForwarderScreen(),
    );
  }
}

class SmsForwarderScreen extends StatefulWidget {
  @override
  _SmsForwarderScreenState createState() => _SmsForwarderScreenState();
}

class _SmsForwarderScreenState extends State<SmsForwarderScreen> {
  TextEditingController receivedMessageController = TextEditingController();
  TextEditingController recipientController = TextEditingController();

  void _forwardSms() async {
    String receivedMessage = receivedMessageController.text;
    String recipient = recipientController.text;

    String forwardMessage = "Forwarded message: $receivedMessage";

    try {
      await sendSMS(message: forwardMessage, recipients: [recipient]);
      // SMS forwarded successfully
    } catch (error) {
      // Handle error
      print('Error forwarding SMS: $error');
    }
  }

  @override
  void initState() {
   listenForSms();
    super.initState();
  }
  void listenForSms() async {

    SmsReceiver receiver = SmsReceiver();

    receiver.onSmsReceived?.listen((SmsMessage message) { });   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Forwarder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: receivedMessageController,
              decoration: InputDecoration(labelText: 'Received Message'),
            ),
            TextField(
              controller: recipientController,
              decoration: InputDecoration(labelText: 'Recipient'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _forwardSms,
              child: Text('Forward SMS'),
            ),
          ],
        ),
      ),
    );
  }
}
