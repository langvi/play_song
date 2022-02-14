import 'package:file_picker/file_picker.dart';

class PickAudio {
  Future<List<String?>> getAudios() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.audio);
    List<String?> paths = [];
    if (result != null) {
      for (var item in result.files) {
        paths.add(item.path);
      }
    }
    return paths;
  }

  Future<String?> getAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result == null) return null;
    return result.paths.first;
  }
}
