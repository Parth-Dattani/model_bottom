import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

class TypesAhesScreen extends GetView<TypesAhedController> {
  static const pageId = '/TypesAhesScreen';

  const TypesAhesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded)),
          title: Text(
            "Types Ahed Example ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
        TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
        controller: controller.typeAhedController,
          decoration: InputDecoration(border: OutlineInputBorder()),
          autofocus: true,
        ),
        suggestionsCallback: (pattern) async {
          return await controller.getSuggestions(pattern);
        },
            animationDuration: Duration(milliseconds: 20),
            getImmediateSuggestions: true,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              color: Colors.lightBlue[50]
            ),
        itemBuilder: ((context, itemData) {
          return ListTile(
            trailing: Icon(
                controller.iconList[controller.suggestionList.indexOf(
                    itemData)]),
            leading: Icon(controller.iconList[controller.suggestionList.indexOf(
                itemData)]),
            //leading: Icon(controller.icons[controller.items.indexOf(suggestion)]),
            title: Text(itemData),

          );
        }),
        onSuggestionSelected: (suggestion) {
          controller.typeAhedController.text = suggestion;
        }),

    // Autocomplete(
    // optionsBuilder: (TextEditingValue textEditingValue) {
    //     if(textEditingValue.text == ''){
    //       return Iterable<String>.empty();
    //     }else{
    //       List<String> matches = <String>[];
    //       matches.addAll(textEditingValue.text);
    //     }
    // }
    // )
         //   ,
    Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }else{
          List<String> matches = <String>[];
          matches.addAll(controller.suggestionList);

          matches.retainWhere((s){
            return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
          return matches;
        }
      },
      onSelected: (String selection) {
        print('selected $selection');
      },
    )
    ],
    ),
    );
    }
}
