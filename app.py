from flask import Flask, render_template, request, redirect, url_for
import sqlite3
app = Flask(__name__)
def init_db():
    conn = sqlite3.connect('tasks.db')
    c = conn.cursor()
    c.execute('CREATE TABLE IF NOT EXISTS tasks (id INTEGER PRIMARY KEY, name TEXT)')
    conn.commit()
    conn.close()
@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        task = request.form['task']
        conn = sqlite3.connect('tasks.db')
        c = conn.cursor()
        c.execute('INSERT INTO tasks (name) VALUES (?)', (task,))
        conn.commit()
        conn.close()
        return redirect(url_for('index'))
    conn = sqlite3.connect('tasks.db')
    c = conn.cursor()
    c.execute('SELECT * FROM tasks')
    tasks = c.fetchall()
    conn.close()
    return render_template('index.html', tasks=tasks)
if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5000)