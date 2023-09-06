import 'dart:convert';

import 'package:flutter/material.dart';

import '../preference_storage/storage_notifier.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key, required this.imageList});

  final List<dynamic> imageList;

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  /* final List<String> imageUrls = [
    'https://erp.heartyculturenursery.com/web/content/39381',
    'https://erp.heartyculturenursery.com/web/content/39381',
    'https://erp.heartyculturenursery.com/web/content/39381',
    //'https://nikonrumors.com/wp-content/uploads/2014/03/Nikon-1-V3-sample-photo-550x366.jpg',
    // Add more image URLs as needed
  ];*/

  late PageController _pageController;
  int currentIndex = 0;
  String? sessionId;
  late Map<String, String> headersMap;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
    getSessionId();
  }

  getSessionId() async {
    sessionId = await SessionTokenPreference.getSessionToken();
    setState(() {
      headersMap = {'Cookie': '$sessionId'};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageList.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return sessionId != null
                  ? widget.imageList[index] is int
                      ? Image.network(
                          "https://erp.heartyculturenursery.com/web/content/${widget.imageList[index]}",
                          headers: headersMap,
                          fit: BoxFit.cover,
                        )
                      : Image.memory(base64.decode(widget.imageList[index]),
                          fit: BoxFit.cover)
                  : Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
            },
          ),
        ),
        Container(
          height: 20,
          color: Colors.white,
          alignment: Alignment.center,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.imageList.length,
            itemBuilder: (context, index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).primaryColor),
                  color: currentIndex == index ? Theme.of(context).primaryColor : Colors.transparent,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
