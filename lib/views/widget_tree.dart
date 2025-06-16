import 'package:flutter/material.dart';
import 'package:sanctuarai/views/Widgets/appbar_widget.dart';
import 'package:sanctuarai/views/Widgets/navbar_widget.dart';
import 'package:sanctuarai/views/pages/home_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: HomePage(),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
