import 'package:flutter/material.dart';
import 'package:preet/models/models.dart';
import 'package:preet/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;
  const ContentHeader({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _ContentHeaderMobile(featuredContent: featuredContent),
        desktop: _ContentHeaderDesktop(featuredContent: featuredContent));
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;
  const _ContentHeaderDesktop({super.key, required this.featuredContent});

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late VideoPlayerController _videoController;
  bool _isMuted = true;
  @override
  void initState() {
    _videoController =
        VideoPlayerController.network(widget.featuredContent.videoUrl!)
          ..initialize().then((value) => setState(() {}))
          ..setVolume(0)
          ..play();
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.isInitialized
                ? _videoController.value.aspectRatio
                : 2.344,
            child: _videoController.value.isInitialized
                ? VideoPlayer(_videoController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: _videoController.value.isInitialized
                  ? _videoController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
              ),
            ),
          ),
          Positioned(
              left: 60,
              right: 60,
              bottom: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Image.asset(
                      widget.featuredContent.titleImageUrl!,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.featuredContent.description!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(2, 4),
                              blurRadius: 6),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      PlayButton(),
                      const SizedBox(
                        width: 16,
                      ),
                      TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.fromLTRB(25, 10, 30, 10),
                          ),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.info_outline,
                            size: 30,
                          ),
                          label: const Text(
                            'More Info',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      if (_videoController.value.isInitialized)
                        IconButton(
                          onPressed: () => setState(() {
                            _isMuted
                                ? _videoController.setVolume(100)
                                : _videoController.setVolume(0);
                            _isMuted = _videoController.value.volume == 0;
                          }),
                          icon: Icon(
                              _isMuted ? Icons.volume_off : Icons.volume_up),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;
  const _ContentHeaderMobile({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(featuredContent.imageUrl),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: 500,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
        ),
        Positioned(
          bottom: 30,
          child: SizedBox(
            height: 250,
            child: Image.asset(
              featuredContent.titleImageUrl!,
              width: 300,
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  title: 'List',
                  onTap: () => print('My List'),
                ),
                PlayButton(),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  title: 'Info',
                  onTap: () => print('Info'),
                ),
              ],
            ))
      ],
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        padding: Responsive.isMobile(context)
            ? const EdgeInsets.fromLTRB(15, 5, 20, 5)
            : const EdgeInsets.fromLTRB(25, 10, 30, 10),
      ),
      onPressed: () => print('Play'),
      label: const Text(
        'Play',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      icon: const Icon(
        Icons.play_arrow,
        size: 30,
        color: Colors.black,
      ),
    );
  }
}
