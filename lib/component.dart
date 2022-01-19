import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
   TextInputType? type,
  required FormFieldValidator<String>  validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  Function()? suffixPressed,
  Function()? onTap,
}) =>
    TextFormField(

      validator: validate,
      controller: controller,
      onTap: onTap,

      keyboardType: type,
      // to be easy and educate the keyboard that we will enter an email so can provide an @ sign in the keyboard
      decoration: InputDecoration(
        labelText: label,
        // we can choose between it or hintText same function giving a label for the text field
        prefixIcon: Icon(prefix),
//        suffixIcon:suffix != null?  Icon(suffix): null,
      suffixIcon:suffix != null?  IconButton(icon:Icon(suffix),onPressed:suffixPressed):null,
        // put and Icon in the start of the Textfield
        border: OutlineInputBorder(),
      ),
      onFieldSubmitted: (value) {
        print(value);
      },
      // After user enter the full email and and press ( enter ) from the keyboard it saves here in the Value
      onChanged: (value) {
        print(value);
      },
        obscureText: isPassword//while user enter the email letter by letter will appear that value ( even no enter pressed using the keyboard )
      // Although the both of them we will not use them ( onFieldsubmitted - onchanged )
    );


Widget buildTaskItem (Map model)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text('${model['time']}'),
      ),
      SizedBox(
        width: 20.0,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${model['title']}",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            "${model['date']}",
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          )
        ],
      )
    ],
  ),
);