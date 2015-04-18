capbash-gitlab
==============

Scripts for installing [gitlab](https://about.gitlab.com/), should be used in conjunction with capbash

# How to Install #

Install capbash first, more details at:
https://github.com/capbash/capbash

```
curl -s https://raw.githubusercontent.com/capbash/capbash/master/capbash-installer | bash
capbash new YOUR_REPO_ROOT
cd YOUR_REPO_ROOT
```

Now you can install gitlab into your project

```
capbash install gitlab
```

# Configurations #

The available configurations include:

```
TBD
```


# Deploy to Remote Server #

To push the gitlab script to your server, all you need if the IP or hostname of your server (e.g. 192.167.0.48) and your root password.

```
capbash deploy <IP> gitlab
```

For example,

```
capbash deploy 127.0.0.1 gitlab
```
