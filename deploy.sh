docker build -t imlsnn . \
&& nvidia-docker run \
-v ~/eric/LSNN-official:/home/developer \
--name lsnn_co \
--net host \
--ipc host \
--rm \
-t \
imlsnn \
python3 bin/my_run.py
