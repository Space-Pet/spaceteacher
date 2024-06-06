import 'models.dart';

class ParentData {
  Parents parents;
  List<Job> jobs;
  List<Children> children;
  int pushNotify;

  ParentData({
    required this.parents,
    required this.jobs,
    required this.children,
    required this.pushNotify,
  });

  factory ParentData.fromMap(Map<String, dynamic> map) {
    final childrenData = map['children'];

    final children = childrenData is List
        ? childrenData
            .map((e) => Children.fromMap(e as Map<String, dynamic>))
            .toList()
        : [Children.fromMap(childrenData as Map<String, dynamic>)];

    return ParentData(
      parents: Parents.fromMap(map['parents']),
      jobs: List<Job>.from(map['jobs'].map((x) => Job.fromMap(x))),
      children: children,
      pushNotify: map['push_notify'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'parents': parents.toMap(),
      'jobs': List<dynamic>.from(jobs.map((x) => x.toMap())),
      'children': List<dynamic>.from(children.map((x) => x.toMap())),
      'push_notify': pushNotify,
    };
  }

  factory ParentData.empty() {
    return ParentData(
      parents: Parents.empty(),
      jobs: [],
      children: [],
      pushNotify: 0,
    );
  }
}

class Parents {
  int parentId;
  String fatherName;
  String fatherYear;
  String fatherPhone;
  String fatherMobilePhone;
  String fatherAddress;
  String fatherJob;
  String fatherJobTitle;
  String fatherWorkAddress;
  String fatherEmail;
  String motherName;
  String motherYear;
  String motherPhone;
  String motherMobilePhone;
  String motherAddress;
  String motherJob;
  String motherJobTitle;
  String motherWorkAddress;
  String motherEmail;

  Parents({
    required this.parentId,
    required this.fatherName,
    required this.fatherYear,
    required this.fatherPhone,
    required this.fatherMobilePhone,
    required this.fatherAddress,
    required this.fatherJob,
    required this.fatherJobTitle,
    required this.fatherWorkAddress,
    required this.fatherEmail,
    required this.motherName,
    required this.motherYear,
    required this.motherPhone,
    required this.motherMobilePhone,
    required this.motherAddress,
    required this.motherJob,
    required this.motherJobTitle,
    required this.motherWorkAddress,
    required this.motherEmail,
  });

  factory Parents.fromMap(Map<String, dynamic> map) {
    return Parents(
      parentId: map['parent_id'],
      fatherName: map['father_name'],
      fatherYear: map['father_year'],
      fatherPhone: map['father_phone'],
      fatherMobilePhone: map['father_mobile_phone'],
      fatherAddress: map['father_address'],
      fatherJob: map['father_job'],
      fatherJobTitle: map['father_job_title'],
      fatherWorkAddress: map['father_work_address'],
      fatherEmail: map['father_email'],
      motherName: map['mother_name'],
      motherYear: map['mother_year'],
      motherPhone: map['mother_phone'],
      motherMobilePhone: map['mother_mobile_phone'],
      motherAddress: map['mother_address'],
      motherJob: map['mother_job'],
      motherJobTitle: map['mother_job_title'],
      motherWorkAddress: map['mother_work_address'],
      motherEmail: map['mother_email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'parent_id': parentId,
      'father_name': fatherName,
      'father_year': fatherYear,
      'father_phone': fatherPhone,
      'father_mobile_phone': fatherMobilePhone,
      'father_address': fatherAddress,
      'father_job': fatherJob,
      'father_job_title': fatherJobTitle,
      'father_work_address': fatherWorkAddress,
      'father_email': fatherEmail,
      'mother_name': motherName,
      'mother_year': motherYear,
      'mother_phone': motherPhone,
      'mother_mobile_phone': motherMobilePhone,
      'mother_address': motherAddress,
      'mother_job': motherJob,
      'mother_job_title': motherJobTitle,
      'mother_work_address': motherWorkAddress,
      'mother_email': motherEmail,
    };
  }

  factory Parents.empty() {
    return Parents(
      parentId: 0,
      fatherName: '',
      fatherYear: '',
      fatherPhone: '',
      fatherMobilePhone: '',
      fatherAddress: '',
      fatherJob: '',
      fatherJobTitle: '',
      fatherWorkAddress: '',
      fatherEmail: '',
      motherName: '',
      motherYear: '',
      motherPhone: '',
      motherMobilePhone: '',
      motherAddress: '',
      motherJob: '',
      motherJobTitle: '',
      motherWorkAddress: '',
      motherEmail: '',
    );
  }
}

class Job {
  int jobId;
  String jobName;

  Job({required this.jobId, required this.jobName});

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      jobId: map['job_id'],
      jobName: map['job_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'job_id': jobId,
      'job_name': jobName,
    };
  }
}
