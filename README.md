# docker-molecule

Docker container for running [molecule](https://molecule.readthedocs.io/en/latest/), with in-container support for the Docker driver.

I built this primarily to use with ConcourseCI, for testing roles in pipelines, using Docker in Docker.

It relies on the `docker-lib.sh` file for wrapping docker commands, provided by [Concourse](https://github.com/concourse/docker-image-resource/blob/master/assets/common.sh), and [entrykit](https://github.com/progrium/entrykit).

You might need to start up `rsyslogd` in your concourse task definition, depending on your configured molecule `log_driver`.

Here's an example task definition that works for me:

```yaml
platform: linux

image_resource:
  type: docker-image
  source:
    repository: gaahrdner/molecule
    tag: "latest"

inputs:
  - name: ansible

run:
  path: /bin/sh
  args:
  - -exc
  - |
    rsyslogd
    source /usr/local/bin/docker-lib.sh
    start_docker
    cd ansible || exit
    ansible-galaxy install -r requirements.yml
    cd roles/my_role || exit
    molecule test
```
