import 'package:flutter/material.dart';
import '../models/Employee.dart';
import '../business/Services.dart';
import '../models/Task.dart';
import '../CustomDataTable.dart';
void main() {

  runApp(MyApp_ListBuilder());

}

class MyApp_ListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new main_ui(),
    );
  }
}
class main_ui extends StatefulWidget {
  //
  main_ui() : super();

  final String title = 'Flutter Data Table';

  @override
  main_uiState createState() => main_uiState();
}

class main_uiState extends State<main_ui> {
  List<Task> _employees;

  // controller for the First Name TextField we are going to create.
  TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _lastNameController;
  Employee _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getEmployees();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }


//  _createTable() {
//    _showProgress('Creating Table...');
//    Services.createTable().then((result) {
//      if ('success' == result) {
//        // Table is created successfully.
//
//        _showProgress(widget.title);
//      }
//    });
//  }


  // Now lets add an Employee
//  _addEmployee() {
//    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
//      print('Empty Fields');
//      return;
//    }
//    _showProgress('Adding Employee...');
//    Services.addEmployee(_firstNameController.text, _lastNameController.text)
//        .then((result) {
//      if ('success' == result) {
//        _getEmployees(); // Refresh the List after adding each employee...
//        _clearValues();
//      }
//    });
//  }

  _getEmployees() async {
    _showProgress('Loading Employees...');
    await Services.getEmployees().then((tasks) {
      setState(() {
        _employees = tasks;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${tasks.length}");
    });
  }
/*
  _updateEmployee(Employee employee) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    Services.updateEmployee(
        employee.id.toString(), _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(employee.id.toString()).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh after delete...
      }
    });
  }
*/
  // Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  _showValues(Employee employee) {
    _firstNameController.text = employee.firstName;
    _lastNameController.text = employee.lastName;
  }


  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(child: ListView.builder(
            itemBuilder: (_,int index) => cardForEachCase(this._employees[index]),
        ),),
        ),
      );

  }
    Card cardForEachCase(Task task){
    return new Card(
      child: new Container(
        padding: EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            new CircleAvatar(child: new Text(task.patient_name),),
            new Padding(padding: EdgeInsets.only(right: 10.0)),
            new Text(task.patient_name,style: TextStyle(fontSize: 20.0),)
          ],
        ),
      ),
    );

    }
  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
             // _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(child: SizedBox(height: 20,),),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        //  _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


