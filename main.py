from flask import render_template
from flask import Flask, request, jsonify
from util_db import insert_user, Database

app = Flask(__name__)
db = Database("database.db")

@app.route('/insert_user', methods=['GET', 'POST'])
def handle_insert_user():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        confirm_password = request.form['confirm-password']
        return insert_user(db.connect(), username, email, password)
    else:
        return render_template('signup.html')

if __name__ == "__main__":
    app.run(debug=True)