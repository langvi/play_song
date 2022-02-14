import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:media/base/colors.dart';
import 'package:media/base/config.dart';
import 'package:media/base/input_text.dart';
import 'package:media/features/play_song/song.dart';
import 'package:media/main.dart';
import 'package:media/utils/pick_audio.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final _nameController = TextEditingController();
  final _singerController = TextEditingController();
  final types = [
    'Epic',
    'Romanctic',
    'Lo-Fi',
    'EDM',
    'Game soundtrack',
    'Film soundtrack',
    'Baroque',
    'Another'
  ];
  final audioPicker = PickAudio();
  String? _currentType;
  String? _pathSong;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              tileMode: TileMode.clamp,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.backGroundColor,
                // AppColors.activeColor2,
                Color(0xff585171),
              ]),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Create new song',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: InputText(
                          controller: _nameController,
                          hintText: 'Enter song name',
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                      ),
                      InputText(
                        controller: _singerController,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        hintText: 'Enter name singer',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 4,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: AppColors.activeColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Pick file audio',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                TextSpan(
                                    text: ' *',
                                    style: TextStyle(color: Colors.orange))
                              ])),
                        ],
                      ),
                      // Text('Pick file audio'),
                      _buildPickAudio(),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 4,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: AppColors.activeColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Text(
                            'Select type',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      _buildPickType()
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_pathSong == null) {
                    Fluttertoast.showToast(msg: 'You do not choose file');
                  } else {
                    saveSongToLocal();
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: AppColors.backGroundColor),
                child: Text('Save to Playlist')),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPickAudio() {
    if (_pathSong == null) {
      return TextButton(
          onPressed: () async {
            _pathSong = await audioPicker.getAudio();
            setState(() {});
          },
          child: Row(
            children: [
              Icon(
                Icons.file_upload_outlined,
                color: AppColors.activeColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Open your device',
                style: TextStyle(
                  color: AppColors.activeColor,
                ),
              )
            ],
          ));
    } else {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.activeColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                _pathSong!.split('/').last,
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _pathSong = null;
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ))
          ],
        ),
      );
    }
  }

  Widget _buildPickType() {
    return DropdownButton<String>(
      isExpanded: true,
      hint: Text(
        'Type...',
        style: TextStyle(color: Colors.grey),
      ),
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.white,
      dropdownColor: AppColors.backGroundColor,
      items: types
          .map((e) => DropdownMenuItem<String>(
                child: Text(
                  e,
                  style: TextStyle(color: Colors.white),
                ),
                value: e,
              ))
          .toList(),
      value: _currentType,
      onChanged: (value) {
        setState(() {
          _currentType = value;
        });
      },
    );
  }

  void saveSongToLocal() async {
    int currentId = preferences.getInt(KEY_PRIMARY_ID) ?? 1;
    Song song = Song(
      pathSong: _pathSong!,
      id: currentId,
      nameSong: _nameController.text.trim(),
      nameSinger: _singerController.text.trim(),
      type: _currentType,
      urlAvatar: ''
    );
    await songDatabase.insert(song.toMap());
    preferences.setInt(KEY_PRIMARY_ID, currentId + 1);
    print('Insert song success...');
  }
}
