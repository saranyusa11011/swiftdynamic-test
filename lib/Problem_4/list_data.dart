import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_test/model/model_stepper.dart';
import 'package:swift_test/provider/provider_stepper.dart';

import '../colors.dart';
import '../widget/app_icon.dart';

class Problem4 extends StatelessWidget {
  const Problem4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<StepperProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                height: 80,
                width: 1000,
                decoration: BoxDecoration(
                  // color: Colors.orange.withOpacity(0.7),
                  color: AppColors.mainColor,
                  // borderRadius: const BorderRadius.only(
                  //     bottomLeft: Radius.circular(20),
                  //     bottomRight: Radius.circular(20))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      child: IconButton(
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName("/"));
                        },
                        icon: const AppIcon(icon: Icons.arrow_back_ios),
                      ),
                    ),
                    Column(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 0, top: 30),
                          child: Text(
                            "Stepper data",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // IconButton(
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, '/todolist/history');
                    //     },
                    //     icon: Icon(
                    //       Icons.history,
                    //       color: Colors.white,
                    //     ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<List<StepperModel>>(
                stream: prov.getSteppers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Column(
                        children: [
                          Flexible(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Container(
                                      // margin: const EdgeInsets.all(15.0),
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.white12)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Name : ${snapshot.data![index].name}"),
                                          Text(
                                              "Age : ${snapshot.data![index].age.toString()}"),
                                          Text(
                                              "Phone : ${snapshot.data![index].phone}"),
                                          Text(
                                              "ID Card number : ${snapshot.data![index].IdNumber}"),
                                          Text(
                                              "Address : ${snapshot.data![index].address}"),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                    // trailing: Text(data.Id),
                                  );
                                }),
                          )
                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/stepper/add');
          },
          backgroundColor: AppColors.mainColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
