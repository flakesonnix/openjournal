import 'package:intl/intl.dart';

class DateUtilsOpenJournal {
  static String getDateWithWeekdayText(DateTime date) {
    return DateFormat('EEEE, d MMM yyyy').format(date);
  }

  static String getTimeText(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String getRelativeTimeText(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return getDateWithWeekdayText(date);
    }
  }
}
