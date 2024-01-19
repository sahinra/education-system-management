import psycopg2
import os
from psycopg2 import extras


def make_connection():
    try:
        conn = psycopg2.connect(
            database=os.environ.get("PSQL_DB_NAME"),
            user=os.environ.get("PSQL_USER"),
            password=os.environ.get("PSQL_PASSWORD"),
            port=os.environ.get("PSQL_PORT"),
            host=os.environ.get("PSQL_HOST")
        )
    except psycopg2.DatabaseError as ex:
        print("Connection error occurred.")
        raise ex
    conn.autocommit = True
    return conn


def handle_connection(func_to_execute):
    def wrapper(*arg, **kwargs):
        with make_connection() as connection:
            with connection.cursor(cursor_factory=extras.RealDictCursor) as cursor:
                query_result = func_to_execute(cursor, *arg, **kwargs)
                for item in query_result:
                    print("-" * 50)
                    for key, value in item.items():
                        print(f"{key}: {value}")
                return query_result
    return wrapper