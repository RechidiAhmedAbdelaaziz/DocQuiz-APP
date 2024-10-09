extension ToTime on num {
  String get toTimeHourMinuteSecond {
    final int hours = this ~/ 3600;
    final int minutes = ((this - (hours * 3600)) / 60).toInt();
    final int seconds =
        (this - (((hours * 60) + minutes) * 60)).toInt();


    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get toTimeHourMinute {
    final int hours = this ~/ 3600;
    final int minutes = ((this - (hours * 3600)) / 60).toInt();
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  String get toTimeMinuteSecond {
    final int minutes = this ~/ 60;
    final int seconds = (this % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
