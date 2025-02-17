FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY first-blood-announcer.py .

# Create volume for persistent database storage
VOLUME /app/data

CMD ["python", "first-blood-announcer.py", "--db", "/app/data/solves.db"] 