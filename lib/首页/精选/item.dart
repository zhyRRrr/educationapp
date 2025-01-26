import 'package:flutter/material.dart';
import '../ShortVideo.dart';

class Item extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const Item({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // padding: const EdgeInsets.fromLTRB(, 0, 0, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // 改变阴影的位置
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                image,
                height: 80,
                width: 90,
                fit: BoxFit.cover,
              ),
              // SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              // SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemsRow extends StatelessWidget {
  final List<Map<String, String>> items;

  const ItemsRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(13, 0, 15, 0),
      height: MediaQuery.of(context).size.height * 0.15, // 根据需要调整高度
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Item(
                title: items[0]["title"]!,
                subtitle: items[0]["subtitle"]!,
                image: items[0]["image"]!,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShortVideoPage()));
            },
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Item(
                  title: items[1]["title"]!,
                  subtitle: items[1]["subtitle"]!,
                  image: items[1]["image"]!,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Item(
                title: items[2]["title"]!,
                subtitle: items[2]["subtitle"]!,
                image: items[2]["image"]!,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Item(
                title: items[3]["title"]!,
                subtitle: items[3]["subtitle"]!,
                image: items[3]["image"]!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage:

