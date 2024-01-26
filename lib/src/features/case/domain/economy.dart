class Economy {
  final double hoursCostprice;
  final double hoursSalesprice;
  final int offer;
  final double billableHoursCount;
  final int materialsCostprice;

  Economy({
    required this.hoursCostprice,
    required this.hoursSalesprice,
    required this.offer,
    required this.billableHoursCount,
    required this.materialsCostprice,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'hoursCostprice': hoursCostprice,
      'hoursSalesprice': hoursSalesprice,
      'offer': offer,
      'billableHoursCount': billableHoursCount,
      'materialsCostprice': materialsCostprice,
    };
  }

  factory Economy.fromJson(Map<String, dynamic> json) {
    return Economy(
      hoursCostprice: (json['hoursCostprice'] ?? 0).toDouble(),
      hoursSalesprice: (json['hoursSalesprice'] ?? 0).toDouble(),
      offer: json['offer'] ?? 0,
      billableHoursCount: (json['billableHoursCount'] ?? 0).toDouble(),
      materialsCostprice: json['materialsCostprice'] ?? 0,
    );
  }
}
