# docker-molecule

Docker container for running [molecule](https://molecule.readthedocs.io/en/latest/), with in-container support for the Docker driver.

I built this primarily to use with ConcourseCI, for testing roles in pipelines, using Docker in Docker.

The real magic here is the `wrapdocker` script produced by [Jérôme Petazzoni](https://github.com/jpetazzo/dind/blob/master/wrapdocker).
