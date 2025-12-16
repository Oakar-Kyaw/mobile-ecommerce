import 'package:flutter/material.dart';

class ShowBottomSheetButton extends StatelessWidget {
  const ShowBottomSheetButton({super.key});

  void _showModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // Use a Column with MainAxisSize.min to wrap the content
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
              ),
              const ListTile(
                leading: Icon(Icons.link),
                title: Text('Get link'),
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  // Dismiss the bottom sheet when an item is tapped
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}