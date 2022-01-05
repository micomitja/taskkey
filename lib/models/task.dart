// Task model mamo zato da povemo kk submitat data v database torej strukturo pa format
// basiclyy how to get how to save data pa format.
class Task {
  int id;
  String title;
  String note;
  int isCompleted;
  String date;
  String startTime;
  String endTime;
  int color;

  ///konstruktor inicializacija vseh paratetrov je model za controler
  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
  });

  /// ko getaš z baze pa rabmo tak format da shramo value kot spremenljivko
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
  }

  /// transform to JSON format, podamo data kot json format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    return data;
  }
}
