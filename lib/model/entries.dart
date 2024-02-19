import 'entry.dart';

class Entries {
  Entries({
    this.entries,
  });

  factory Entries.fromJson(Map<String, dynamic> json) {
    final List<dynamic> entries = json['entries'] as List<dynamic>;
    final List<Entry> parsedEntries =
        entries.map((dynamic json) => Entry.fromJson(json)).toList();

    return Entries(entries: parsedEntries);
  }

  final List<Entry>? entries;
}
