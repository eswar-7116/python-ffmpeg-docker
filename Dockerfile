# Use Python base image
FROM python:3.13-slim

# Metadata
LABEL maintainer="eswardudi06@gmail.com"
LABEL description="Slim Python 3.13 image with FFmpeg and Git pre-installed. Good for video editing automation."

# Avoid interactive prompts during package install
ENV DEBIAN_FRONTEND=noninteractive

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Install FFmpeg, Git and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Default working directory
WORKDIR /app

# Default command: open Python
CMD ["python"]
