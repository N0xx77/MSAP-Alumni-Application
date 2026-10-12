class PaymentRecord {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String status; // "Completed", "Pending", "Failed"
  final String category; // "Annual Dues", "Donation", "Event Ticket"
  final String transactionId;

  const PaymentRecord({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
    required this.category,
    required this.transactionId,
  });
}
