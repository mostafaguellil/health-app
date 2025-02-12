FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

# For my run run container tests
COPY test.py ./test.py 

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 3000

CMD ["flask", "run", "--host=0.0.0.0", "--port=3000"]
