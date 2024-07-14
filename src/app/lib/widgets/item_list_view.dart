import 'package:flutter/material.dart';

class ItemListView extends StatelessWidget {
  final List<String> items;

  const ItemListView({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
