FROM ubuntu:20.04

# Update OS
# RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

# Install Python
RUN apt-get install -y python3 python3-pip vim

# Add requirements.txt
# Create app directory

ADD . /server
  
RUN pip install -r /server/requirements.txt
WORKDIR /server

# Expose port 8000 for uwsgi
EXPOSE 8000
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8000", "server:app"]
