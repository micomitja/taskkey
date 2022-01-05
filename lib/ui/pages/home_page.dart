import 'dart:async';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskkey/controllers/task_controller.dart';
import 'package:taskkey/models/task.dart';
import 'package:taskkey/ui/pages/add_task_page.dart';
import 'package:taskkey/ui/size_config.dart';
import 'package:taskkey/ui/theme.dart';
import 'package:taskkey/ui/widgets/button.dart';
import 'package:intl/intl.dart';
import 'package:taskkey/ui/widgets/task_tile.dart';

import '../../services/theme_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString()); //prikaz datuma
  final _taskController = Get.put(TaskController());
  bool animate=false;
  double left=630;
  double top=900;
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(milliseconds: 500), () {
      setState(() {
        animate=true;
        left=30;
        top=top/3;
      });
    });
  }

  /// deklariramo zadeve
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor, // kliče tist z classa Theme za bg color
      body: Column(
        children: [
          _addTaskBar(),
          _dateBar(),
          SizedBox(
            height: 12,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  /// date bar gor na vrhu pagea
  _dateBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20), //margin na robih ko drugač je trash
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        child: DatePicker(
          DateTime.now(),
          height: 100.0,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryClr,
          //selectedTextColor: primaryClr,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 10.0,
              color: Colors.grey,
            ),
          ),

          onDateChange: (date) {
            // New date selected

            setState(
              () {
                _selectedDate = date; //zbere mi tist date v pickerju ko je današji
              },
            );
          },
        ),
      ),
    );
  }

  /// pasica z datumom pa gumbom add taska
  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()), // date format plugin
                style: subHeadingTextStyle,
              ),
              SizedBox(height: 10,),
              Text(
                "Today",
                style: headingTextStyle,
              ),
            ],
          ),
          MyButton(
            label: "+ Add NEW Task",
            onTap: () async { // še asyncamo da se posodobi tasklist
              await Get.to(AddTaskPage()); //go to other page šele ko returna to zato mamo awati da se
              _taskController.getTasks(); //še geta ven z get task zadeve
            },
          ),
        ],
      ),
    );
  }

  ///personaliziran app bar z ikonco Sonce Luna
  _appBar() {
    return AppBar(
        elevation: 0, // da nimam une sence pod app barom
        backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector( //leading da na levo stran zadeve
          onTap: () {
            ThemeService().switchTheme(); //kličemoo spremembo teme
            print("change theme");
          },
          child: Icon(
            // prikaz ikone glede na to kere theme mode mamo užgan.
              Get.isDarkMode ? FlutterIcons.sun_fea : FlutterIcons.moon_fea,
              color: Get.isDarkMode ? Colors.white : darkGreyClr),
        ),
    );
  }

  /// dell kjer prikazujemo vse te taske
  _showTasks() {
    return Expanded( // returna Widget
      child: Obx(() { // zato ko mamo observable variables
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else
          return ListView.builder( //zbildamo return list, tuki returna list view
              scrollDirection: Axis.vertical,
              itemCount: _taskController.taskList.length, //določimo šte itemov hočmo ven dobit dobir info z TaskList ko mamo not to vse
              itemBuilder: (context, index) { // pol pa buildamo ven
                Task task = _taskController.taskList[index];

                if (task.date == DateFormat.yMd().format(_selectedDate)) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  showBottomSheet(context, task);
                                },
                                // Klicemo Task Tile da mi doda task v box pa da ga prikaže
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(); //returnamo container
                }
              });
      }),
    );
  }

  /// project bottom sheet
  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? SizeConfig.screenHeight * 0.24
            : SizeConfig.screenHeight * 0.32,
        width: SizeConfig.screenWidth,
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          Spacer(),
          task.isCompleted == 1 // če je completed pol sam Container sam prazn container pol ga lahkka sam brišemo ven
              ? Container() //prazn container
              : _buildBottomSheetButton(  // čene pa damo task completed gumb še zravn
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id);
                    Get.back();
                  },
                  clr: primaryClr),
          _buildBottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.deleteTask(task);
                Get.back();
              },
              clr: Colors.red[300]),
          SizedBox(
            height: 20,
          ),
          _buildBottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              isClose: true),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  /// buildamo gumbe za bottom sheet za spodn seznam
  _buildBottomSheetButton({
    String label,
    Function onTap,
    Color clr,
    bool isClose = false
  }) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: SizeConfig.screenWidth * 0.9, //90% width
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose // to pogledamo za kerga delamo gumb če je ta gumb je ta gumb glede na barvo backgrounda
                ? Get.isDarkMode  // border je druge barve
                    ? Colors.grey[600]
                    : Colors.grey[300]
                : clr, //čene je pa clr barvo ko jo pošlemo nastavmo
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style: isClose
              ? titleTextStle
              : titleTextStle.copyWith(color: Colors.white), // beu border
        )),
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children:[ AnimatedPositioned(
        duration: Duration(milliseconds: 2000),
        left: left,
        top:top,
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                 Icons.list,
                 color: primaryClr,
                 size: 90.0,
                 semanticLabel: 'Text to For icon List',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "You don't have any tasks yet!\nAdd new tasks to be more productive.",
                  textAlign: TextAlign.center,
                  style: subTitleTextStle,
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          )
        ),
      )],
    );
  }
}
