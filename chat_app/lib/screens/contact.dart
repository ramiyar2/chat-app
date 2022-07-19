import 'package:flutter/material.dart';
import '../data/color.dart';
import '../data/data.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _video =
        "https://img.icons8.com/fluency-systems-regular/48/000000/video-call.png";
    String _call =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/phone-disconnected.png";
    return Wrap(
      children: [Title('Contact'), ContactsList(_video, _call)],
    );
  }

  Container ContactsList(String _video, String _call) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 600,
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(contact[index]['userName']),
                subtitle: Text(
                  contact[index]['store'],
                  style: TextStyle(color: green),
                ),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          contact[index]["img"],
                        ),
                      )),
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.network(
                          _video,
                          width: 28,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.network(
                          _call,
                          width: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 20,
              ),
          itemCount: contact.length),
    );
  }
}

Container Title(String title) {
  return Container(
    margin: const EdgeInsets.only(top: 20, left: 25),
    child: Text(
      title,
      style: TextStyle(color: green, fontSize: 20),
    ),
  );
}
