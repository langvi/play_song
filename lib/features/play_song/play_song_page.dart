import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:media/base/colors.dart';
import 'package:media/features/play_song/song.dart';
import 'package:media/utils/custom_seekbar.dart';

class PlaySongPage extends StatefulWidget {
  final Song song;
  PlaySongPage({Key key, @required this.song}) : super(key: key);

  @override
  _PlaySongPageState createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySongPage>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController _seekController;
  Animation<Color> colorTween;
  Animation<double> valueTween;
  double _currentProgress = 0.0;
  AnimationController _rotationController;
  bool _isPauseSong = false;
  @override
  void initState() {
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..forward();
    valueTween = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    );

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _seekController = AnimationController(vsync: this);
    animationController.forward();
    colorTween = _seekController
        .drive(ColorTween(begin: Colors.blueAccent, end: Colors.grey));
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    AppColors.backGroundColor.withOpacity(0.2),
                    BlendMode.dstATop),
                image: Image.asset(widget.song.urlAvatar).image,
              ),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.mirror,
                  colors: [
                    Color(0xff6181bc),
                    AppColors.backGroundColor.withOpacity(0.5),
                    AppColors.bottomNavColor,
                    Colors.black,
                  ])),
          child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                widget.song.nameSong,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              widget.song.nameSinger,
              style: TextStyle(color: Colors.grey[300], fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            _buildAvatar(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: _buildSeekBar(),
            ),
            _buildControl(),
            _buildAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return RotationTransition(
      turns: valueTween,
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  blurRadius: 4, color: Colors.black26, offset: Offset(-1, 2))
            ],
            border: Border.all(color: Color(0xff848fb9), width: 8)),
        child: ClipOval(
          child: Image.asset(
            widget.song.urlAvatar,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 10,
          bottom: 10,
          left: 10,
          right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Widget _buildSeekBar() {
    return Column(
      children: [
        CustomSeekBar(
          value: _currentProgress,
          progressColor: Colors.white,
          progressWidth: 4,
          onProgressChanged: (value) {
            setState(() {
              _currentProgress = value;
            });
          },
          barColor: AppColors.unactiveColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '2:22',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '4:44',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildControl() {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              color: Colors.white,
              icon: Icon(
                AntDesign.banckward,
                size: 34,
              ),
              onPressed: () async {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () async {
                  if (_isPauseSong) {
                    print('pause');
                    _isPauseSong = !_isPauseSong;
                    _rotationController.forward();
                  } else {
                    _isPauseSong = !_isPauseSong;
                    _rotationController.stop();
                  }
                  if (animationController.status == AnimationStatus.completed) {
                    setState(() {
                      animationController.reverse();
                    });
                  } else {
                    setState(() {
                      animationController.forward();
                    });
                  }
                },
                child: AnimatedIcon(
                    size: 50,
                    color: Colors.white,
                    icon: AnimatedIcons.play_pause,
                    progress: animationController),
              ),
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(
                AntDesign.forward,
                size: 34,
              ),
              onPressed: () async {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Feather.refresh_ccw,
                      color: Colors.grey[400],
                    )),
              ),
              Expanded(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      AntDesign.hearto,
                      color: Colors.grey[400],
                    )),
              ),
              Expanded(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Feather.download,
                      color: Colors.grey[400],
                    )),
              ),
              Expanded(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                      color: Colors.grey[400],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
