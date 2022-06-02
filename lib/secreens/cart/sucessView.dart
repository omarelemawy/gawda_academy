import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

class SucessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: height * 0.6,
                  width: width,
                  //color: Colors.red,

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/good.PNG'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                'Buying Succeeded',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.indigo.shade900,
                    fontFamily: 'Cairo-Bold'),
              ),
              Text(
                'Now Courses Display',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Cairo-Bold'),
              ),
              Container(
                width: width * 0.3,
                child: ElevatedButton(
                  onPressed: () => Wrapper(),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: 'Cairo-Bold'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
