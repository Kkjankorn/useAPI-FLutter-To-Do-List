// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBox1 extends StatelessWidget {
  String hinttext;
  bool hidetxt;
  var controltxt;
  final _formKey = GlobalKey<FormState>();
  String checktxt;
  String? value;

  String? validateName(value) {
    if (value == null || value.isEmpty) {
      return '$checktxt';
    }
    return null; // Return null if input is valid
  }

  TextBox1(this.hinttext, this.hidetxt, this.controltxt, this.checktxt);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 7),
      child: Form(
        key: _formKey,
        child: TextFormField(
          validator: validateName, // Call the validation function
          onSaved: (value) {
            controltxt = value!;
          },
          controller: controltxt,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          obscureText: hidetxt,
          decoration: InputDecoration(
            hintText: hinttext,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}

class TextBox2 extends StatelessWidget {
  String hinttext;
  var controltxt;

  TextBox2(this.hinttext, this.controltxt);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      width: MediaQuery.of(context).size.width * 0.85,
      child: Form(
        child: TextFormField(
          controller: controltxt,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hinttext,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class FieldText extends StatelessWidget {
  String hinttext;
  var controltxt;

  FieldText(this.hinttext, this.controltxt);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 166,
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 6,
        controller: controltxt,
        style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hinttext,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class ButtonApp extends StatelessWidget {
  Function() nextpage;
  String buttontex;
  double fontsize;
  FontWeight weight;

  ButtonApp(this.nextpage, this.buttontex, this.fontsize, this.weight);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                colors: [HexColor("#53CD9F"), HexColor("#0D7A5C")])),
        child: ElevatedButton(
          child: Text(
            buttontex,
            style: GoogleFonts.outfit(
                textStyle: TextStyle(
                    fontSize: fontsize,
                    fontWeight: weight,
                    color: Colors.white)),
          ),
          onPressed: nextpage,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(0, 193, 21, 21),
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ));
  }
}

class Styletxt extends StatelessWidget {
  double fontsize;
  String text;
  FontWeight weight;

  Styletxt(this.text, this.fontsize, this.weight);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
      style: GoogleFonts.outfit(
        fontSize: fontsize,
        fontWeight: weight,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}

class EditDelete extends StatelessWidget {
  String txt_appbut, img, img2;
  double box;

  EditDelete(this.txt_appbut, this.img, this.box, this.img2);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 40,
          child: Image(image: Svg(img)),
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Styletxt(txt_appbut, 16, FontWeight.w400),
            SizedBox(
              width: box,
            ),
            Image(image: Svg(img2)),
          ],
        ),
      ],
    );
  }
}
