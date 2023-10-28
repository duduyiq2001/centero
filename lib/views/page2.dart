// ignore_for_file: prefer_const_constructors
// ignore_for_file: library_private_types_in_public_api

import "package:flutter/material.dart";

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(),
    );
  }
}
