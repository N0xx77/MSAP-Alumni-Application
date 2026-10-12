import 'package:flutter/foundation.dart';
import '../../models/event.dart';
import '../mock/mock_events.dart';

/// In-memory state store for events and RSVP interactions during the session.
class EventsStore extends ChangeNotifier {
  EventsStore._() : _events = List.from(mockEventsList);

  static final EventsStore instance = EventsStore._();

  List<Event> _events;

  List<Event> get events => List.unmodifiable(_events);

  Event? getEventById(String id) {
    try {
      return _events.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  bool toggleRsvp(String eventId) {
    final index = _events.indexWhere((e) => e.id == eventId);
    if (index == -1) return false;

    final current = _events[index];
    final newRsvp = !current.isRsvped;
    final updated = current.copyWith(
      isRsvped: newRsvp,
      rsvpCount: newRsvp ? current.rsvpCount + 1 : (current.rsvpCount > 0 ? current.rsvpCount - 1 : 0),
    );

    _events[index] = updated;
    notifyListeners();
    return newRsvp;
  }

  void reset() {
    _events = List.from(mockEventsList);
    notifyListeners();
  }
}
