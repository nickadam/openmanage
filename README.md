# OpenManage
Dell OpenManage in a container

Installing OpenManage can be problematic on OSes that are not suported by Dell.
This docker image shoehorns OpenManage v10.2.0.0 into the Ubuntu 20.04 base
image. So long as your OS can run privileged containers, you can run OpenManage.

## Running

```
docker run -d --privileged --net=host --uts=host nickadam/openmanage
```

By default, the image sets a long random password for the root user (not your
root user, the container's) at every startup. The root password is output to the
container's logs. You can login to OpenManage using this account via https on
port 1311.

You can also set the root password using the environment variable `ROOT_PASSWORD`.

```
docker run -d --privileged --net=host --uts=host -e ROOT_PASSWORD=badpassword nickadam/openmanage
```
