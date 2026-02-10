"""Minimal Flask app for App Runner example. Listens on port 5000."""
import os

from flask import Flask

app = Flask(__name__)


@app.route("/")
def index():
    return "App Runner example is running.\n", 200


@app.route("/health")
def health():
    return "ok\n", 200


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
