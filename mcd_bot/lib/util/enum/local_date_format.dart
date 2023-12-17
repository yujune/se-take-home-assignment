enum LocalDateFormat {
  dateWithTime(value: "dd/MM/yyyy hh:mm:ss a");

  final String value;
  const LocalDateFormat({
    required this.value,
  });
}
