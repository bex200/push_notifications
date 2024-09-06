String twoDigits(int n) => n.toString().padLeft(2, '0');

String formatTime(DateTime dateTime) {
  if (DateTime.now().day == dateTime.day) {
    return '${twoDigits(dateTime.hour)}:${twoDigits(dateTime.minute)}';
  } else if (DateTime.now().difference(dateTime).inDays == 1) {
    return '1 day ago';
  } else {
    return '${DateTime.now().difference(dateTime).inDays} days ago';
  }
}

String formatDateTime(DateTime dateTime) {
  String day = twoDigits(dateTime.day);
  String month = twoDigits(dateTime.month);
  String year = dateTime.year.toString();
  String time = formatTime(dateTime);

  return '$day/$month/$year at $time';
}
