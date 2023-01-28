# inception

[Subject](https://cdn.intra.42.fr/pdf/pdf/69740/en.subject.pdf)

This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.

## Result

Success: 100/100

## Installation

Makefile:

Installing all dependencies and folders creation:
```bash
  make init
```

Run docker compose:
```bash
  make up
```

Site will be avaliable on:
```
  https://localhost
```

Stop images:
```
  make down
```
Show containers status:
```
  make list
```
Show volumes status:
```
  make list_volumes
```
Delete cache and folders
```
  make clean
```
Stop and clear all:
```
  make fclean
```
