import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SlidersWidget extends StatefulWidget {
  const SlidersWidget({super.key});

  @override
  State<SlidersWidget> createState() => _SlidersWidgetState();
}

class _SlidersWidgetState extends State<SlidersWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
          cardsSlider.map((card) {
            return Builder(
              builder: (context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: card['gradient'],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,

                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(card['icon'], size: 40, color: Colors.white.withOpacity(0.5),),
                          ],
                        ),

                        Text(
                          card['title'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(card['desc'], style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,

        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 700 ),
        enlargeCenterPage: true,
        enlargeFactor: 0.25,

      ),
    );
  }

  final List<Map<String, dynamic>> cardsSlider = [
    {
      'title': "Prioritize Yourself!",
      'desc':
          "With SenctuarAI you can keep track of how people affect your mentality",
      'gradient': LinearGradient(
        colors: [Color(0xFFe2afff),
          Color(0xFFc0fdff)],
      ),
      'icon': Icons.favorite,
    },
    {
      'title': "Sanctuary ",
      'desc': "This is your sacred place where you can be real and safe",
      'gradient': LinearGradient(
        colors: [Color(0xFFecf39e),
          Color(0xFFb7e4c7)],
      ),
      'icon': Icons.safety_check,
    },
    {
      'title': "AI-Powered Advices",
      'desc':
          "Write entries and receive advices that helps your growth as person",
      'gradient': LinearGradient(
        colors: [Color(0xFF00b4d8),
          Color(0xFFcaf0f8)],
      ),
      'icon': Icons.show_chart,
    },
  ];
}
