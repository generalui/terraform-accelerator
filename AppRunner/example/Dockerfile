FROM python:3.14-slim

WORKDIR /usr/src/app

COPY PythonExample/requirements.txt PythonExample/app.py ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
