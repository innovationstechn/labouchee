import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewUI extends StatelessWidget {
  final String? image, name, date, comment;
  final double? rating;
  final Function? onTap, onPressed;
  final bool? isLess;
  const ReviewUI({
    Key? key,
    this.image,
    this.name,
    this.date,
    this.comment,
    this.rating,
    required this.onTap,
    this.isLess,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Container(
          padding: EdgeInsets.only(
            top: 2.0,
            bottom: 2.0,
            left: 16.0,
            right: 0.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 45.0,
                    width: 45.0,
                    margin: EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(44.0),
                    ),
                  ),
                  Text(
                    name!,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: (){},
                  //   icon: Icon(Icons.more_vert),
                  // ),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  RatingBarIndicator(
                    itemBuilder: (_, __) => const Icon(
                      Icons.star,
                      color: Color(0xffDE970B),
                    ),
                    rating: rating ?? 0,
                    itemSize: 0.04 * constraints.maxWidth,
                    unratedColor: Colors.grey[300],
                  ),
                  SizedBox(width: 16),
                  Text(
                    date!,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              GestureDetector(
                onTap:()=> onTap,
                child: isLess!
                    ? Text(
                  comment!,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF808080),
                  ),
                )
                    : Text(
                  comment!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF808080),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}