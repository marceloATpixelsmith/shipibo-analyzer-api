# Use official Ubuntu base image
FROM ubuntu:22.04

# Install system dependencies including build tools and foma dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-pip \
    git \
    curl \
    flex \
    bison \
    autoconf \
    automake \
    libtool

# Clone and install foma from source with proper bootstrapping
RUN git clone https://github.com/mhulden/foma.git /foma && \
    cd /foma && \
    autoreconf -i && \
    ./configure && \
    make && \
    make install && \
    cd / && rm -rf /foma

# Set working directory inside container
WORKDIR /app

# Copy your application files into the container
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Compile the analyzer using your build.sh script
RUN bash build.sh

# Expose port 5000 for Flask app
EXPOSE 5000

# Command to run your Flask app
CMD ["python3", "app.py"]
