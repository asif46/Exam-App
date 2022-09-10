import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/controllers/repository.dart';
import 'package:untitled/controllers/session_controller.dart';
import 'package:untitled/models/subjects_model.dart';
import 'package:untitled/repository/repository_class.dart';
import 'package:untitled/screens/teacher/manage_result.dart';

class ResultPart1 extends StatefulWidget {
  const ResultPart1({
    Key? key,
  }) : super(key: key);

  @override
  _ResultPart1State createState() => _ResultPart1State();
}

class _ResultPart1State extends State<ResultPart1> {
  String subject = "Subject",
      paper_type = "MCQ",
      session = "Session",
      subj = "",
      session_id = "",
      subjectId = "";
  final SessionController _sessionController = Get.put(SessionController());
  List<Subjects> _subjectController = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kDefaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    openSessionAlert();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(
                        0x11304ffe,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(session),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    if (session_id == '') {
                      ExamRepo.showSnack(context, "Select Semester First");
                    } else {
                      openSubjectAlert();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(
                        0x11304ffe,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(subject),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: kGreenColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    if (session_id == '' || subjectId == '') {
                      ExamRepo.showSnack(
                          context, "Select semester and Subject First");
                    } else {
                      Get.off(() => ManageResult(),
                          arguments: [session_id, subjectId]);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  openSessionAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(top: 5.0),
            content: Container(
                height: 200.00,
                width: 300.00,
                margin: const EdgeInsets.only(
                    bottom: 0, left: 25, right: 25, top: 25),
                child: Obx(() {
                  if (_sessionController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: _sessionController.sessionsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              session =
                                  _sessionController.sessionsList[index].name;
                              session_id = _sessionController
                                  .sessionsList[index].id
                                  .toString();
                            });
                            Navigator.of(context).pop();
                          },
                          child: ListTile(
                            title: Text(
                                _sessionController.sessionsList[index].name),
                          ));
                    },
                  );
                })),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                    child: Text(
                      'Cancel',
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          );
        });
  }

  openSubjectAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(top: 5.0),
            content: Container(
                height: 200.00,
                width: 300.00,
                margin: const EdgeInsets.only(
                    bottom: 0, left: 25, right: 25, top: 25),
                child: FutureBuilder<Subjects>(
                  future: Repository.getSubjects(session_id),
                  builder: (BuildContext context, snapshot) {
                    // AsyncSnapshot<Your object type>
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Please wait its loading...'));
                    } else {
                      if (snapshot.hasError)
                        return Center(child: Text('Error: ${snapshot.error}'));
                      else
                        return ListView.builder(
                            itemCount: snapshot.data!.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      subject = snapshot.data!.data[index].name;
                                      subjectId = snapshot.data!.data[index].id
                                          .toString();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data!.data[index].name),
                                  ));
                            }); // snapshot.data  :- get your object which is pass from your downloadData() function
                    }
                  },
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                    child: Text(
                      'Cancel',
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          );
        });
  }
}
