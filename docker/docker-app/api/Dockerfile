FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "app.py"]
EOT

# Create requirements.txt
echo "flask" > api/requirements.txt

# Create a placeholder app.py
cat <<EOT > api/app.py
from flask import Flask
app = Flask(__name__)

@app.route('/api/todos')
def get_todos():
    return {"todos": []}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)