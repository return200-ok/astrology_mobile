class ImperialCastRequest {
  const ImperialCastRequest({
    required this.spiritId,
    required this.arrivalDay,
    required this.streamHour,
  });

  final String spiritId;
  final DateTime arrivalDay;
  final String streamHour;
}
