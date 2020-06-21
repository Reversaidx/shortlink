from flask import Flask, request, jsonify, render_template,redirect
from functions import put_link,get_link
import os

app = Flask(__name__)
@app.after_request
def add_headers(response):
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Headers'] =  "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With"
    response.headers['Access-Control-Allow-Methods']=  "POST, GET, PUT, DELETE, OPTIONS"
    return response


@app.route("/")
def hello():
    return render_template("index.html.j2")

@app.route("/create", methods=["POST"])
def create():
    fullUrl = request.form["fullurl"]
    return "https//"+os.environ['DOMAIN']+"/get?id="+put_link(fullUrl)

@app.route("/get")
def get():
    id = request.args.get('id', default='*', type=str)
    return redirect(get_link(id),code=301)

if __name__ == "__main__":
    try:
        os.environ['DOMAIN']
    except:
        os.environ['DOMAIN'] = "jetbrains.strace.pw"
    try:
        os.environ['DEBUG']
    except:
        os.environ['DEBUG'] = "false"
    os.environ['REGION'] = 'eu-central-1'
    app.run(debug=os.environ['DEBUG'], port=8080,host='0.0.0.0')