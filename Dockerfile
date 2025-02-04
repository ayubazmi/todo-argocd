# Use official Python image as a base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies for MySQL client and pkg-config
RUN apt-get update && apt-get install -y \
    pkg-config \
    libmariadb-dev \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files into the container
COPY . /app/

# Expose the port for Django application (default port for Django is 8000)
EXPOSE 8000

# Set environment variables for Django
ENV PYTHONUNBUFFERED 1

# Run Django application with the development server (use manage.py)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
