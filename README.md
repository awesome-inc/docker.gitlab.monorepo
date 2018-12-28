# docker.gitlab.monorepo

[![Docker build](https://img.shields.io/docker/build/awesomeinc/docker.gitlab.monorepo.svg?logo=docker)](https://hub.docker.com/r/awesomeinc/docker.gitlab.monorepo/builds/)
[![Docker automated](https://img.shields.io/docker/automated/awesomeinc/docker.gitlab.monorepo.svg?logo=docker)](https://hub.docker.com/r/awesomeinc/docker.gitlab.monorepo/)
[![Docker stars](https://img.shields.io/docker/stars/awesomeinc/docker.gitlab.monorepo.svg?logo=docker)](https://hub.docker.com/r/awesomeinc/docker.gitlab.monorepo/)
[![Docker pulls](https://img.shields.io/docker/pulls/awesomeinc/docker.gitlab.monorepo.svg?logo=docker)](https://hub.docker.com/r/awesomeinc/docker.gitlab.monorepo/)

[![Build status](https://img.shields.io/travis/awesome-inc/docker.gitlab.monorepo.svg?logo=travis)](https://travis-ci.org/awesome-inc/docker.gitlab.monorepo/)
[![GitHub issues](https://img.shields.io/github/issues/awesome-inc/docker.gitlab.monorepo.svg?logo=github "GitHub issues")](https://github.com/awesome-inc/docker.gitlab.monorepo)
[![GitHub stars](https://img.shields.io/github/stars/awesome-inc/docker.gitlab.monorepo.svg?logo=github "GitHub stars")](https://github.com/awesome-inc/docker.gitlab.monorepo)

A compact docker image (32MB) enabling monorepo pipelines with Gitlab CI docker executors, cf.: [awesome-inc/monorepo.gitlab](https://github.com/awesome-inc/monorepo.gitlab) containing `docker`,  `docker-compose`, `bash`, `curl` and `jq`.

## Why?

This is probably for you if you are a fan of

- [Docker](https://www.docker.com/why-docker),
- [GitLab CI](https://about.gitlab.com/product/continuous-integration/)
- and [Monorepos](https://en.wikipedia.org/wiki/Monorepo).

Monorepos can still be quite a challenge for existing deployment platforms such as Jenkins or GitLab CI because simply building all projects in the monorepo on each commit just won't scale well. With monorepos you need to sort out what and when to build.

[awesome-inc/monorepo.gitlab](https://github.com/awesome-inc/monorepo.gitlab) addresses how to do this for GitLab CI.
It basically comes down to checking the [git diff](https://git-scm.com/docs/git-diff) and only building projects that have been changed.

What this repository adds is a docker image and a recipe that can be used with [Docker executors](https://docs.gitlab.com/runner/executors/docker.html) (instead of e.g. [Shell executors](https://docs.gitlab.com/runner/executors/shell.html)).

**Docker executors** can be considered the default for GitLab CI. As a rule of thumb they are the probably the best choice, even if you have strong reasons for not moving to the cloud yet and want to self-host & maintain all your [GitLab Runners](https://docs.gitlab.com/runner/) yourself (which i certainly did in the past, cf.: [riemers/ansible-gitlab-runner](https://github.com/riemers/ansible-gitlab-runner)).

## How to use

So here is the recipe to have a nice monorepo pipeline with GitLab CI all using Docker.

First, check you have enabled monorepo support for GitLab CI using [awesome-inc/monorepo.gitlab](https://github.com/awesome-inc/monorepo.gitlab#how-to-use).

Next, you need to enable the [docker-in-docker](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#use-docker-in-docker-executor) executor. In your `.gitlab-ci.yml` add

```yml
variables:
  # cf.: https://docs.gitlab.com/ee/ci/docker/using_docker_build.html
  DOCKER_HOST: tcp://docker:2375/
  DOCKER_DRIVER: overlay2
services:
  - docker:dind
```

Finally, use our docker image for building, e.g.

```yml
image:
  name: awesomeinc/docker.gitlab.monorepo:0.1.0
  entrypoint: [""] # force an empty entrypoint, cf.: https://gitlab.com/gitlab-org/gitlab-runner/issues/2692#workaround
```
