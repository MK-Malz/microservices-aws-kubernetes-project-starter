# Use an official Python runtime as a parent image
FROM python:3.8

# The directory in the container where the app will be copied and run
WORKDIR /usr/src/app

# Copy only the requirements.txt first to leverage Docker cache
COPY analytics/requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY analytics/ .

# Make port 5153 available to the world outside this container
EXPOSE 5153

# Define environment variable (if needed)
# ENV NAME World

# Command to run the application
CMD ["python", "./app.py"]
