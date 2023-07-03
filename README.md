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
   
3. exec into runner to verify foo action is located among built-in robusta actions
    ```bash
   kubectl -n robusta exec robusta-runner-[pod-suffix] -it -- bash
   ```
   ```bash
   ls -la /etc/robusta/playbooks/defaults/robusta_playbooks/ | grep foo
   ```
