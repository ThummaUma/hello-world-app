# Step 1: Use official Python base image
FROM python:3.11-slim

# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy requirements file first (for Docker layer caching)
COPY requirements.txt .

# Step 4: Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Expose port 5000 (Flask default)
EXPOSE 5000

# Step 7: Command to run the app
CMD ["python", "app.py"]
