# robusta-load-custom-playbook-direct-to-container-img
used to demonstrate an issue with trying to load a custom playbook from the robusta runner container image directly

## Pre-requisites

1. kind
2. kubectl
3. helm
4. robusta cli

## Steps to reproduce

1. create kind cluster and install robusta:
    ```bash 
    make install-robusta
   ```
   
2. observer error loading custom playbook:
    ```bash
   robusta logs --namespace robusta -f   
   ```
   ```bash
   2023-07-03 20:25:29.435 ERROR    Action foo not found. Will not be executed
   2023-07-03 20:25:29.436 ERROR    unknown error reloading playbooks. will try again when they next change
   Traceback (most recent call last):
   File "/app/src/robusta/runner/config_loader.py", line 207, in __reload_playbook_packages
   (sinks_registry, playbooks_registry) = self.__prepare_runtime_config(
   File "/app/src/robusta/runner/config_loader.py", line 262, in __prepare_runtime_config
   playbooks_registry = PlaybooksRegistryImpl(
   File "/app/src/robusta/model/config.py", line 116, in __init__
   raise Exception(msg)
   Exception: Action foo not found. Will not be executed
   ```
3. exec into runner to verify foo action is located among built-in robusta actions
    ```bash
   kubectl -n robusta exec robusta-runner-[pod-suffix] -it -- bash
   ```
   ```bash
   ls -la /etc/robusta/playbooks/defaults/robusta_playbooks/ | grep foo
   ```
