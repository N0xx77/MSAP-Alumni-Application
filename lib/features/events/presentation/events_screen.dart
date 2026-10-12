import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/event_card.dart';
import '../../../data/mock/events_store.dart';
import '../../../models/event.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String _selectedCategory = 'All';
  final EventsStore _eventsStore = EventsStore.instance;

  final List<String> _categories = [
    'All',
    'Reunion',
    'Symposium',
    'Workshop',
    'Excursion',
  ];

  @override
  void initState() {
    super.initState();
    _eventsStore.addListener(_onStoreUpdated);
  }

  @override
  void dispose() {
    _eventsStore.removeListener(_onStoreUpdated);
    super.dispose();
  }

  void _onStoreUpdated() {
    if (mounted) setState(() {});
  }

  void _toggleRsvp(Event event) {
    final newRsvp = _eventsStore.toggleRsvp(event.id);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newRsvp
              ? 'RSVP confirmed for "${event.title}". You\'re attending!'
              : 'RSVP removed for "${event.title}".',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<Event> get _filteredEvents {
    final allEvents = _eventsStore.events;
    if (_selectedCategory == 'All') return allEvents;
    return allEvents.where((e) => e.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni Events'),
      ),
      body: Column(
        children: [
          // Category Selector Chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            color: AppColors.surface,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedCategory = cat);
                      },
                      backgroundColor: AppColors.surfaceVariant,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        fontSize: 13.0,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Events Counter / Filter notice
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${_filteredEvents.length} Events',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (_selectedCategory != 'All')
                  GestureDetector(
                    onTap: () => setState(() => _selectedCategory = 'All'),
                    child: const Text(
                      'Show All Categories',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Events List
          Expanded(
            child: _filteredEvents.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.event_busy_outlined,
                    title: 'No Events Found',
                    message: 'There are currently no events matching the "$_selectedCategory" category.',
                    actionLabel: 'View All Events',
                    onActionPressed: () => setState(() => _selectedCategory = 'All'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = _filteredEvents[index];
                      return EventCard(
                        event: event,
                        onTap: () => context.push('${AppConstants.routeEventDetail}/${event.id}'),
                        onRsvpTap: () => _toggleRsvp(event),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
