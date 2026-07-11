class BibleBook {
  final String id;
  final String name;
  final List<dynamic> chapters;

  BibleBook({
    required this.id,
    required this.name,
    required this.chapters,
  });

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    return BibleBook(
      id: json['id'],
      name: json['name'],
      chapters: json['chapters'],
    );
  }
}