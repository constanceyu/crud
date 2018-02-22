FROM jupyter/minimal-notebook

WORKDIR /app

ADD ./requirements.txt /home/jovyan/work/requirements.txt

RUN pip install --trusted-host pypi.python.org -r /home/jovyan/work/requirements.txt

EXPOSE 8888


