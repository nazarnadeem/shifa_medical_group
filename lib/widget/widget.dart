import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CarosolSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: Carousel(
        dotBgColor: Colors.transparent,
        dotSize: 0,
        autoplay: true,
        images: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.network(
              "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618566499779/medicines-offers.jpg",
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.network(
              "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618566499779/medicines-offers.jpg",
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.network(
              "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618566499779/medicines-offers.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
