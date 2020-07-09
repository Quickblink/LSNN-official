FROM nvcr.io/nvidia/tensorflow:19.01-py3
RUN apt-get update
RUN apt-get install -y mesa-utils
RUN apt-get install -y sudo
RUN apt-get install -y python-opengl
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
RUN mkdir -p /home/developer
ENV HOME /home/developer
WORKDIR /home/developer


RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py --force-reinstall
#RUN python3 -m pip install --user --upgrade pip
COPY requirements.txt /home/developer
#COPY ray-0.9.0.dev0-cp36-cp36m-manylinux1_x86_64.whl /home/developer
#RUN pip install -U ray-0.9.0.dev0-cp36-cp36m-manylinux1_x86_64.whl
RUN pip install -r requirements.txt
RUN pip install --force-reinstall jupyter

#have this in the end because we are not root afterwards
RUN export uid=1000 gid=1001 && \
    mkdir -p /etc/sudoers.d && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${gid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer
USER developer


