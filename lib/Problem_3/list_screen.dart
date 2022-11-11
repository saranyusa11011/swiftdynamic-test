import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:swift_test/Problem_3/edit_information.dart';
import 'package:swift_test/background.dart';
import 'package:swift_test/model/model_information.dart';

import '../colors.dart';
import '../provider/provider_information.dart';
import '../widget/app_icon.dart';
import '../widget/big_text.dart';
import 'detail_information.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<InformationProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: HomepageBackground(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                height: 80,
                width: 1000,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
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
                            "Information",
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
              SizedBox(
                height: 10,
              ),
              StreamBuilder<List<Information>>(
                stream: prov.getInformations(),
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
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      motion: StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: ((context) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditInformation(
                                                          data: snapshot
                                                              .data![index])),
                                            );
                                            // _showMyDialog('${snapshot.data![index].unit}',
                                            //     '${snapshot.data![index].stockName}');
                                          }),
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.greenAccent,
                                          icon: Icons.edit,
                                        ),
                                        SlidableAction(
                                          onPressed: ((context) {
                                            DeleteAwesome(
                                              snapshot.data![index].name,
                                              snapshot.data![index].id,
                                            );
                                          }),
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete,
                                        )
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailInformation(
                                                            data: snapshot
                                                                .data![index])),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0)),
                                                      color: Colors.white38,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              '${snapshot.data?[index].img}'))),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    // width: 200,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20)),
                                                        color: Colors.white),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          BigText(
                                                              text:
                                                                  "${snapshot.data?[index].name}"),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          BigText(
                                                            color: Color(
                                                                0xFFccc7c5),
                                                            // size: 12,
                                                            text:
                                                                "${snapshot.data?[index].IdNumber}",
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // Divider(
                                          //   color: Colors.black12,
                                          //   thickness: 3,
                                          // ),
                                        ],
                                      ),
                                    ),
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
            Navigator.pushNamed(context, '/information/add');
          },
          backgroundColor: AppColors.mainColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<AwesomeDialog> DeleteAwesome(String title, String id) async =>
      AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.rightSlide,
        title: 'Do you want to delete $title?',
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Provider.of<InformationProvider>(context, listen: false)
              .deleteInformation(id: id)
              .then((value) => AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'Delete Success!',
                  autoHide: Duration(seconds: 2))
                ..show());
        },
      )..show();
}
