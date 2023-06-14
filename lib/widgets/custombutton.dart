import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton(this.text,this.onTap);
  String text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap ,
      child: Container(
        decoration:BoxDecoration( color: Colors.grey,
            borderRadius: BorderRadius.circular(8)),


        width:double.infinity,
        height: 50,
        child: Center(
          child: Text(

            text,
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
