String dateTimeFormat(DateTime date) {
  return '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}:${date.second}';
}
