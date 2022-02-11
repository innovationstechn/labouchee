import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> items = ["HELLO","easdsa","SDASDA","SASDASDAS","ASDADASDAS","ASDASDSAD",];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index){
            return Container(
                height: 30.h,
                child: Center(child: categoryCard()));
          },
        )
      ),
    );
  }

  Widget categoryCard(){
    return GestureDetector(
      onTap:(){},
      child: Column(
        children: [
          Icon(Icons.access_time_outlined,size: 8.h,),
          SizedBox(height: 5,),
          Text("Product Name",
            overflow: TextOverflow.fade,
            style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.normal,
          ),)
        ],
      ),
    );
  }
}


