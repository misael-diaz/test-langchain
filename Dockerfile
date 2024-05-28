FROM python:3.12-slim
RUN apt-get update && apt-get install -y \
    vim \
    build-essential \
    net-tools \
    rsync \
    python3 \
    python3-pip \
    openssh-server
WORKDIR /app
EXPOSE 22
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY requirements.txt /app/requirements.txt
RUN pip3 install -r requirements.txt
RUN echo "root: " | chpasswd
RUN ssh-keygen -A
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN echo "export PATH=$PATH" >> /root/.bashrc
CMD service ssh start
