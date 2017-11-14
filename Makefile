COMMON_NAME = ns_node_server_ans

IMAGE = $(COMMON_NAME)
NAME = $(COMMON_NAME)

# --user root
# -v $$PWD/app:/usr/src/app
# -p 80:80
# -e "ENVVAR=1"
# --link="mysql:mysql.ccl"
PARAMS = -p 8911:8911 \
		-v $$PWD/host_playbook.sh:/host_playbook.sh \
		-v /root/.ssh:/hostssh \
		--net=host

.PHONY: build run rund runsh install stop inspect logs

build:
		docker build -t $(IMAGE) .

run:
		docker run --rm -it --name $(NAME) $(PARAMS) $(IMAGE)

rund:
		docker run -d --name $(NAME) $(PARAMS) $(IMAGE)

runsh:
		docker run --rm -it --name $(NAME) $(PARAMS) $(IMAGE) bash

install:
		docker run --rm -it --name $(NAME) $(PARAMS) $(IMAGE) npm install --no-bin-links

stop:
		docker stop $(NAME)
		docker rm $(NAME)

inspect:
		docker exec -it $(NAME) bash

logs:
		docker logs $(NAME)
