import os
import collections
import collections.abc
collections.MutableMapping = collections.abc.MutableMapping

from flask import Flask, render_template, jsonify, request
from flask_socketio import SocketIO, emit
import random, time, threading

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key'
socketio = SocketIO(app, async_mode="eventlet")

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/api/metrics")
def metrics():
    return jsonify({
        "cpu_usage": random.uniform(0, 100),
        "memory_usage": random.uniform(0, 100)
    })

def threat_simulation():
    while True:
        time.sleep(random.randint(30, 60))
        event = {
            "event": "threat_alert",
            "message": "Simulated threat detected! Choose your remediation action:",
            "options": ["Lockdown", "Scale Up", "Do Nothing"],
            "correct_action": "Lockdown"
        }
        socketio.emit("threat_event", event)

threading.Thread(target=threat_simulation, daemon=True).start()

@socketio.on("connect")
def handle_connect():
    print("Client connected")
    emit("welcome", {"message": "Welcome to the demo portal!"})

@socketio.on("submit_action")
def handle_submit(data):
    action = data.get("action")
    if action == "Lockdown":
        emit("action_response", {"result": "Correct! The threat has been mitigated."})
    else:
        emit("action_response", {"result": "Incorrect. Please try again."})

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    socketio.run(app, host="0.0.0.0", port=port, debug=False, use_reloader=False)
