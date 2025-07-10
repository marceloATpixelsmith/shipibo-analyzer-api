# Use official Ubuntu base image
FROM ubuntu:22.04

# Install system dependencies and foma package from Ubuntu repo
RUN apt-get update && apt-get install -y \
    foma \
    build-essential \
    python3 \
    python3-pip \
    git \
    curl \
    flex \
    bison

# Set working directory inside container
WORKDIR /app

# Copy all project files into container
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Run your build script to compile analyzer
RUN bash build.sh

# Expose Flask default port
EXPOSE 5000

# Command to run Flask app
CMD ["python3", "app.py"]
