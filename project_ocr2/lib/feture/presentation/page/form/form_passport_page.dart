import 'package:flutter/material.dart';
import 'package:project_ocr2/feture/presentation/widget/elevatedbt_template.dart';
import 'package:project_ocr2/feture/presentation/widget/formfill_template.dart';

class FormPassportPage extends StatefulWidget {
  const FormPassportPage({super.key});

  @override
  State<FormPassportPage> createState() => _FormPassportPageState();
}

class _FormPassportPageState extends State<FormPassportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Form Passport",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                FormfillTemplate(
                  hintText: "passport number",
                  fillColor: Colors.white,
                  controller: TextEditingController(), //อย่าลืมมาแก้
                ),
                const SizedBox(height: 20),
                FormfillTemplate(
                  hintText: "Fullname Lastname",
                  fillColor: Colors.white,
                  controller: TextEditingController(), //อย่าลืมมาแก้
                ),
                const SizedBox(height: 20),
                FormfillTemplate(
                  hintText: "Nationality",
                  fillColor: Colors.white,
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 20),
                FormfillTemplate(
                  hintText: "Date of Birth",
                  fillColor: Colors.white,
                  controller: TextEditingController(), //อย่าลืมมาแก้
                ),
                const SizedBox(height: 20),
                FormfillTemplate(
                  hintText: "Date of Issue",
                  fillColor: Colors.white,
                  controller: TextEditingController(), //อย่าลืมมาแก้
                ),
                const SizedBox(height: 20),
                FormfillTemplate(
                  hintText: "Date of Expiry",
                  fillColor: Colors.white,
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 20),
                FormfillTemplate(
                  hintText: "เลข MRZ",
                  fillColor: Colors.white,
                  controller: TextEditingController(), //อย่าลืมมาแก้
                ),
                const SizedBox(height: 20),
                ElevatedbtTemplate(
                  text: "บันทึก",
                  backgroundColor: Colors.lightBlue,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
