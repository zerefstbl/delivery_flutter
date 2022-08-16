import 'package:flutter/material.dart';

class NewDeliveryScreen extends StatefulWidget {
  const NewDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<NewDeliveryScreen> createState() => _NewDeliveryScreen();
}

class _NewDeliveryScreen extends State<NewDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
      ),
    );
  }
}