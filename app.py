from flask import Flask

app = Flask(__name__)

@app.route("/")
def index():
    return "Hello from the Secure Multi-Tenant DevSecOps Platform Demo Portal (Flask)!"

if __name__ == "__main__":
    # Listen on all interfaces on port 8080.
    app.run(host="0.0.0.0", port=8080)
