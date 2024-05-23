# Pull an official python image
FROM python:3.13-rc-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Set environment variables

# Prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE 1
# Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED 1

# Install dependencies
COPY requirements.txt .

# Upgrade pip and prevents keeping the cache
RUN pip install -U pip && pip install --no-cache-dir -r requirements.txt

# Copy the project files into the working directory
COPY . .

# Open the port 8000
EXPOSE 8000

# Run the application with Gunicorn, a WSGI HTTP server for Python
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "core.wsgi:application"]
