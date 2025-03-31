# app.py
from flask import Flask
from mysql.connector import connect, Error
import os

app = Flask(__name__)

# Load environment variables
DB_HOST = os.getenv("DB_HOST", "db")
DB_USER = os.getenv("DB_USER", "todo_user")
DB_PASSWORD = os.getenv("DB_PASSWORD", "securepassword123")
DB_NAME = os.getenv("DB_NAME", "todo_app")

def create_tables():
    try:
        conn = connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS todos (
                id INT AUTO_INCREMENT PRIMARY KEY,
                task TEXT
            )
        """)
        conn.commit()
    except Error as e:
        print(f"Database error: {e}")
        raise

@app.route('/api/todos')
def get_todos():
    try:
        conn = connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM todos")
        return {"todos": cursor.fetchall()}
    except Error as e:
        return {"error": str(e)}, 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

if __name__ == '__main__':
    create_tables()  # Initialize tables
    app.run(host='0.0.0.0', port=5000)