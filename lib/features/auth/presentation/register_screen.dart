import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _yearController = TextEditingController();
  final _deptController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreeTerms = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _yearController.dispose();
    _deptController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Association Terms of Membership.'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registration form validated for ${_nameController.text.trim()} (Offline Demo Mode).',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        context.go(AppConstants.routeHome);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni Registration'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join the Network',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Register your details to access member directory and events.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12.0),
                // Demo notice banner
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
                          'Frontend Preview Mode: Enter your details to test input validation. Live registration will connect to the server in the next milestone.',
                          style: TextStyle(fontSize: 11.0, color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                AppTextField(
                  label: 'Full Name',
                  hint: 'e.g. Ananya Sharma',
                  controller: _nameController,
                  prefixIcon: const Icon(Icons.person_outline, size: 20.0),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your full name.';
                    }
                    if (val.trim().length < 2) {
                      return 'Name must be at least 2 characters.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14.0),
                AppTextField(
                  label: 'Email Address',
                  hint: 'name@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined, size: 20.0),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your email address.';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!emailRegex.hasMatch(val.trim())) {
                      return 'Please enter a valid email format.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Graduation Year',
                        hint: 'e.g. 2018',
                        controller: _yearController,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.school_outlined, size: 20.0),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Enter year.';
                          }
                          final yr = int.tryParse(val.trim());
                          if (yr == null || yr < 1960 || yr > 2030) {
                            return 'Valid year (1960-2030).';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: AppTextField(
                        label: 'Department',
                        hint: 'e.g. Architecture',
                        controller: _deptController,
                        prefixIcon: const Icon(Icons.business_outlined, size: 20.0),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Enter department.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.0),
                AppTextField(
                  label: 'Password',
                  hint: '••••••••',
                  controller: _passwordController,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline, size: 20.0),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter a password.';
                    }
                    if (val.length < 6) {
                      return 'Password must be at least 6 characters.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Checkbox(
                        value: _agreeTerms,
                        onChanged: (val) {
                          if (val != null) setState(() => _agreeTerms = val);
                        },
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Expanded(
                      child: Text(
                        'I agree to the MSAP Alumni Association Terms of Membership and Privacy Policy.',
                        style: TextStyle(fontSize: 12.0, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                AppButton(
                  text: 'Create Account',
                  isLoading: _isLoading,
                  onPressed: _handleRegister,
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already registered?',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
