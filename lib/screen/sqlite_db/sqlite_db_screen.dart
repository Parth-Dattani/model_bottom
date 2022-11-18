import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/model/model.dart';
import 'package:model_bottom/screen/screen.dart';

class SqliteDbScreen extends GetView<SqliteDbController>{
  static const pageId = '/SqliteDbScreen';
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       Scaffold(
        appBar: AppBar(title: const Text("SQFlite"),
        actions: [
          IconButton(onPressed: (){Get.toNamed(TypesAhesScreen.pageId);}, icon: const Icon(Icons.content_paste_sharp))
        ],
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  hintText:  "something write"
                ),
              ),

              Row(
                children: [
                  ElevatedButton(onPressed: (){
                    if(controller.titleController.text.isNotEmpty){
                      controller.addData(DataModel(
                        id: null,
                        title: controller.titleController.text
                      ));
                      controller.clearController();
                    }
                  }, child: const Text("Add")),
                  const SizedBox(width: 10,),

                  ElevatedButton(onPressed: (){
                    if(controller.titleController.text.isNotEmpty){
                      controller.updateData(DataModel(
                          id: controller.dataId,
                          title: controller.titleController.text
                      ));
                      controller.clearController();
                    }
                  }, child: const Text("Update")),
                ],
              ),

          Row(
            children: const[
              Text("No."),
            SizedBox(width: 25,),
            Text("Title"),
              SizedBox(width: 25,),

            ],

          ),

              Expanded(child:
              controller.listOfData.value.isEmpty ? const Center(child: CircularProgressIndicator()):
              ListView.builder( itemCount: controller.listOfData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    controller.dataId =controller.listOfData[index].id;
                    print("DataId: ${ controller.dataId}");
                    controller.titleController.text = controller.listOfData[index].title.toString();
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(controller.listOfData[index].title.toString()),
                          ),
                        ),
                        // IconButton(onPressed: (){
                        //   controller.updateData(
                        //     DataModel(
                        //       title: controller.titleController.text
                        //     )
                        //   );
                        // }, icon: Icon(Icons.edit),),

                        IconButton(onPressed: (){
                          controller.deleteData(controller.listOfData[index].id!);
                        }, icon: const Icon(Icons.delete),),
                      ],
                    ),
                  ),
                );
              },))
            ],
          ),
        ),
      ),
    );
  }

}