// ignore_for_file: library_private_types_in_public_api

import "package:flutter/material.dart";
import "package:centero/views/page1.dart";

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  @override
  Widget build(BuildContext context) {
    return const Page1();
  }
}
