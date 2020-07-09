docker build -t imlsnn . \
&& nvidia-docker run \
-v /home/eric/LSNN-official:/home/developer \
--name lsnn_co \
--net host \
--ipc host \
--rm \
imlsnn \
python3 bin/my_run.py