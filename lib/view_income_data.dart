import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ShowTextDialog.dart';
import 'UserData.dart';
import 'Utils.dart';
import 'home.dart';
import 'package:project_1/data/incomeData.dart' as incomeData;

import 'scrollable_widget.dart';

// https://medium.com/swlh/the-simplest-way-to-pass-and-fetch-data-between-stateful-and-stateless-widgets-pages-full-2021-c5dbce8db1db
class ViewIncomeData extends StatefulWidget {
  @override
  _ViewIncomeDataState createState() => _ViewIncomeDataState();
}

class _ViewIncomeDataState extends State<ViewIncomeData> {
  late List<UserData> datas;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    this.datas = List.of(incomeData.allIncome);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset : false,
    backgroundColor: Colors.grey[900],
    appBar: AppBar(
      title: Text("Manage/View Income Data"),
      backgroundColor: Colors.grey[850],
      centerTitle: true,
      elevation: 0.0,
    ),
    body: ScrollableWidget(
      child:
      Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.white,
            textTheme:
            Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
            ),
            iconTheme:
              Theme.of(context).iconTheme.copyWith(
                color: Colors.white,
              ),
          ),
          child: buildDataTable()),
    ),
  );

  Widget buildDataTable() {
    final columns = ['Date', 'Amount', 'Category'];


    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(datas),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {

      return DataColumn(
        label: Text(column),
        onSort: onSort,
      );
    }).toList();
  }

  List<DataRow> getRows(List<UserData> datas) => datas.map((UserData data) {
    final cells = [data.date, data.amount, data.category];

    return DataRow(
      cells: Utils.modelBuilder(cells, (index, cell) {
        final showEditIcon = index == 1 || index == 2;

        return DataCell(
          Text('$cell'),
          showEditIcon: showEditIcon,
          onTap: () {
            switch (index) {
              case 1:
                editAmount(data);
                break;
              case 2:
                editCategory(data);
                break;
            }
          },
        );
      }),
    );
  }).toList();

  Future editAmount(UserData editData) async {
    final amount = await showTextDialog(
      context,
      title: 'Change Amount',
      value: editData.amount,
    );

    setState(() => datas = datas.map((data) {
      final isEditedUser = data == editData;

      return isEditedUser ? data.copy(amount: amount) : data;
    }).toList());
  }

  Future editCategory(UserData editData) async {
    final category = await showTextDialog(
      context,
      title: 'Change Category',
      value: editData.category,
    );

    setState(() => datas = datas.map((data) {
      final isEditedUser = data == editData;

      return isEditedUser ? data.copy(category: category) : data;
    }).toList());
  }
  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      datas.sort((data1, data2) =>
          compareString(ascending, data1.date, data2.date));
    } else if (columnIndex == 1) {
      datas.sort((data1, data2) =>
          compareString(ascending, data1.amount, data2.amount));
    } else if (columnIndex == 2) {
      datas.sort((data1, data2) =>
          compareString(ascending, '${data1.category}', '${data2.category}'));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}