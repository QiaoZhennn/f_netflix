import 'package:flutter/material.dart';
import 'package:preet/assets.dart';
import 'package:preet/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;
  const CustomAppBar({super.key, this.scrollOffset = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: Responsive(
        mobile: _CustomAppBarMobile(),
        desktop: _CustomAppBarDesktop(),
      ),
    );
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  const _CustomAppBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(children: [
        Image.asset(Assets.netflixLogo0),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AppBarButton(title: 'TV Shows', onTap: () => print('TV Shows')),
              _AppBarButton(title: 'Movies', onTap: () => print('Movies')),
              _AppBarButton(title: 'My List', onTap: () => print('My List')),
            ],
          ),
        )
      ]),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  const _CustomAppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Assets.netflixLogo1),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _AppBarButton(title: 'Home', onTap: () => print('Home')),
                  _AppBarButton(
                      title: 'TV Shows', onTap: () => print('TV Shows')),
                  _AppBarButton(title: 'Movies', onTap: () => print('Movies')),
                  _AppBarButton(title: 'Latest', onTap: () => print('Latest')),
                  _AppBarButton(title: 'My List', onTap: () => print('My List')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () => print('search'),
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                        color: Colors.white,
                      )),
                  _AppBarButton(title: 'KIDS', onTap: () => print('KIDS')),
                  _AppBarButton(title: 'DVD', onTap: () => print('DVD')),
                  IconButton(
                      onPressed: () => print('gift'),
                      icon: const Icon(
                        Icons.card_giftcard,
                        size: 28,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () => print('notifications'),
                      icon: const Icon(
                        Icons.notifications,
                        size: 28,
                        color: Colors.white,
                      )),
                ],
              ),
          ]),
        ),
      ],
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final onTap;
  const _AppBarButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
