
class SubjectObject {
  final String name;
  final String id;

  const SubjectObject(this.id, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubjectObject &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return name;
  }
}
const subjectData = <SubjectObject>[
  SubjectObject('1', 'Mathematics'),
  SubjectObject('2', 'Physics'),
  SubjectObject('3', 'Chemistry'),
  SubjectObject('4', 'Organic Chemistry'),
  SubjectObject('5', 'Biology'),
  SubjectObject('6', 'Science'),
  SubjectObject('7', 'Spoken English'),
  SubjectObject('8', 'English'),
  SubjectObject('9', 'Hindi'),
  SubjectObject('10', 'Sanskrit'),
  SubjectObject('11', 'Social Studies'),
  SubjectObject('12', 'Geography'),
  SubjectObject('13', 'History'),
  SubjectObject('14', 'Civics'),
  SubjectObject('15', 'Computer Technology'),
  SubjectObject('16', 'C programming language'),
  SubjectObject('17', 'C++'),
  SubjectObject('18', 'Java'),
  SubjectObject('19', 'Python'),
  SubjectObject('20', 'DBMS'),
  SubjectObject('21', 'Botany'),
  SubjectObject('22', 'Zoology'),
];
