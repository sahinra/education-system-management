import data_manager
import flask

app = flask.Flask(__name__)


@app.route("/", methods=["GET"])
def get_all_courses():
    result = data_manager.get_all_courses()
    return flask.jsonify(result), 200


# User (student) can see all the subjects on the course they are enrolled on, along with who teaches them.
# Ex: id = 3
@app.route("/students/<int:id>/subjects_details", methods=["GET"])
def get_all_subjects_details_by_student_id(id):
    result = data_manager.get_all_subjects_details_by_student_id(id)
    return flask.jsonify(result), 200


# User (student) can see their exams (upcoming, failed, passed).
# Ex: id = 1
@app.route("/students/<int:id>/exams", methods=["GET"])
def get_all_exams_by_student_id(id):
    result = data_manager.get_all_exams_by_student_id(id)
    return result


# User (teacher) can see all the students they teach.
# Ex: id = 1
@app.route("/teachers/<int:id>/students", methods=["GET"])
def get_all_students_by_teacher_id(id):
    result = data_manager.get_all_students_by_teacher_id(id)
    return flask.jsonify(result), 200


# User (teacher) can add exams and assign subjects to them. The status of an exam can be changed.
@app.route("/teachers/exams", methods=["POST"])
def add_exams_by_teacher_id():
    title = flask.request.get_json()["title"]
    id = flask.request.get_json()["teacher_id"]
    result = data_manager.add_exams_by_teacher_id(title, id)
    return 201


# @app.route("/teachers/<int:id>/exams", methods=["PUT"])
# def edit_exam_status_by_teacher_id(id):
#     result = data_manager.edit_exam_status_by_teacher_id(id)
#     return result


# User (administrator) can add courses and assign subjects to them.
# User (administrator) can add students, student groups, teachers, subjects, and make the connections between them.


if __name__ == "__main__":
    app.run(debug=True)