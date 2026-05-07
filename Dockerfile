FROM python:3.11-slim

WORKDIR /app

# Install dependencies :

COPY /app/requirements.txt .

RUN pip install upgrade && pip install -r requirements.txt

#Copy the applications

COPY /app .

#Create volume for persistence 

VOLUME ["/app/data"]

RUN mkdir -p /app/data &&  mv count.txt /app/data &> /dev/null || true

#Update app to use /app/data/count.txt
ENV COUNT_FILE_PATH=/app/data/count.txt

EXPOSE 5000

CMD ["python","app.py"]