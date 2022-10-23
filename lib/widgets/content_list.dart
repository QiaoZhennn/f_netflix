import 'package:flutter/material.dart';
import 'package:preet/models/models.dart';

class ContentList extends StatelessWidget {
  final title;
  final List<Content> contentList;
  const ContentList(
      {super.key, required this.title, required this.contentList});

  @override
  Widget build(BuildContext context) {
    bool isOriginal = title == "Netflix Originals";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: isOriginal ? 500 : 200,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final Content content = contentList[index];
              return GestureDetector(
                onTap: () => print(content.name),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: isOriginal ? 400 : 200,
                  width: isOriginal ? 200 : 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(content.imageUrl),
                          fit: BoxFit.cover)),
                ),
              );
            },
            itemCount: contentList.length,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
