// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:ui';

import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBox1 extends StatelessWidget {
  String hinttext;
  bool hidetxt;
  var controltxt;
  String checktxt;

  TextBox1(this.hinttext, this.hidetxt, this.controltxt, this.checktxt);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: TextFormField(
        validator: hinttext == 'Email'
            ? MultiValidator([
                EmailValidator(errorText: 'Enter a valid email address'),
                RequiredValidator(errorText: '${checktxt}'),
              ])
            : RequiredValidator(errorText: '${checktxt}'),
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
          filled: true,
          fillColor: HexColor('#F3F3F3'),
          border: DecoratedInputBorder(
              child: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              shadow: [
                BoxShadow(
                    color: HexColor("#000000").withOpacity(0.12),
                    blurRadius: 1,
                    spreadRadius: 0,
                    offset: Offset(0, 2))
              ]),
        ),
      ),
    );
  }
}

class TextBox2 extends StatelessWidget {
  String hinttext;
  var controltxt;
  String checktxt;

  TextBox2(this.hinttext, this.controltxt, this.checktxt);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      child: TextFormField(
        validator: RequiredValidator(errorText: '${checktxt}'),
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
        decoration: InputDecoration(
          filled: true,
          fillColor: HexColor('#FFFFFF'),
          hintText: hinttext,
          border: DecoratedInputBorder(
              child: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              shadow: [
                BoxShadow(
                    color: HexColor("#000000").withOpacity(0.2),
                    blurRadius: 6,
                    spreadRadius: 0,
                    offset: Offset(0, 0))
              ]),
        ),
      ),
    );
  }
}

class FieldText extends StatelessWidget {
  String hinttext;
  var controltxt;
  String checktxt;

  FieldText(this.hinttext, this.controltxt, this.checktxt);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 6,
        validator: MultiValidator([
          MaxLengthValidator(250,
              errorText: 'Description must not exceed 250 words.'),
          RequiredValidator(errorText: '${checktxt}')
        ]), // Call the validation function
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
        decoration: InputDecoration(
          filled: true,
          fillColor: HexColor('#FFFFFF'),
          hintText: hinttext,
          border: DecoratedInputBorder(
              child: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              shadow: [
                BoxShadow(
                    color: HexColor("#000000").withOpacity(0.2),
                    blurRadius: 6,
                    spreadRadius: 0,
                    offset: Offset(0, 0))
              ]),
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
