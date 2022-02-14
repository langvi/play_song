import 'package:media/utils/song_db.dart';

class Song {
  int id;
  String? urlAvatar;
  String? nameSong;
  String? nameSinger;
  String? type;
  String pathSong;
  String get getNameSong {
    if (nameSong == null) {
      return 'No title';
    }
    return nameSong!;
  }

  String get getNameSinger {
    if (nameSinger == null) {
      return '(Unknown)';
    }
    return nameSinger!;
  }

  Song(
      {required this.pathSong,
      required this.id,
      this.nameSinger,
      this.nameSong,
      this.type,
      this.urlAvatar});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pathAvatar': urlAvatar,
      'name': nameSong,
      'type': type,
      'singer': nameSinger,
      'path': pathSong,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'] ?? 0,
      pathSong: map['path'] ?? '',
      urlAvatar: map['pathAvatar'],
      nameSong: map['name'],
      type: map['type'],
      nameSinger: map['singer'],
    );
  }
}
