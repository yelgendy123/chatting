import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField(this.hintText,this.icon,this.onChanged) ;
  String? hintText;
  Icon? icon;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
        validator:(data){
          if(data!.isEmpty){
            return'Value is empty';
          }

        } ,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,


        decoration:InputDecoration(
            suffixIcon: icon,
            hintText: hintText ,
            helperStyle: TextStyle(color: Colors.black),
            enabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.black,
                )
            ) ,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: Colors.black
                )
            )
        ),



    );
  }
}
