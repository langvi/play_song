import 'package:flutter/material.dart';
import 'package:media/base/colors.dart';
import 'package:media/features/play_song/play_song_page.dart';
import 'package:media/features/play_song/song.dart';
import 'package:media/utils/navigator.dart';

class PlayListPage extends StatefulWidget {
  PlayListPage({Key key}) : super(key: key);

  @override
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        elevation: 0,
        title: Text('New songs'),
        centerTitle: true,
        brightness: Brightness.dark,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              tileMode: TileMode.clamp,
              end: Alignment.bottomCenter,
              colors: [
            AppColors.backGroundColor,
            Color(0xff6e7dab),
            AppColors.activeColor2,
            AppColors.activeColor2,
            Color(0xff745d7d),
            Color(0xff585171),
          ])),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: 10,
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        itemBuilder: (context, index) {
          return _buildItemSong(index);
        },
      ),
    );
  }

  Widget _buildItemSong(int index) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          navToScreenWithTransition(
              context: context,
              toPage: PlaySongPage(
                  song: Song(
                      urlAvatar: 'assets/images/saving_private_ryan.jpg',
                      nameSong: 'Victory',
                      nameSinger: 'Two Step From Hell')));
        },
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 2, offset: Offset(-1, 2))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset('assets/images/saving_private_ryan.jpg',
                height: 70, width: 70, fit: BoxFit.fill),
          ),
        ),
        title: Text(
          'Saving private ryan',
          style: TextStyle(color: Colors.white),
        ),
        subtitle:
            Text('Peter Jackson', style: TextStyle(color: Colors.grey[300])),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            )),
      ),
    );
  }
}
