# Use a lightweight base image
FROM ubuntu:22.04

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN apt-get update && \
    apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add cowsay to PATH
ENV PATH="/usr/games:${PATH}"

# Set working directory
WORKDIR /app

# Copy the wisecow script
COPY wisecow.sh .

# Make the script executable
RUN chmod +x wisecow.sh

# Expose the default port
EXPOSE 4499

# Set environment variable for port
ENV PORT=4499

# Run the application
CMD ["./wisecow.sh"]

