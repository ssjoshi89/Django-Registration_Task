# base image
FROM python:3
#
# #maintainer
LABEL Author="Sumit Joshi"
#
# #directory to store app source code
RUN mkdir /mnt/app
#
# #switch to /app directory so that everything runs from here
WORKDIR /mnt/app
#
# #copy the app code to image working directory
COPY ./Django-Registration_Task /mnt/app
#
# #let pip install required packages
RUN pip install --upgrade pip

RUN pip install -r requirements.txt


