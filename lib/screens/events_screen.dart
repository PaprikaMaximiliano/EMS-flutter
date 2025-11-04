import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  final List<Map<String, String>> events = const [
    {'title': '🎶 Jazz Night', 'location': 'Lviv, Art Center'},
    {'title': '🎨 Art Exhibition', 'location': 'Kyiv, City Gallery'},
    {'title': '🏃 Charity Run', 'location': 'Odesa, Sea Park'},
    {'title': '🎭 Theater Evening', 'location': 'Kharkiv, Drama Hall'},
  ];

  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width < 600 ? 16 : size.width * 0.15,
        vertical: 12,
      ),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final e = events[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: ListTile(
              title: Text(
                e['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(e['location']!),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Event "${e['title']}" tapped')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
