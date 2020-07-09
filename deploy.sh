docker build -t imlsnn . \
&& docker run \
-v /home/eric/LSNN-official:/home/developer \
--name lsnn_co \
--net host \
--ipc host \
imlsnn
python3 bin/my_run.py