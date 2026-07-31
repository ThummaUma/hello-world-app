from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)
metrics.info('app_info', 'Hello World application info', version='1.0.0')

@app.route('/', methods=['GET'])
def hello():
    return "<h1>Hello World!</h1><p>This app is running inside a Docker container.</p>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
