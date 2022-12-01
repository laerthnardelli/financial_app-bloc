enum Type { expense, income }

enum Payment { normal, parcelled, fixed }

class Transaction {
  final DateTime date;
  final String description;
  final double value;
  final Type type;
  final int categoryId;
  final bool fulfilled;
  final int id;
  final Payment payment;

  Transaction({
    required this.date,
    required this.description,
    required this.value,
    required this.type,
    required this.categoryId,
    required this.fulfilled,
    required this.id,
    required this.payment,
  });

  String get valueString =>
      'R\$ ${value.toStringAsFixed(2).replaceFirst('.', ',')}';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': date.millisecondsSinceEpoch});
    result.addAll({'description': description});
    result.addAll({'value': value});
    result.addAll({'type': type.name});
    result.addAll({'categoryId': categoryId});
    result.addAll({'fulfilled': fulfilled});
    result.addAll({'id': id});
    result.addAll({'payment': payment.name});

    return result;
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    final type_ = map['type'] == 'expense' ? Type.expense : Type.income;
    final payment_ = map['payment'] == 'normal'
        ? Payment.normal
        : map['payment'] == 'fixed'
            ? Payment.fixed
            : Payment.parcelled;
    return Transaction(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      description: map['description'] ?? '',
      value: map['value']?.toDouble() ?? 0.0,
      type: type_,
      categoryId: map['categoryId']?.toInt() ?? 0,
      fulfilled: map['fulfilled'] ?? false,
      id: map['id']?.toInt() ?? 0,
      payment: payment_,
    );
  }

  Transaction copyWith({
    DateTime? date,
    String? description,
    double? value,
    Type? type,
    int? categoryId,
    bool? fulfilled,
    int? id,
    Payment? payment,
  }) {
    return Transaction(
      date: date ?? this.date,
      description: description ?? this.description,
      value: value ?? this.value,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      fulfilled: fulfilled ?? this.fulfilled,
      id: id ?? this.id,
      payment: payment ?? this.payment,
    );
  }
}
