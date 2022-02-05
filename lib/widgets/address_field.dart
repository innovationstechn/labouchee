import 'package:flutter/material.dart';
import 'package:labouchee/app/locator.dart';
import 'package:labouchee/pages/gmap.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:stacked_services/stacked_services.dart';

class AddressFormWidget extends FormField<String> {
  final String? labelText;
  final BuildContext? context;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final Function(String?) validationMethod;
  final String? errorText;
  AddressFormWidget({Key? key,
    this.context,
    this.textEditingController,
    this.labelText,
    this.focusNode,
    this.errorText,
    required this.validationMethod,
    String initialValue = "",
    bool isButtonTapped = false,
    AutovalidateMode autoValidate = AutovalidateMode.disabled})
      : super(
      key: key,
      initialValue: initialValue,
      autovalidateMode: autoValidate,
      builder: (FormFieldState<String> state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal:4.w,vertical:2.w),
          child: Column(
            children: [
              TextFormField(
                controller: textEditingController,
                onChanged: (String? text) {
                  state.didChange(textEditingController!.text);
                },
                validator: (String? text) {
                  String? isValidationFailed = validationMethod(text);
                  if (isValidationFailed != null) {
                    return isValidationFailed;
                  }
                },
                autofocus: true,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorText: errorText,
                  // hintText: hintText,
                  labelText: labelText,
                  labelStyle: TextStyle(
                      color: focusNode!.hasFocus
                          ? Colors.black
                          : Theme
                          .of(context!)
                          .primaryColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w300),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme
                          .of(context!)
                          .primaryColor,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    onPressed: () async {
                      if(!isButtonTapped) {
                        isButtonTapped = true;
                        try {
                          String? result = await _navigateNextPageAndRetriveValue(
                              context);
                          if(result!=null){
                            state.didChange(result);
                            textEditingController!.text = result;
                          }
                        } catch (e) {
                          print(e);
                          final _snackbarService = locator<SnackbarService>();
                          _snackbarService.showSnackbar(
                              message: "TURN ON YOUR LOCATION");
                        }finally{
                          isButtonTapped = false;
                        }
                      }
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });


  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<String?> _navigateNextPageAndRetriveValue(BuildContext context) async {

    Position? _locationData = await _determinePosition();

    final List<double> result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GMAP(latitude: _locationData.latitude,longitude: _locationData.longitude,)),
    );

    List<Placemark> placemarks;
    if(result==null){
      placemarks = await placemarkFromCoordinates(_locationData.latitude, _locationData.longitude);
    }else{
      placemarks = await placemarkFromCoordinates(result[0], result[1]);
    }


    return placemarks.first.name! + "/" + placemarks.first.street! + "/" +placemarks.first.locality!+"/"+
        placemarks.first.subAdministrativeArea!+"/"+placemarks.first.administrativeArea!+"/"+placemarks.first.country!;
  }
}