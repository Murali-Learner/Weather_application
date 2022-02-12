import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/contactList.dart';
import 'package:weather/services/firestoreServices.dart';
import 'package:weather/services/providerService.dart';
import 'package:weather/widgets/inputField.dart';
import 'package:weather/widgets/toast.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    String _phoneController;
    String _nameController;
    var items = ["Male", "Female"];
    String gender = items.first;

    var id = new DateTime.now().microsecondsSinceEpoch;

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _height * 0.8,
              width: _width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.symmetric(
                vertical: _height * 0.08,
                horizontal: _width * 0.05,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: _height * 0.04,
                      width: _width * 0.03,
                    ),
                    InputField(
                        controller: _nameController,
                        hint: "Name",
                        type: TextInputType.name),
                    SizedBox(
                      height: _height * 0.04,
                      width: _width * 0.03,
                    ),
                    InputField(
                      controller: _phoneController,
                      type: TextInputType.number,
                      hint: "Phone Number",
                    ),
                    SizedBox(
                      height: _height * 0.04,
                      width: _width * 0.03,
                    ),
                    DropdownButtonFormField(
                      value: gender,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(color: Colors.green),
                          ),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          gender = newValue;
                        });
                        print(gender);
                      },
                    ),
                    SizedBox(
                      height: _height * 0.04,
                      width: _width * 0.03,
                    ),
                    Consumer<ProviderService>(builder: (context, value, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () async {
                          if (value.newName.isEmpty && value.newPhone.isEmpty) {
                            showToast("Enter Data");
                          } else {
                            FirestoreData.addUserData(id.toString(),
                                value.newPhone, value.newName, gender);
                          }
                        },
                        child: const Text("Add"),
                      );
                    }),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () async {
                          await FirestoreData.getFavList();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ContactList();
                              },
                            ),
                          );
                        },
                        child: const Text("Contacts")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}












//  DropdownButtonFormField(
//                           dropdownColor: Colors.green,
//                         // Initial Value
//                         value: dropdownvalue,
//                         decoration: InputDecoration(
//                           border: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(30.0),
//                             ),
//                           ),
//                           filled: true,
//                           hintStyle: TextStyle(color: Colors.grey[800]),
//                         ),

//                         // Down Arrow Icon
//                         icon: const Icon(Icons.keyboard_arrow_down),

//                         // Array list of items
//                         items: items.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Container(
//                                 child: Text(
//                               items,
//                               style: TextStyle(color: Colors.green),
//                             )),
//                           );
//                         }).toList(),

//                         onChanged: (String? newValue) {
//                           setState(() {
//                             dropdownvalue = newValue!;
//                           });
//                           print(dropdownvalue);
//                         },
//                       ),
// // //                         SizedBox(
// // //                           height: _height * 0.04,
// // //                         ), SizedBox(
// //                           height: _height * 0.04,
// //                           width: _width * 0.03,
// //                         ),
// //                         InputField(
// //                           emailController: _phoneController,
// //                           hint: "mobile",
// //                         ), SizedBox(
//                           height: _height * 0.04,
//                           width: _width * 0.03,
//                         ),
//                         InputField(
//                             emailController: _nameController, hint: "name"),