FROM python:3.11

RUN apt-get install unzip -y
RUN apt-get install wget -y 

RUN apt update \
    && apt install -y wget \
    && apt install -y unzip \
    && apt install -y vim \
    && apt install -y openssh-client

# Download the latest version of Terraform from the official website
RUN wget https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip

# Unzip the downloaded file:
RUN unzip terraform_0.15.4_linux_amd64.zip

# Move the terraform binary to a directory in your system's PATH.
RUN mv terraform /usr/local/bin/

# Verify that Terraform is installed by checking its version:
RUN terraform version


WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000
ENTRYPOINT [ "/bin/sh" ]
CMD [ "./entrypoint.sh" ]
