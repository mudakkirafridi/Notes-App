class NotesModel {
  int? id;
  String? title;
  String? description;

  NotesModel( this.title, this.description, [this.id]);

  NotesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, Object?> toJson() {
   return {
    'id': id,
    "title": title,
    'description': description
   };
  }
}