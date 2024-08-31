# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables to avoid user interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install any necessary packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    vim \
    git \
    build-essential \
    && apt-get clean

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Set a default command to be run when the container starts
CMD ["bash"]
