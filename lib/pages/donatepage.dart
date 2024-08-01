import 'package:waste_management/pages/storepage.dart';
import 'package:flutter/material.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donate')),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: const Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }

  Widget name() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          labelText: 'name of product',
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero)),
    );
  }

  Widget location() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          labelText: 'your location',
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero)),
    );
  }

  Widget button() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const StorePage()));
        },
        child: const Text(
          'Upload',
          style: TextStyle(fontSize: 25),
        ));
  }
}
