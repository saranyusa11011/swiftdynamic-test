import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  bottom: 0,
                  // top: 0,
                  // left: 0,
                  child: Container(
                      child: Image.asset('assets/images/bg_girl.jpg')),
                  width: size.width + 45,
                  height: size.height + 45,
                  // width: 200,
                  // height: 150,
                ),
                child
                //child
              ],
            )),
      ),
    );
  }
}

class HomepageBackground extends StatelessWidget {
  const HomepageBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  // bottom: 20,
                  // top: 0,
                  // left: 0,
                  child: Container(
                      child: Image.asset('assets/images/bg_flower.jpg')),
                  width: size.width + 45,
                  height: size.height + 45,
                  // width: 200,
                  // height: 150,
                ),
                child
                //child
              ],
            )),
      ),
    );
  }
}
