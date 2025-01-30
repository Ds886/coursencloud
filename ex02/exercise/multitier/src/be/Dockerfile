FROM python:3.9-slim

WORKDIR /app
COPY . /app


RUN pip install --no-cache-dir -r requirements.txt
# Default port
EXPOSE 5000

ENV DB_HOST=localhost
ENV DB_NAME=mydatabase
ENV DB_USER=mususer
ENV DB_PASSWORD=mypassword

CMD ["flask", "run", "--host=0.0.0.0"]

