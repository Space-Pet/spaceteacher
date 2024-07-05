class Parent {
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
  int userId;
  ParentPupil pupil;

  Parent({
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
    required this.userId,
    required this.pupil,
  });

  factory Parent.fromMap(Map<String, dynamic> map) {
    return Parent(
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
      userId: map['user_id'],
      pupil: ParentPupil.fromMap(map['pupil']),
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
      'user_id': userId,
      'pupil': pupil,
    };
  }

  factory Parent.empty() {
    return Parent(
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
      userId: 0,
      pupil: ParentPupil.empty(),
    );
  }

  static List<Parent> fakeData() => List.generate(
      10,
      (index) => Parent(
            parentId: index,
            fatherName: 'Father Name $index',
            fatherYear: 'Father Year $index',
            fatherPhone: 'Father Phone $index',
            fatherMobilePhone: 'Father Mobile Phone $index',
            fatherAddress: 'Father Address $index',
            fatherJob: 'Father Job $index',
            fatherJobTitle: 'Father Job Title $index',
            fatherWorkAddress: 'Father Work Address $index',
            fatherEmail: 'Father Email $index',
            motherName: 'Mother Name $index',
            motherYear: 'Mother Year $index',
            motherPhone: 'Mother Phone $index',
            motherMobilePhone: 'Mother Mobile Phone $index',
            motherAddress: 'Mother Address $index',
            motherJob: 'Mother Job $index',
            motherJobTitle: 'Mother Job Title $index',
            motherWorkAddress: 'Mother Work Address $index',
            motherEmail: 'Mother Email $index',
            userId: index,
            pupil: ParentPupil.fakeData(),
          ));
}

class ParentPupil {
  int pupilId;
  String fullName;

  ParentPupil({
    required this.pupilId,
    required this.fullName,
  });

  factory ParentPupil.fromMap(Map<String, dynamic> map) {
    return ParentPupil(
      pupilId: map['pupil_id'],
      fullName: map['full_name'],
    );
  }

  factory ParentPupil.empty() {
    return ParentPupil(
      pupilId: 0,
      fullName: '',
    );
  }

  factory ParentPupil.fakeData() {
    return ParentPupil(
      pupilId: 0,
      fullName: 'Full Name',
    );
  }
}
