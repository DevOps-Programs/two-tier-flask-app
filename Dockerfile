# Get the base image of python
FROM python:3.9-slim
 
# Set the working directory in the container
WORKDIR /app
 
# Install required packages for system
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*
 
# Copy the requirements file into the container
COPY requirements.txt . 
 
# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt
 
# Copy the rest of application code
COPY . .
 
# Specify the command to run application
CMD ["python", "app.py"] 
