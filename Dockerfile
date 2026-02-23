# Use Ubuntu 24.04
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install SSH and useful tools
RUN apt update && apt upgrade -y && \
    apt install -y openssh-server sudo && \
    mkdir /var/run/sshd

# Set root password
RUN echo 'root:root' | chpasswd

# Allow root login via SSH (if нужно)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH
CMD ["/usr/sbin/sshd", "-D"]
