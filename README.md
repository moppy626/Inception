*This project has been created as part of the 42 curriculum by mmachida*

## Description
In this assignment, you will build a website using Docker, MariaDB, WordPress, and Nginx. While official image files are available for these containers, you must not use any pre-existing ones; instead, you must build them from scratch using Alpine or Debian.
Detailed configuration instructions are provided in [DEV_DOC.md](./DEV_DOC.md).

## Instructions
The procedure is described in detail in [USER_DOC.md](./USER_DOC.md)

## AI Usage
- Translation
- List the elements to study for this assignment
- Troubleshooting When Issues Occur

## Resources
- [DockerでWordpress構築ハンズオン](https://zenn.dev/justhiro/articles/c454cc1fbc784e)
- [mariadb.md](./docs/mariadb.md)
- [Nginx.md](./docs/Nginx.md)
- [ubuntu.md](./docs/ubuntu.md)
- [wordpress.md](./docs/wordpress.md)

## Topic Questions
- Virtual Machines vs Docker
Docker is a tool that bundles the application you want to use and its dependent environment into a single “container,” allowing you to manage multiple containers.
Since environments and volumes are created for each application, you can easily delete or recreate them without affecting other applications. You can also share the same configuration with developers around the world via Docker Hub.
By utilizing the host system’s Linux kernel features—namely namespaces and cgroups—Docker manages the environment for each process while sharing the host OS kernel. This mechanism allows for the lightweight deployment of multiple environments.
In contrast, a virtual machine (VM) creates a virtual representation of physical hardware (CPU, memory, and storage), boots a full operating system, and then launches the desired application on top of it. Therefore, VMs are useful when you need to test GUI applications on different operating systems, run legacy applications that only work on older OSes, or require complete isolation of environments for enhanced security. However, each guest OS requires its own updates and security management, which incurs operational costs.

- Secrets vs Environment Variables
Environment variables are a convenient way to store SSH keys and passwords outside the repository and pass them to containers during the build process; however, as they are, anyone with access privileges can view them in plain text. Furthermore, it is difficult to track who accessed them, and they are passed down to child processes. They can also be viewed using `docker inspect`.
With Docker Secrets, if you configure a file, it is mounted to the `/run/secrets` folder during the build process, and users without root privileges cannot access the file.

[Dockerシークレットとは？](https://www.sysdig.com/jp/learn-cloud-native/what-are-docker-secrets)

- Docker Network vs Host Network
When you launch Docker, containers are configured by default to use a bridge network. With the default settings, containers are connected to a network where they can communicate with all other containers on the Docker Engine, and communication between containers must be done using IP addresses. On the other hand, if you create a custom network and assign it to specific containers, those containers become inaccessible to other containers, and you can communicate between them using container names. Containers created with `docker-compose` automatically use the bridge network defined in that file.
On the other hand, if you specify the host network using the `--network host` option with `docker run`, the container will share the network with the host. In this case, the container is not assigned an IP address and instead uses the host’s address on the specified port number. This is useful when network speed is a priority or when you want to use the host’s port directly.

[ホスト・ネットワークの使用](https://docs.docker.jp/network/host.html)

- Docker Volumes vs Bind Mounts
Docker volume is a data storage location created and managed by Docker. By mounting it to a container’s directory, data is preserved even if the container is restarted. You can also configure a created volume for multiple containers, allowing multiple containers to access the same data. Volumes can be easily deleted and recreated using Docker commands.
On the other hand, a bind mount is a feature that allows you to link any folder or file on the host machine to a folder or file within a container. Since the contents are shared, changes made to a file on either the host or the container will be reflected on the other side. If you bind-mount a source code directory to a container to share it with the host machine, you won’t need to synchronize or transfer files when you make changes to the code on the host machine.
