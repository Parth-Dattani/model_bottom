import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';

class PaginationScreen extends GetView<PaginationController> {
  static const pageId = '/PaginationScreen';

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: const Text(
              "Pagination",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.arrow_back_ios_new),
            actions: [
              Row(
                children: [
                  ElevatedButton(onPressed: (){
                    showModalBottomSheet(
                      shape: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0))),
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child:
                          SizedBox(
                            height: 140,
                            child: Column(
                              children: const[
                                Text('Hello', textScaleFactor: 2),
                                Text('ABC',  textScaleFactor: 2),
                                Text('Hii',  textScaleFactor: 2),
                                Text('PD',  textScaleFactor: 2),
                              ],
                            ),
                          ))

                    );
                    /*Get.bottomSheet(
                    Container(
                        height: 150,
                        color: Colors.transparent,
                        child:Column(
                          children: [
                            Text('Hello', textScaleFactor: 2),
                            Text('ABC',  textScaleFactor: 2),
                            Text('Hii',  textScaleFactor: 2),
                            Text('PD',  textScaleFactor: 2),
                          ],
                        )
                    ),
                    barrierColor: Colors.red[50],
                    isDismissible: false,

                  );*/
                    }, child: Icon(Icons.abc_rounded)),
                  ElevatedButton(onPressed: (){
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: Get.height/3,
                            child: CupertinoActionSheet(title: Column
                              (mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children:const[Icon(Icons.connected_tv_sharp),Text("Live",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)],),
                                Row(children:const[Icon(Icons.insert_link_outlined),Text("Share",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)],),
                                Row(children:const[Icon(Icons.location_on_rounded),Text("Map",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)],),
                                Row(children:const[Icon(Icons.add_alert_rounded),Text("Alert",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)],),
                                Row(children:const[Icon(Icons.sync),Text("Reload",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)],),
                              ],
                            ),),
                          );
                        },
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(122)
                      )
                        );
                  },
                      child: const Icon(Icons.confirmation_number_sharp))
                ],
              )
            ],
          ),
          body:  Column(
                  children: [
                    const Center(
                        child: Text(
                      "data",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    )),
                    controller.listOfData.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        :

                    Expanded(child:

                    listData() )
                  ],
                ),
        ));
  }

  Widget listData() {
    return ListView.builder(
      shrinkWrap: true,
      physics:const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics()),
      itemCount: controller.listOfData.length,
      controller: controller.scrollController,
      itemBuilder: (context, index) => Card(
        elevation: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        controller.listOfData[index].sectionTitle.toString(),
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        controller.listOfData[index].firstName.toString(),
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            controller.isPaginateData.value && index == controller.listOfData.length-1 ?
            const CircularProgressIndicator():Container()
          ],
        ),
      ),

    );
  }
}
