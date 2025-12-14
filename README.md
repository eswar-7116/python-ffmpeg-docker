# Python + FFmpeg Docker Image

[![Docker Hub](https://img.shields.io/docker/v/eswardudi/python-ffmpeg?label=Docker%20Hub&logo=docker)](https://hub.docker.com/r/eswardudi/python-ffmpeg)
[![Docker Image Size](https://img.shields.io/docker/image-size/eswardudi/python-ffmpeg/latest?logo=docker)](https://hub.docker.com/r/eswardudi/python-ffmpeg)
[![Docker Pulls](https://img.shields.io/docker/pulls/eswardudi/python-ffmpeg?logo=docker)](https://hub.docker.com/r/eswardudi/python-ffmpeg)
[![License](https://img.shields.io/github/license/eswar-7116/python-ffmpeg-docker)](LICENSE)

A production-ready Docker image that combines **Python 3.13.3** with **FFmpeg**, providing a seamless environment for video and audio processing automation.

## 🎯 What is this?

`python-ffmpeg` is a Docker image built on `python:3.13-slim` with FFmpeg and Git pre-installed and configured. It is the standard Python slim image, but with multimedia processing capabilities built right in.

## 🚀 Why use this image?

Setting up FFmpeg alongside Python applications can be time-consuming and error-prone, especially across different environments. This image eliminates the need to:

- ❌ Manually install FFmpeg dependencies
- ❌ Deal with platform-specific FFmpeg compilation issues
- ❌ Write complex Dockerfiles just to add FFmpeg support
- ❌ Troubleshoot missing codecs or libraries

## 🎬 Perfect for

- **Video processing and transcoding**
- **Audio manipulation and conversion**
- **Media automation pipelines**
- **Content management systems**
- **Streaming applications**
- **Data analysis involving multimedia files**
- **Git integration for version control**

## 📦 Quick Start

### Basic Usage

```bash
# Run interactive Python shell with FFmpeg available
docker run -it eswardudi/python-ffmpeg python

# Run a Python script that uses FFmpeg
docker run --rm -v $(pwd):/app -w /app eswardudi/python-ffmpeg python your_script.py

# Execute FFmpeg directly
docker run --rm -v $(pwd):/media eswardudi/python-ffmpeg ffmpeg -i input.mp4 output.mp3
```

### Using as Base Image

```dockerfile
FROM eswardudi/python-ffmpeg:latest

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
CMD ["python", "main.py"]
```

### Docker Compose Example

```yaml
version: "3.8"
services:
  video-processor:
    image: eswardudi/python-ffmpeg:latest
    volumes:
      - ./media:/app/media
      - ./scripts:/app
    working_dir: /app
    command: python process_videos.py
```

## 💻 Usage Examples

### Using subprocess for FFmpeg Commands

```python
import subprocess
import os

def convert_video(input_path, output_path):
    """Convert video with H.264 encoding"""
    cmd = [
        'ffmpeg', '-i', input_path,
        '-c:v', 'libx264',
        '-c:a', 'aac',
        '-preset', 'medium',
        '-crf', '23',
        '-y', output_path
    ]
    subprocess.run(cmd, check=True)

def batch_convert(input_dir, output_dir):
    """Batch convert all MP4 files in directory"""
    for filename in os.listdir(input_dir):
        if filename.endswith('.mp4'):
            input_path = os.path.join(input_dir, filename)
            output_path = os.path.join(output_dir, filename.replace('.mp4', '.avi'))
            convert_video(input_path, output_path)
            print(f"Converted {filename}")
```

## 🏷️ Available Tags

| Tag      | Description                    | Size   |
| -------- | ------------------------------ | ------ |
| `latest` | Latest stable version          | ~200MB |
| `3.13`   | Python 3.13 with latest FFmpeg | ~200MB |

## 🛠️ Image Details

- **Base Image**: `python:3.13-slim`
- **FFmpeg Version**: Latest stable from Debian repositories
- **Python Version**: 3.13.3
- **OS**: Debian Bookworm

## 📋 Best Practices

### Performance Optimization

```bash
# Mount volumes for better I/O performance
docker run --rm -v $(pwd)/input:/input -v $(pwd)/output:/output \
  eswardudi/python-ffmpeg python process.py

# Use tmpfs for temporary files
docker run --rm --tmpfs /tmp:rw,noexec,nosuid,size=1g \
  -v $(pwd):/app eswardudi/python-ffmpeg python script.py
```

### Resource Management

```bash
# Set memory limits for large video processing
docker run --rm -m 2g --cpus="2.0" \
  -v $(pwd):/app eswardudi/python-ffmpeg python heavy_processing.py
```

### Security Considerations

```bash
# Run as non-root user
docker run --rm --user $(id -u):$(id -g) \
  -v $(pwd):/app eswardudi/python-ffmpeg python script.py
```

## 🔧 Building Locally

```bash
# Clone the repository
git clone https://github.com/eswar-7116/python-ffmpeg-docker.git
cd python-ffmpeg-docker

# Build the image
docker build -t python-ffmpeg .

# Test the build
docker run --rm python-ffmpeg python -c "import subprocess; print(subprocess.run(['ffmpeg', '-version'], capture_output=True, text=True).stdout)"
```

## 🧪 Testing

```bash
# Run the test suite
docker run --rm -v $(pwd)/tests:/tests python-ffmpeg python -m pytest /tests

# Quick verification
docker run --rm python-ffmpeg python -c "
import subprocess
import sys
try:
    result = subprocess.run(['ffmpeg', '-version'], capture_output=True, text=True, check=True)
    print('✅ FFmpeg is working!')
    print(f'Version: {result.stdout.split()[2]}')
except Exception as e:
    print('❌ FFmpeg test failed:', e)
    sys.exit(1)
"
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built on the excellent [official Python Docker images](https://hub.docker.com/_/python)
- FFmpeg for providing the powerful multimedia framework
- Git for VCS support

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/eswar-7116/python-ffmpeg-docker/issues)
- **Docker Hub**: [eswardudi/python-ffmpeg](https://hub.docker.com/r/eswardudi/python-ffmpeg)

---

<div align="center">If you found this image helpful, please consider giving it a star 🌟! It helps others find the project and encourages ongoing improvements</div>

**⭐ If this project helped you, please give it a star!**
