#!./venv/bin/python3

from flask import Flask
import os

app = Flask(__name__)


@app.route('/')
def hello():
    return 'Hello, World!'


if __name__ == "__main__":
    app.run(host="0.0.0.0")
