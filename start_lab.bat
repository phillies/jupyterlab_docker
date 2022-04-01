@ECHO OFF
start chrome http://localhost:8888
docker run -it --rm -p 8888:8888 -v c:\users\%USERNAME%:/home/jovyan/work plies/jupyterlab
PAUSE