class ExpiryCalculator {
  final DateTime expiryDate;

  const ExpiryCalculator({required this.expiryDate});

  int daysToExpiry() {
    final now = DateTime.now();
    final difference = expiryDate.difference(now);
    return difference.inDays;
  }

  String expiryStatus() {
    int days = daysToExpiry().abs();

    if (daysToExpiry() > 1) {
      return "Expires in $days days";
    } else if (daysToExpiry() == 1) {
      return "Expires in 1 day";
    } else if (daysToExpiry() == 0) {
      return "Expiring today!";
    } else if (daysToExpiry() == -1) {
      return "Expired 1 day ago";
    } else {
      return "Expired $days days ago";
    }
  }
}
