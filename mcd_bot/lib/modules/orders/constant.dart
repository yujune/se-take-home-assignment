enum OrderTab {
  pending(title: "Pending"),
  completed(title: "Completed");

  bool get isPending => this == OrderTab.pending;
  bool get isCompleted => this == OrderTab.completed;

  const OrderTab({
    required this.title,
  });
  final String title;
}

enum OrderStatus {
  idle,
  processing,
  completed;

  bool get isProcessing => this == OrderStatus.processing;
  bool get isCompleted => this == OrderStatus.completed;
  bool get isIdle => this == OrderStatus.idle;
}

enum OrderType {
  normal,
  vip;

  bool get isVip => this == OrderType.vip;
  bool get isNormal => this == OrderType.normal;
}
