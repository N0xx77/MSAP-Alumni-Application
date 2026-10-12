import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/mock/user_profile_store.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profileStore = UserProfileStore.instance;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _roleController;
  late TextEditingController _companyController;
  late TextEditingController _locationController;
  late TextEditingController _bioController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final current = _profileStore.currentUser;
    _nameController = TextEditingController(text: current.name);
    _phoneController = TextEditingController(text: current.phone);
    _roleController = TextEditingController(text: current.currentRole);
    _companyController = TextEditingController(text: current.company);
    _locationController = TextEditingController(text: current.location);
    _bioController = TextEditingController(text: current.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        final current = _profileStore.currentUser;
        final updated = current.copyWith(
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
          currentRole: _roleController.text.trim(),
          company: _companyController.text.trim(),
          location: _locationController.text.trim(),
          bio: _bioController.text.trim(),
        );

        _profileStore.updateProfile(updated);

        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully (local mock store).'),
            duration: Duration(seconds: 2),
          ),
        );
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = _profileStore.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    AppAvatar(
                      radius: 46.0,
                      imageUrl: current.avatarUrl,
                      fallbackText: _nameController.text.isNotEmpty ? _nameController.text : current.name,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Avatar image upload requires backend storage integration.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              AppTextField(
                label: 'Full Name',
                controller: _nameController,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your name.';
                  }
                  if (val.trim().length < 2) {
                    return 'Name must be at least 2 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14.0),
              AppTextField(
                label: 'Phone Number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your contact phone.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14.0),
              AppTextField(
                label: 'Current Job Title / Role',
                controller: _roleController,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your current role or designation.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14.0),
              AppTextField(
                label: 'Company / Firm',
                controller: _companyController,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your current company or organization.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14.0),
              AppTextField(
                label: 'City & Country',
                controller: _locationController,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your location.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14.0),
              AppTextField(
                label: 'Short Bio',
                controller: _bioController,
                maxLines: 3,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a short bio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 28.0),

              AppButton(
                text: 'Save Changes',
                isLoading: _isSaving,
                onPressed: _saveProfile,
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
