// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media/base/colors.dart';
import 'package:media/features/play_list/play_list_page.dart';
import 'package:media/features/play_song/play_song_page.dart';
import 'package:media/features/play_song/song.dart';
import 'package:media/main.dart';
import 'package:media/utils/navigator.dart';

class MediaPage extends StatefulWidget {
  MediaPage({Key? key}) : super(key: key);

  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  final List<String> sliders =
      List<String>.generate(5, (index) => 'assets/images/forrest_gumb.jpg');
  @override
  void initState() {
    getSongs();
    super.initState();
  }

  void getSongs() async {
    var result = await songDatabase.queryRecordByPage(1, 10);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backGroundColor,
            elevation: 0,
            brightness: Brightness.dark,
            title: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                'Discover',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
            bottom: TabBar(
                indicatorColor: AppColors.activeColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                labelStyle: TextStyle(fontSize: 16),
                tabs: [
                  Tab(
                    icon: Text('Title 1'),
                  ),
                  Tab(
                    icon: Text('Title 2'),
                  ),
                  Tab(
                    icon: Text('Title 3'),
                  ),
                  Tab(
                    icon: Text('Title 4'),
                  ),
                ]),
          ),
          body: Container(
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
                  ]),
            ),
            child: TabBarView(
              children: [
                _buildBody(),
                Center(
                  child: Text('2'),
                ),
                Center(
                  child: Text('3'),
                ),
                Center(
                  child: Text('4'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSlider(),
          _buildTitleAlbum('New Songs'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: _buildListAlbum(),
          ),
          _buildTitleAlbum('Recommend Playlist'),
          const SizedBox(
            height: 15,
          ),
          _buildListRecom()
          // _buildRecomentList()
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.85,
          height: 180,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        items: List<Widget>.generate(
            sliders.length,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      navToScreenWithTransition(
                          context: context,
                          toPage: PlaySongPage(
                              song: Song(
                                  urlAvatar: 'assets/images/forrest_gumb.jpg',
                                  pathSong: '',
                                  id: 1,
                                  nameSinger: 'Tom Hanks',
                                  nameSong: 'Forrest Gumb Soundtrack')));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                offset: Offset(-1, 2))
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          sliders[index],
                          fit: BoxFit.cover,
                          height: 170,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  Widget _buildTitleAlbum(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 20),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 4,
            decoration: BoxDecoration(
                color: AppColors.activeColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Material(
            color: Colors.transparent,
            child: InkWell(
                focusColor: Colors.white,
                highlightColor: AppColors.bottomNavColor,
                onTap: () {
                  navToScreenWithTransition(
                      context: context, toPage: PlayListPage());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildListAlbum() {
    return Container(
      height: 160,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 28),
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10,
          );
        },
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildItemAlbum(index);
        },
      ),
    );
  }

  Widget _buildItemAlbum(int index) {
    return InkWell(
      onTap: () {
        navToScreenWithTransition(
            context: context,
            toPage: PlaySongPage(
              song: Song(
                  pathSong: '',
                  id: 1,
                  urlAvatar: 'assets/images/interstellar.jpg',
                  nameSong: 'Interstellar Soundtrack',
                  nameSinger: 'Han simmer'),
            ));
      },
      child: Container(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(-1, 2))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset('assets/images/interstellar.jpg',
                    height: 120, width: 120, fit: BoxFit.fill),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Interstellar $index',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Han simmer',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[350], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListRecom() {
    return Material(
      color: Colors.transparent,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 28, right: 28, bottom: 10),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              navToScreenWithTransition(
                  context: context,
                  toPage: PlaySongPage(
                    song: Song(
                        pathSong: '',
                        urlAvatar: 'assets/images/interstellar.jpg',
                        id: 1,
                        nameSong: 'Interstellar Soundtrack',
                        nameSinger: 'Han simmer'),
                  ));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2,
                            offset: Offset(-1, 2))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/images/interstellar.jpg',
                        height: 80, width: 80, fit: BoxFit.fill),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'InterstInterstellarInterstellar $index',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Han simmer',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[350], fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget _buildRecomentList() {
  //   return GridView.count(
  //     physics: NeverScrollableScrollPhysics(),
  //     padding: EdgeInsets.symmetric(horizontal: 28),
  //     shrinkWrap: true,
  //     crossAxisSpacing: 15,
  //     childAspectRatio: 1,
  //     mainAxisSpacing: 10,
  //     crossAxisCount: 2,
  //     children: List<Widget>.generate(10, (index) => _buildItemRecomend(index)),
  //   );
  // }

  // Widget _buildItemRecomend(int index) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.black26, blurRadius: 2, offset: Offset(-1, 2))
  //             ]),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(15),
  //           child: Image.asset('assets/images/interstellar.jpg',
  //               height: 120, width: double.infinity, fit: BoxFit.fill),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 8,
  //       ),
  //       Text(
  //         'Interstellar $index',
  //         maxLines: 1,
  //         overflow: TextOverflow.ellipsis,
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       Text(
  //         'Han simmer',
  //         maxLines: 1,
  //         overflow: TextOverflow.ellipsis,
  //         style: TextStyle(color: Colors.grey[350], fontSize: 12),
  //       ),
  //     ],
  //   );
  // }
}
