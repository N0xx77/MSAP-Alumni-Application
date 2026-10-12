class Announcement {
  final String id;
  final String title;
  final String summary;
  final String content;
  final DateTime publishDate;
  final String category;
  final String author;
  final bool isPinned;
  final String? imageUrl;

  const Announcement({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.publishDate,
    required this.category,
    required this.author,
    this.isPinned = false,
    this.imageUrl,
  });
}

