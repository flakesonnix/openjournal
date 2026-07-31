import 'package:openjournal/models/experience/experience_list_item.dart';
import 'package:openjournal/services/database_service.dart';

class ExperienceDetailItem {
  final ExperienceListItem listItem;
  final List<TimedNote> timedNotes;

  ExperienceDetailItem({
    required this.listItem,
    required this.timedNotes,
  });
}
