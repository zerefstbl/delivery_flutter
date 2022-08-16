import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_test/screens/new_delivery_screen.dart';
import 'dart:async';
import 'package:image_test/widgets/nota_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late final List data;

  Future<Map> listAllTask() async {
    var url = Uri.parse('http://192.168.42.241:8000/list');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xff62626262),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 80,
          child: Stack(
            children: [
              CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 80),
                  painter: BNBCustomPainter()
              ),
              Center(
                heightFactor: 0.6,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewDeliveryScreen()
                    ));
                  },
                  backgroundColor: Colors.black,
                  child: Icon(Icons.add_circle_outline, size: 33),
                  elevation: 0.1
                  ,
                ),
              ),
              Container(
                width: size.width,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home, size: 31, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delivery_dining_rounded, size: 31, color: Colors.white),
                      onPressed: () {},
                    ),
                    Container(width: size.width * 0.2,),
                    IconButton(
                      icon: Icon(Icons.bookmark, size: 31, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications, size: 31, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder<Map>(
              future: listAllTask(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  print(snapshot.data!);
                  return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!['data'].length,
                        itemBuilder: (context, index) {
                          print(snapshot.data!['data'][index]['nota_fiscal']);
                          return NotaWidget(snapshot.data!['data'][index]);
                        },
                      )
                  );
                }
                return Center(child: CircularProgressIndicator());
              }
          ),
        ],
      )
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff317371)..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width *0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}

