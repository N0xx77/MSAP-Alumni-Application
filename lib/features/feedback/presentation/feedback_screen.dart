import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String _category = 'General Query';
  int _rating = 5;
  bool _isSubmitting = false;

  final List<String> _categories = [
    'General Query',
    'Reunion / Event Feedback',
    'Membership & Dues',
    'Website / App Suggestion',
    'Other',
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isSubmitting = false);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.check_circle_outline, color: AppColors.success, size: 48),
            title: const Text('Feedback Recorded'),
            content: Text(
              'Thank you! Your feedback on "$_category" with a $_rating-star rating has been validated in the local app preview.\n\nNote: Backend submission service is not yet connected.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact & Feedback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We Value Your Input',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Reach out to the executive committee with inquiries, suggestions, or event feedback.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12.0),
              // Backend note banner
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, size: 16.0, color: AppColors.secondary),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'Frontend Preview: Submissions are validated locally and will connect to the backend server upon API integration.',
                        style: TextStyle(fontSize: 11.0, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Rating Selector
              const Text(
                'How would you rate your alumni experience?',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: List.generate(5, (index) {
                  final starValue = index + 1;
                  return IconButton(
                    icon: Icon(
                      starValue <= _rating ? Icons.star_rounded : Icons.star_border_rounded,
                      color: AppColors.secondary,
                      size: 32.0,
                    ),
                    tooltip: '$starValue star',
                    onPressed: () => setState(() => _rating = starValue),
                  );
                }),
              ),
              const SizedBox(height: 16.0),

              // Category Dropdown
              const Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
              ),
              const SizedBox(height: 6.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _category,
                    isExpanded: true,
                    items: _categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _category = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              AppTextField(
                label: 'Subject',
                hint: 'Brief summary of your topic',
                controller: _subjectController,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a subject.';
                  }
                  if (val.trim().length < 3) {
                    return 'Subject must be at least 3 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              AppTextField(
                label: 'Your Message',
                hint: 'Describe your feedback or question in detail...',
                controller: _messageController,
                maxLines: 5,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your feedback message.';
                  }
                  if (val.trim().length < 10) {
                    return 'Message must be at least 10 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 28.0),

              AppButton(
                text: 'Submit Feedback',
                icon: Icons.send_rounded,
                isLoading: _isSubmitting,
                onPressed: _submitFeedback,
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
