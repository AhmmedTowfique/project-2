# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set working directory
WORKDIR /usr/src/app

# Copy requirements and install
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on
EXPOSE 80

# Environment variables defaults (optional)
ENV OPTION_A="Cats"
ENV OPTION_B="Dogs"
ENV REDIS_HOST="redis"
ENV REDIS_PORT_OVERRIDE=6379
ENV REDIS="redis:6379"

# Run the application
CMD ["python", "app.py"]
