FROM python:3.6.1-alpine
WORKDIR /app
COPY ./source /app 
RUN pip install -r requirements.txt
CMD ["python","app.py"]
EXPOSE 8080
