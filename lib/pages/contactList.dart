import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weather/services/firestoreServices.dart';

// ignore: must_be_immutable
class ContactList extends StatelessWidget {
  const ContactList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Your Coontacts",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        height: _height * 0.8,
        width: _width,
        child: FutureBuilder<List<QueryDocumentSnapshot<Object>>>(
          future: FirestoreData.getFavList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: _height * 0.8,
                width: _width * 0.8,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: _height * 0.1,
                      width: _width * 0.8,
                      child: Card(
                        child: ListTile(
                          title: Text(
                            snapshot.data[index]["name"],
                          ),
                          trailing: Text(
                            snapshot.data[index]["phone"],
                          ),
                          subtitle: Text(
                            snapshot.data[index]["gender"],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
        // child: ,
      ),
    );
  }
}
