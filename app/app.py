from flask import Flask, render_template_string, jsonify
import os

app = Flask(__name__)
COUNT_FILE = 'count.txt'

def read_count():
    if not os.path.exists(COUNT_FILE):
        return 0
    with open(COUNT_FILE, 'r') as f:
        return int(f.read().strip() or 0)

def write_count(value):
    with open(COUNT_FILE, 'w') as f:
        f.write(str(value))

@app.route('/')
def index():
    count = read_count()
    html = '''
    <!DOCTYPE html>
    <html>
    <head><title>DevOps Counter</title></head>
    <body>
        <h1>Counter Value: <span id="count">{{ count }}</span></h1>
        <button onclick="increment()">Increment</button>
        <button onclick="reset()">Reset</button>
        <script>
            function increment() {
                fetch('/increment', {method: 'POST'})
                    .then(r => r.json())
                    .then(data => document.getElementById('count').innerText = data.count);
            }
            function reset() {
                fetch('/reset', {method: 'POST'})
                    .then(r => r.json())
                    .then(data => document.getElementById('count').innerText = data.count);
            }
        </script>
    </body>
    </html>
    '''
    return render_template_string(html, count=count)

@app.route('/increment', methods=['POST'])
def increment():
    count = read_count() + 1
    write_count(count)
    return jsonify({'count': count})

@app.route('/reset', methods=['POST'])
def reset():
    write_count(0)
    return jsonify({'count': 0})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000) 