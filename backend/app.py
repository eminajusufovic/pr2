from flask import Flask, render_template, request, redirect, url_for, session, jsonify
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask(__name__, template_folder="templates")
app.secret_key = "tajni_kljuc"


app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:lozinka@postgres-container:5432/tododb'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(200), nullable=False)
    checked = db.Column(db.Boolean, default=False)


users = {
    "emina@gmail.com": "emina123"
}

# Health check endpoint za load balancer
@app.route("/health")
def health():
    try:
       
        db.session.execute('SELECT 1')
        return jsonify({"status": "healthy", "database": "connected"}), 200
    except Exception as e:
        return jsonify({"status": "unhealthy", "error": str(e)}), 500

@app.route("/")
def index():
    return redirect(url_for("login"))

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"]
        if email in users and users[email] == password:
            session["user"] = email
            return redirect(url_for("home"))
        else:
            return "Login failed"
    return render_template("login.html")

@app.route("/home", methods=["GET", "POST"])
def home():
    if "user" not in session:
        return redirect(url_for("login"))

    if request.method == "POST":
        todo_name = request.form["todo_name"]
        new_todo = Todo(name=todo_name)
        db.session.add(new_todo)
        db.session.commit()
        return redirect(url_for("home"))
    
    todos = Todo.query.all()
    return render_template("index.html", items=todos)

@app.route("/checked/<int:todo_id>", methods=["POST"])
def checked_todo(todo_id):
    todo = Todo.query.get(todo_id)
    if todo:
        todo.checked = not todo.checked
        db.session.commit()
    return redirect(url_for("home"))

@app.route("/delete/<int:todo_id>", methods=["POST"])
def delete_todo(todo_id):
    todo = Todo.query.get(todo_id)
    if todo:
        db.session.delete(todo)
        db.session.commit()
    return redirect(url_for("home"))

@app.route("/logout")
def logout():
    session.pop("user", None)
    return redirect(url_for("login"))

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(debug=True, host="0.0.0.0", port=5000)
