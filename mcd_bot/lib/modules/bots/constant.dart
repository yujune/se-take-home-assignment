enum BotStatus {
  processing,
  idle;

  bool get isProcessing => this == BotStatus.processing;
  bool get isIdle => this == BotStatus.idle;
}
