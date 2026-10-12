import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/alumni_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/mock/mock_alumni.dart';
import '../../../models/alumni.dart';

class AlumniSearchScreen extends StatefulWidget {
  const AlumniSearchScreen({super.key});

  @override
  State<AlumniSearchScreen> createState() => _AlumniSearchScreenState();
}

class _AlumniSearchScreenState extends State<AlumniSearchScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedDept = 'All';
  String _selectedBatch = 'All';

  final List<String> _departments = [
    'All',
    'Architecture & Design',
    'Interior Architecture',
    'Urban Design & Planning',
    'Landscape Architecture',
    'Building Construction Technology',
  ];

  final List<String> _batches = [
    'All',
    '2012',
    '2015',
    '2017',
    '2019',
    '2020',
    '2021',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _resetAllFilters() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _selectedDept = 'All';
      _selectedBatch = 'All';
    });
  }

  List<Alumni> get _filteredAlumni {
    return mockAlumniList.where((alumni) {
      final query = _searchQuery.trim().toLowerCase();
      final matchesQuery = query.isEmpty ||
          alumni.name.toLowerCase().contains(query) ||
          alumni.company.toLowerCase().contains(query) ||
          alumni.currentRole.toLowerCase().contains(query) ||
          alumni.location.toLowerCase().contains(query) ||
          alumni.department.toLowerCase().contains(query) ||
          alumni.graduationYear.toString().contains(query);

      final matchesDept =
          _selectedDept == 'All' || alumni.department == _selectedDept;
      final matchesBatch =
          _selectedBatch == 'All' || alumni.graduationYear.toString() == _selectedBatch;

      return matchesQuery && matchesDept && matchesBatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasActiveFilter =
        _searchQuery.isNotEmpty || _selectedDept != 'All' || _selectedBatch != 'All';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni Directory'),
        actions: [
          if (hasActiveFilter)
            IconButton(
              icon: const Icon(Icons.filter_alt_off_outlined),
              tooltip: 'Reset Filters',
              onPressed: _resetAllFilters,
            ),
        ],
      ),
      body: Column(
        children: [
          // Search Input Bar & Filters Container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            color: AppColors.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search by name, company, role, city, year...',
                    prefixIcon: const Icon(Icons.search, size: 20.0),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18.0),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 10.0),
                // Department filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _departments.map((dept) {
                      final isSelected = _selectedDept == dept;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(dept),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() => _selectedDept = dept);
                          },
                          backgroundColor: AppColors.surfaceVariant,
                          selectedColor: AppColors.primary.withValues(alpha: 0.15),
                          checkmarkColor: AppColors.primary,
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? AppColors.primary : AppColors.textSecondary,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: isSelected ? AppColors.primary : AppColors.border,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8.0),
                // Graduation Batch chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 6.0),
                        child: Text(
                          'Batch:',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                      ..._batches.map((batch) {
                        final isSelected = _selectedBatch == batch;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: ChoiceChip(
                            label: Text(batch == 'All' ? 'All Years' : batch),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() => _selectedBatch = batch);
                            },
                            backgroundColor: AppColors.surfaceVariant,
                            selectedColor: AppColors.secondary,
                            labelStyle: TextStyle(
                              fontSize: 11.0,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search Results Counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Found ${_filteredAlumni.length} Alumni',
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (hasActiveFilter)
                  GestureDetector(
                    onTap: _resetAllFilters,
                    child: const Text(
                      'Clear Filters',
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

          // Alumni Cards List
          Expanded(
            child: _filteredAlumni.isEmpty
                ? EmptyStateWidget(
                    title: 'No Alumni Found',
                    message: 'Try adjusting your search query or reset the applied filters.',
                    actionLabel: 'Reset Filters',
                    onActionPressed: _resetAllFilters,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    itemCount: _filteredAlumni.length,
                    itemBuilder: (context, index) {
                      final alumni = _filteredAlumni[index];
                      return AlumniCard(
                        alumni: alumni,
                        onTap: () => context.push('${AppConstants.routeAlumniDetail}/${alumni.id}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
