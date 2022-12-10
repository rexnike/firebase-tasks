import 'package:flutter/material.dart';

import '../general/colors.dart';

class TextFieldNormalWidget extends StatelessWidget {

  String hintText;
  IconData icon;

  TextFieldNormalWidget({
    required this.hintText,
    required this.icon, 
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
                        prefixIcon: Icon(
                          icon,
                           size: 18.0, 
                           color: kBrandPrimaryColor.withOpacity(0.6),
                        ),
                        hintText: hintText,
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: kBrandPrimaryColor.withOpacity(0.6),
                        ),
                        filled: true,
                        fillColor: kBrandSecondColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    );
  }
}