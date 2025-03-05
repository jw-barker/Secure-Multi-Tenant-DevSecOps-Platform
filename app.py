import collections
import collections.abc
collections.MutableMapping = collections.abc.MutableMapping

import eventlet
eventlet.monkey_patch()

import os, random, time, eventlet
from flask import Flask, render_template, jsonify
from flask_socketio import SocketIO, emit

app = Flask(__name__)
app.config['SECRET_KEY'] = os.environ.get("FLASK_SECRET_KEY", "your-secret-key")
socketio = SocketIO(app, async_mode="eventlet")

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/api/metrics")
def metrics():
    data = {
        "cpu_usage": random.uniform(0, 100),
        "memory_usage": random.uniform(0, 100)
    }
    return jsonify(data)

@app.route("/trigger-alert")
def trigger_alert():
    alert = generate_alert()
    app.logger.info("Manually emitting alert: %s", alert)
    socketio.emit("alert_event", alert)
    return jsonify({"status": "alert emitted"})

def generate_alert():
    # Simulate a SIEM-style alert with cloud security context
    severity = random.choice(["Low", "Medium", "High", "Critical"])
    timestamp = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
    alert = {
        "alert_id": random.randint(1000, 9999),
        "timestamp": timestamp,
        "severity": severity,
        "description": f"Simulated {severity} security alert from cloud sensor.",
        "source": "SIEM"
    }
    return alert

def alert_simulation():
    print("Starting alert_simulation thread", flush=True)
    while True:
        delay = random.randint(10, 20)  # Adjust delay as needed for testing
        eventlet.sleep(delay)
        alert = generate_alert()
        print("Emitting alert:", alert, flush=True)
        socketio.emit("alert_event", alert)

socketio.start_background_task(alert_simulation)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    print("Starting app on port", port, flush=True)
    socketio.run(app, host="0.0.0.0", port=port, debug=True, use_reloader=False)
