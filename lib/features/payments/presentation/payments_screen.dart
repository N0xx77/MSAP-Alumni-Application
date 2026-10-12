import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/mock/mock_payments.dart';
import '../../../data/mock/user_profile_store.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final UserProfileStore _profileStore = UserProfileStore.instance;

  @override
  void initState() {
    super.initState();
    _profileStore.addListener(_onProfileUpdated);
  }

  @override
  void dispose() {
    _profileStore.removeListener(_onProfileUpdated);
    super.dispose();
  }

  void _onProfileUpdated() {
    if (mounted) setState(() {});
  }

  void _showGatewayNoticeModal(BuildContext context, {required String title, required String amount}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.payment_outlined, color: AppColors.secondary, size: 40),
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: $amount',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.secondary, size: 20),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Payment gateway (Razorpay / UPI / NetBanking) is not yet integrated with the backend.\n\nTransactions cannot be processed at this time.',
                      style: TextStyle(fontSize: 12.0, color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Understood'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = _profileStore.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments & Dues'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prominent Gateway Offline Banner
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_clock_outlined, color: Color(0xFFD97706), size: 22.0),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Payment Processing Notice: Real payment processing is not yet connected to the backend. All records displayed are mock previews.',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF92400E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Membership Status Card
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentProfile.membershipStatus.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Icon(Icons.verified_rounded, color: AppColors.secondary, size: 20),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    currentProfile.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'ID: ${currentProfile.membershipId}',
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                    ),
                  ),
                  const Divider(color: Colors.white24, height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Annual Dues 2026-2027',
                            style: TextStyle(fontSize: 11.0, color: Colors.white70),
                          ),
                          Text(
                            '₹1,500 / year',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(110, 36),
                        ),
                        onPressed: () => _showGatewayNoticeModal(
                          context,
                          title: 'Annual Membership Dues',
                          amount: '₹1,500',
                        ),
                        child: const Text('Pay Dues'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24.0),

            Text(
              'Payment History',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12.0),

            if (mockPaymentHistory.isEmpty)
              const EmptyStateWidget(
                icon: Icons.receipt_long_outlined,
                title: 'No Payment History',
                message: 'No previous transactions found on your alumni account.',
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mockPaymentHistory.length,
                itemBuilder: (context, index) {
                  final payment = mockPaymentHistory[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                      leading: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: AppColors.successBackground,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_circle_outline, color: AppColors.success, size: 20.0),
                      ),
                      title: Text(
                        payment.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        '${payment.transactionId} • ${payment.date.day}/${payment.date.month}/${payment.date.year}',
                        style: const TextStyle(fontSize: 12.0, color: AppColors.textMuted),
                      ),
                      trailing: Text(
                        '₹${payment.amount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),

            const SizedBox(height: 24.0),

            // Contribution Banner
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.volunteer_activism_rounded, color: AppColors.secondary, size: 22.0),
                      SizedBox(width: 8.0),
                      Text(
                        'Student Scholarship & Endowment',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  const Text(
                    'Support young architecture & design students with financial aid and research grants.',
                    style: TextStyle(fontSize: 13.0, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 14.0),
                  AppButton(
                    text: 'Make a Voluntary Contribution',
                    type: AppButtonType.outlined,
                    onPressed: () => _showGatewayNoticeModal(
                      context,
                      title: 'Voluntary Endowment Contribution',
                      amount: 'Custom Amount',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
