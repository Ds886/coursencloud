FROM python:3.9-slim

ENV FLASK_APP=app
ENV FLASK_ENV=development

COPY ./requirements.txt /opt

WORKDIR /opt
RUN pip3 install -r requirements.txt
COPY ./app.py /opt
CMD ["python", "app.py"]

EXPOSE 5000
