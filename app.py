from flask import Flask, render_template, jsonify, request
from flask_socketio import SocketIO, emit
import random, time, threading

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key'
socketio = SocketIO(app)

@app.route("/")
def index():
    # Render a simple template that connects to SocketIO
    return render_template("index.html")

@app.route("/api/metrics")
def metrics():
    # Simulated metrics for demonstration
    return jsonify({
        "cpu_usage": random.uniform(0, 100),
        "memory_usage": random.uniform(0, 100)
    })

def threat_simulation():
    while True:
        time.sleep(random.randint(30, 60))  # wait 30-60 seconds
        # Simulate a threat event
        event = {
            "event": "threat_alert",
            "message": "Simulated threat detected! Choose your remediation action:",
            "options": ["Lockdown", "Scale Up", "Do Nothing"],
            "correct_action": "Lockdown"  # for demo purposes
        }
        socketio.emit("threat_event", event)

# Start the threat simulation in a background thread
threading.Thread(target=threat_simulation, daemon=True).start()

@socketio.on("connect")
def handle_connect():
    print("Client connected")
    emit("welcome", {"message": "Welcome to the demo portal!"})

@socketio.on("submit_action")
def handle_submit(data):
    # Process the user's action; for demo purposes, simply check if it matches
    action = data.get("action")
    # In a real app, you'd compute a score or trigger an alert, etc.
    if action == "Lockdown":
        emit("action_response", {"result": "Correct! The threat has been mitigated."})
    else:
        emit("action_response", {"result": "Incorrect. Please try again."})

if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0", port=8080)
