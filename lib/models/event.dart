class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String imageUrl;
  final String category;
  final bool isRsvped;
  final int rsvpCount;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.category,
    this.isRsvped = false,
    required this.rsvpCount,
  });

  Event copyWith({
    bool? isRsvped,
    int? rsvpCount,
  }) {
    return Event(
      id: id,
      title: title,
      description: description,
      date: date,
      location: location,
      imageUrl: imageUrl,
      category: category,
      isRsvped: isRsvped ?? this.isRsvped,
      rsvpCount: rsvpCount ?? this.rsvpCount,
    );
  }
}
