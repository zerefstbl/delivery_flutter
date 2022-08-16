import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_test/screens/new_delivery_screen.dart';

class NotaWidget extends StatelessWidget {
  late final Map? data;
  NotaWidget(this.data);
  @override

  late final DateTime? date = DateTime.tryParse(data!['created_at']);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 130,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff62626262),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        'http://192.168.42.241:8000${data!['nota_fiscal'].toString()}'
                    )
                )
            ),
            height: 110,
            width: 70,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                  data!['username'],
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                  DateFormat.yMd().format(date!).toString(),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  data!['entregue'] ? Icon(Icons.check_circle_outline, color: Colors.green)
                      :
                  Icon(Icons.not_interested_outlined, color: Colors.red),
                  SizedBox(width: 10,),
                  Text(data!['entregue'] ? 'Entregue' : 'Não foi entregue'),
                ],
              ),
              SizedBox(height: 8),
              data!['estrela'] ? Icon(Icons.star, color: Colors.yellow) :
                  Icon(Icons.request_page, color: Colors.blueAccent)
            ],
          )
        ],
      )
    );
  }
}

// backgroundImage: NetworkImage(
// 'http://192.168.42.241:8000${data!['nota_fiscal'].toString()}'
// ),