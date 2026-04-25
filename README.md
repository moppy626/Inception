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

## Virtual Machines vs Docker
- Virtual Machines vs Docker
Docker is a tool that bundles the application you want to use and its dependent environment into a single “container,” allowing you to manage multiple containers.
Since environments and volumes are created for each application, you can easily delete or recreate them without affecting other applications. You can also share the same configuration with developers around the world via Docker Hub.
By utilizing the host system’s Linux kernel features—namely namespaces and cgroups—Docker manages the environment for each process while sharing the host OS kernel. This mechanism allows for the lightweight deployment of multiple environments.
In contrast, a virtual machine (VM) creates a virtual representation of physical hardware (CPU, memory, and storage), boots a full operating system, and then launches the desired application on top of it. Therefore, VMs are useful when you need to test GUI applications on different operating systems, run legacy applications that only work on older OSes, or require complete isolation of environments for enhanced security. However, each guest OS requires its own updates and security management, which incurs operational costs.

- Secrets vs Environment Variables

- Docker Network vs Host Network
- Docker Volumes vs Bind Mounts