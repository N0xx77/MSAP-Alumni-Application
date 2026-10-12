import '../../models/payment_record.dart';

final List<PaymentRecord> mockPaymentHistory = [
  PaymentRecord(
    id: 'pay_501',
    title: 'Annual Membership Renewal 2026',
    amount: 1500.0,
    date: DateTime(2026, 01, 10),
    status: 'Completed',
    category: 'Annual Dues',
    transactionId: 'TXN_998822110',
  ),
  PaymentRecord(
    id: 'pay_502',
    title: 'Contribution: Student Scholarship Fund',
    amount: 5000.0,
    date: DateTime(2025, 11, 20),
    status: 'Completed',
    category: 'Donation',
    transactionId: 'TXN_776655443',
  ),
  PaymentRecord(
    id: 'pay_503',
    title: 'Grand Reunion 2025 Gala Ticket',
    amount: 1200.0,
    date: DateTime(2025, 10, 15),
    status: 'Completed',
    category: 'Event Ticket',
    transactionId: 'TXN_443322119',
  ),
];
