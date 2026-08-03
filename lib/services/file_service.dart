import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as p;
import 'package:openjournal/models/experience/openjournal_export.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileService {
  Future<OpenJournalExport?> pickAndLoadBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      return OpenJournalExport.fromJson(json.decode(content));
    }
    return null;
  }

  Future<void> exportAndShare(OpenJournalExport data) async {
    final jsonString = json.encode(data.toJson());
    final directory = await getTemporaryDirectory();
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    final dateString = DateTime.now().toIso8601String().split('T').first;
    final filePath = p.join(directory.path, 'OpenJournal_Backup_$dateString.json');
    final file = File(filePath);
    await file.writeAsString(jsonString);

    await Share.shareXFiles([XFile(filePath)], text: 'OpenJournal Data Backup');
  }
}

final fileServiceProvider = Provider<FileService>((ref) {
  return FileService();
});
