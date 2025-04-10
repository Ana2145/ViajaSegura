import 'package:flutter/material.dart';

class DrawerBottomCardTemplate extends StatefulWidget {
  final List<Widget> children;
  const DrawerBottomCardTemplate({super.key, required this.children});

  @override
  State<DrawerBottomCardTemplate> createState() =>
      _DrawerBottomCardTemplateState();
}

class _DrawerBottomCardTemplateState extends State<DrawerBottomCardTemplate> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(48.0),
            topRight: Radius.circular(48.0),
          ),
          border: Border(
            top: BorderSide(color: theme.focusColor, width: 2.0),
            left: BorderSide(color: theme.focusColor, width: 2.0),
            right: BorderSide(color: theme.focusColor, width: 2.0),
          ),
          color: theme.canvasColor,
        ),
        child: SingleChildScrollView(child: Column(children: widget.children)),
      ),
    );
  }
}
