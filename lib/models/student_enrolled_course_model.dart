// To parse this JSON data, do
//
//     final studentEnrolledCourse = studentEnrolledCourseFromJson(jsonString);



List<StudentEnrolledCourse> studentEnrolledCourseFromJson(List<dynamic> str) =>
    List<StudentEnrolledCourse>.from(
        (str).map((x) => StudentEnrolledCourse.fromJson(x)));

class StudentEnrolledCourse {
  StudentEnrolledCourse({
    required this.id,
    required this.mcqMarks,
    required this.tfMarks,
    required this.theoryMarks,
     this.file,
    required this.status,
    required this.pstatus,
    required this.total,
    required this.paperId,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
    required this.session,
    required this.time,
  });

  int id;
  String mcqMarks;
  String tfMarks;
  String theoryMarks;
  dynamic file;
  String status;
  String pstatus;
  String total;
  String paperId;
  String studentId;
  DateTime createdAt;
  DateTime updatedAt;
  Subject subject;
  Session session;
  String time;

  factory StudentEnrolledCourse.fromJson(Map<String, dynamic> json) =>
      StudentEnrolledCourse(
        id: json["id"],
        mcqMarks: json["mcq_marks"],
        tfMarks: json["tf_marks"],
        theoryMarks: json["theory_marks"],
        file: json["file"],
        status: json["status"],
        pstatus: json["pstatus"],
        total: json["total"],
        paperId: json["paper_id"],
        studentId: json["student_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subject: Subject.fromJson(json["subject"]),
        session: Session.fromJson(json["session"]),
        time: json["time"],
      );
}

class Session {
  Session({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class Subject {
  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.sessionId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String code;
  String sessionId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        sessionId: json["session_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
