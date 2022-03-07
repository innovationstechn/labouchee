import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/place_order_error.dart';
import 'package:sizer/sizer.dart';

import 'custom_text.dart';

class BookingDateAndTime extends StatefulWidget {
  final Function selectDate, selectTime;
  final String? selectedDate, selectedTime;
  final PlaceOrderErrorModel placeOrderValidationErrorModel;

  const BookingDateAndTime(
      {Key? key,
      required this.placeOrderValidationErrorModel,
      required this.selectDate,
      required this.selectTime,
      this.selectedDate,
      this.selectedTime})
      : super(key: key);

  @override
  _BookingDateAndTimeState createState() => _BookingDateAndTimeState();
}

class _BookingDateAndTimeState extends State<BookingDateAndTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomText(
                text: "Booking Date",
                color: Theme.of(context).primaryColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  primary: Colors.white,
                ),
                onPressed: () => widget.selectDate(),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: Colors.grey,
                              ),
                              CustomText(
                                  text: widget.selectedDate == ""
                                      ? "__,__,__"
                                      : widget.selectedDate,
                                  color: Colors.brown.shade600,
                                  fontSize: 14.0),
                            ],
                          ),
                        ],
                      ),
                      const CustomText(
                          text: "  Change",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ],
                  ),
                ),
              ),
              widget.placeOrderValidationErrorModel.bookingDate != null
                  ? CustomText(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      text: widget
                          .placeOrderValidationErrorModel.bookingDate!.first,
                      color: Colors.redAccent.shade200,
                    )
                  : Container(),
              const SizedBox(
                height: 20.0,
              ),
              CustomText(
                text: "Booking Time",
                color: Theme.of(context).primaryColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  primary: Colors.white,
                ),
                onPressed: () => widget.selectTime(),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.grey,
                              ),
                              CustomText(
                                  text: widget.selectedTime == ""
                                      ? "__,__,__"
                                      : widget.selectedTime,
                                  color: Colors.brown.shade600,
                                  fontSize: 14.0),
                            ],
                          )
                        ],
                      ),
                      const Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ),
              widget.placeOrderValidationErrorModel.bookingTime != null
                  ? CustomText(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      text: widget
                          .placeOrderValidationErrorModel.bookingTime!.first,
                      color: Colors.redAccent.shade200,
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
