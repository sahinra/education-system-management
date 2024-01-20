import db_connection


@db_connection.handle_connection
def get_all_courses(cursor):
    cursor.execute("""
        SELECT * FROM courses
    """)
    result = cursor.fetchall()
    return result


@db_connection.handle_connection
def get_all_subjects_details_by_student_id(cursor, student_id):
    cursor.execute(f"""
        SELECT s.student_id, cr.course_id, cr.title as course_title, sb.subject_id, sb.title as subject_title, 
            t.teacher_id, t.teacher_name, t.teacher_surname
        FROM students s
        JOIN student_groups sg ON s.group_id = sg.group_id
        JOIN groups_courses_lookup gcl ON sg.group_id = gcl.group_id
        JOIN courses cr ON gcl.course_id = cr.course_id
        JOIN subjects sb ON cr.subject_id = sb.subject_id
        JOIN teachers t ON sb.subject_id = t.subject_id AND sg.group_id = t.group_id
        WHERE s.student_id = {student_id};
    """)
    result = cursor.fetchall()
    return result


@db_connection.handle_connection
def get_all_students_by_teacher_id(cursor, teacher_id):
    cursor.execute(f"""
        select t.teacher_id, t.teacher_name, t.teacher_surname, sg.group_name, s.student_id, 
        s.student_name, s.student_surname from teachers t
        JOIN teachers_groups_lookup tgl ON tgl.teacher_id = t.teacher_id
        join student_groups sg on sg.group_id = tgl.group_id
        join students s on s.group_id = sg.group_id
        where t.teacher_id = {teacher_id}
    """)
    result = cursor.fetchall()
    return result


@db_connection.handle_connection
def get_all_exams_by_student_id(cursor, student_id):
    cursor.execute(f"""
        select er.student_id, s.student_name, er.exam_id, er.result_status
        from exam_results er
        join students s on s.student_id = er.student_id
        where s.student_id = {student_id};
    """)
    result = cursor.fetchall()
    return result


@db_connection.handle_connection
def add_exams_by_teacher_id(cursor, title, teacher_id):
    cursor.execute(f"""
        insert into exams (title, exam_date, created_on, created_by, is_active)
        values ('{title}', '2024-05-15 10:30:00', CURRENT_TIMESTAMP, 'Teacher{teacher_id}', true) returning exam_id
    """)
    result = cursor.fetchall()
    return result