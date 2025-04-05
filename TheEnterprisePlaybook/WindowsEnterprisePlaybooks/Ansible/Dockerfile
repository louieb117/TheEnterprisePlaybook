FROM ubuntu:latest

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    ansible \
    sshpass \
    curl \
    vim \
    less 
    # && rm -rf /var/lib/apt/lists/*


# Create a Python virtual environment for Ansible and pywinrm
RUN python3 -m venv /opt/ansible_venv
ENV PATH="/opt/venv/bin:$PATH"

# Install pywinrm and any other dependencies in the virtual environment
RUN /opt/ansible_venv/bin/pip install --upgrade pip && \
    /opt/ansible_venv/bin/pip install pywinrm

# Create an Ansible user
RUN useradd -m -s /bin/bash ansible

# Set up Ansible directory
RUN mkdir -p /etc/ansible/

# Set working directory
WORKDIR /ansible

# Copy playbook and dependencies
COPY ./playbooks/ /ansible/

# Set permissions
RUN chown -R ansible:ansible /ansible

# Switch to Ansible user
USER ansible

# Default command
# CMD ["ansible-playbook", "-i", "/etc/ansible/hosts", "/ansible/configure_ad.yml"]
# Default command to use Ansible inside the virtual environment
# CMD ["/opt/ansible_venv/bin/ansible-playbook", "-i", "/etc/ansible/hosts", "/ansible/configure_ad.yml"]

