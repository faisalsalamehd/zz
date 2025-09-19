import 'package:flutter/material.dart';

class PerformerItem extends StatelessWidget {
  const PerformerItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.genre,
    required this.event,
    this.onTap,
  });

  final String imageUrl;
  final String name;
  final String genre;
  final String event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
          radius: 28,
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🎵 $genre"),
            Text(event, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
