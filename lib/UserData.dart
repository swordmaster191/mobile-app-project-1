class UserData {
  final String amount;
  final String category;
  final String date;

  const UserData({
    required this.amount,
    required this.category,
    required this.date,
  });

  UserData copy({
    String? amount,
    String? category,
    String? date,
  }) => UserData(
        amount: amount ?? this.amount,
        category: category ?? this.category,
        date: date ?? this.date,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserData &&
              runtimeType == other.runtimeType &&
              amount == other.amount &&
              category == other.category &&
              date == other.date;

  @override
  int get hashCode => amount.hashCode ^ category.hashCode ^ date.hashCode;
}