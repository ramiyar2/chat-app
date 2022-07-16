import 'package:chat_app_flutter2/data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_flutter2/main.dart';

class Call extends StatelessWidget {
  const Call({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _call =
        "https://img.icons8.com/fluency-systems-regular/48/FFFFFF/phone-disconnected.png";
    String _up =
        "https://img.icons8.com/external-dreamstale-lineal-dreamstale/32/000000/external-up-arrows-dreamstale-lineal-dreamstale-5.png";
    String _down =
        "https://img.icons8.com/material-rounded/24/000000/down3.png";

    return Wrap(
      children: [
        Title('Stores'),
        CallsList(_up, _down, _call),
      ],
    );
  }

  Container CallsList(String _up, String _down, String _call) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 600,
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(call[index]['userName']),
                subtitle: Row(
                  children: [
                    Image.network(
                      call[index]['answered'] == true ? _up : _down,
                      width: 12,
                      color:
                          call[index]['answered'] == true ? green : Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      call[index]['time'],
                      style: TextStyle(color: green),
                    )
                  ],
                ),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          call[index]["img"],
                        ),
                      )),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Image.network(
                    _call,
                    width: 28,
                  ),
                ),
              ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 20,
              ),
          itemCount: call.length),
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
