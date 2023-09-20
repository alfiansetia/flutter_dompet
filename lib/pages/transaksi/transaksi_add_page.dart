import 'package:flutter/material.dart';

class TransaksiAddPage extends StatefulWidget {
  const TransaksiAddPage({super.key});

  @override
  State<TransaksiAddPage> createState() => _TransaksiAddPageState();
}

class _TransaksiAddPageState extends State<TransaksiAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: Center(
        child: Text('Text'),
      ),
    );
  }
}
