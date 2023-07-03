FROM us-central1-docker.pkg.dev/genuine-flight-317411/devel/robusta-runner:0.10.17
#RUN mkdir -p /etc/robusta/playbooks/storage/custom_playbooks
#COPY custom-playbooks/ /etc/robusta/playbooks/storage/custom_playbooks
#COPY custom-playbooks/ /etc/robusta/playbooks/custom_playbooks
COPY custom-playbooks/ /etc/robusta/playbooks/defaults/robusta_playbooks
#RUN ls -la /etc/robusta/playbooks/defaults/robusta_playbooks
#RUN ls -la /etc/robusta/playbooks/storage/custom_playbooks