<!--
Copyright (c) 2018 Jakob Meng, <jakobmeng@web.de>
Copyright (c) 2018 Max Mensing, <max@maximilian-mensing.de>
-->
# Jupyter Notebook with Prolog

This Docker image is based on [jupyter/datascience-notebook](https://hub.docker.com/r/jupyter/datascience-notebook/),
complemented by [SWI-Prolog Kernel](https://github.com/madmax2012/SWI-Prolog-Kernel) from [Max Mensing](https://github.com/madmax2012/).

## Usage

Get docker image:
```
docker pull jm1337/jupyter-prolog-notebook
```

Run interactive (exit with <kbd>CTRL</kbd>+<kbd>C</kbd> in shell or via `Quit` button on dashboard):
```
docker run --rm --publish 127.0.0.1:8888:8888 --interactive --tty jm1337/jupyter-prolog-notebook
```
Open a browser and go to `http://127.0.0.1:8888/tree?token=...`, as it is printed by the former command. Make sure to copy the shown token!

**:warning:Data is not stored persistently! Once your docker container is shut down all your changes within your notebooks etc. are lost!:warning:**

To persistently store your data you have to mount a local folder into your container by adding `-v INSERT_PATH_TO_LOCAL_FOLDER_HERE:/home/jovyan/work:rw` to your docker command, e.g.:
```
mkdir ~/jupyter
docker run --rm -p 127.0.0.1:8888:8888 -i -t -v ~/jupyter:/home/jovyan/work:rw jm1337/jupyter-prolog-notebook
```
**:warning:Only changes within folder `work/` are stored persistently. All other changes are lost after docker container is stopped:warning:**

## Advanced Usage
Run as deamon:
```
docker run --rm --detach --publish 127.0.0.1:8888:8888 --interactive --tty --name jm1337-jupyter-prolog-notebook jm1337/jupyter-prolog-notebook
docker stop jm1337-jupyter-prolog-notebook
```

Login to a daemonized container:
```
docker exec -ti jm1337-jupyter-prolog-notebook
```

Run interactively and login:
```
docker run -ti --rm jm1337/jupyter-prolog-notebook bash
```

## Frequently Asked Questions

### My Jupyter notebook (`*.ipynb` file) does not execute any code?! It says `Not Trusted` in the upper right corner..

> It is a security feature to disable the execution of arbitrary code from untrusted notebooks, without the user's consent.
[Quoted from stackoverflow.com](https://stackoverflow.com/a/44943799/6490710).

Just click on `Trust` button in the upper right corner, then Jupyter will execute your code and print its results as expected.


## References:

 1. https://hub.docker.com/_/httpd/
 2. https://docs.docker.com/engine/userguide/networking/
 3. https://github.com/madmax2012/jupyterhub-nbgrader-brsu/blob/master/Dockerfile
 4. https://github.com/madmax2012/SWI-Prolog-Kernel
