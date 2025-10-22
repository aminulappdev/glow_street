import 'package:flutter/material.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costom_app_bar.dart';

class InfoScreen extends StatefulWidget {
  final String title;
  final String content;
  const InfoScreen({super.key, required this.title, required this.content});

  @override
  State<InfoScreen> createState() => _InfoScreenState(); 
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( 
          children: [
            heightBox30,
            CustomAppBar(name: widget.title),
            heightBox12,
            Text(
              widget.content,
              style: TextStyle(),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
