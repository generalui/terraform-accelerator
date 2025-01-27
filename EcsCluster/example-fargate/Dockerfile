# Use an official Python runtime as a parent image
FROM python:3.11.7-slim-bookworm

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY ./PythonExample/app.py ./PythonExample/requirements.txt ./

# Install the specified packages
RUN pip install -r requirements.txt

# Run app.py when the container launches
CMD ["python", "app.py"]
