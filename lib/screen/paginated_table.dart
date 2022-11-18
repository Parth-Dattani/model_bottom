import 'dart:math';

import 'package:flutter/material.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/screen/pagination_screen/pagination_screen.dart';
class PaginatedTable extends StatefulWidget {
  const PaginatedTable({Key? key}) : super(key: key);

  @override
  State<PaginatedTable> createState() => _PaginatedTableState();
}

class _PaginatedTableState extends State<PaginatedTable> {


  final DataTableSource _data = MyData();
  String? _selectedAnimal;

  final List<String> _suggestions = [
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Frog'
  ];

  bool _isShown = true;
  int _currentSortColumn = 0;
  bool _isAscending = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginationScreen(),
                  ));
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text('Paginated Table'),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue value) {
                  // When the field is empty
                  if (value.text.isEmpty) {
                    return [];
                  }
                  //create a model class
                  //create DB helper class
                  //initDB
                  //db.execute
                  //
                  // The logic to find out which ones should appear
                  return _suggestions.where((suggestion) => suggestion
                      .toLowerCase()
                      .contains(value.text.toLowerCase()));
                },
                onSelected: (value) {
                  setState(() {
                    _selectedAnimal = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(_selectedAnimal ?? 'Type something (a, b, c, etc)'),
            const SizedBox(
              height: 1,
            ),
            Visibility(
              visible: _isShown,
              child: PaginatedDataTable(
                sortColumnIndex: _currentSortColumn,
                sortAscending: _isAscending,

                source: _data,
                header: const Text(
                  'My Data',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
                columns:
                const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Price',),

                  )
                ],
                columnSpacing: 150,
                horizontalMargin: 10,
                rowsPerPage: 10,
                showCheckboxColumn: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: !_isShown,
                child: Container(
                  height: 250,
                  width: 230,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(103),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        tileMode: TileMode.mirror,
                        colors: [
                          Colors.red,
                          Colors.green,
                          Colors.orange,
                          Colors.purple,
                          Colors.blue,
                          Colors.pinkAccent,
                          Colors.green,
                        ],
                      )
                  ),

                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            _isShown ? TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaginationScreen(),
                      )
                  );
                },
                child: Text("Go to Home Page")) :
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaginationScreen(),
                      )
                  );
                },
                child: Text("Go to Image Carousel")),

          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isShown = !_isShown;
          });
        },
        child: Text(
          _isShown ? 'Hide' : 'Show',
        ),
      ),
    );
  }
}


class MyData extends DataTableSource {
  final PaginationController  controller = PaginationController();
  final List<Map<String, dynamic>> _data = List.generate(
      200,
          (index) => {
        "id": index + 1,
        "title": "Item $index",
        "price": Random().nextInt(10000)
      });

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.listOfData.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(controller.listOfData[index].id.toString())),
      DataCell(Text(controller.listOfData[index].firstName.toString())),
      DataCell(Text(controller.listOfData[index].lastName.toString())),
    ]);
  }
}
