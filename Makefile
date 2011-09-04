BRANCH=$(shell git status|grep "On branch" | cut -f4 -d" ")

default:
	@echo $(BRANCH)

pull:
	 rsync --exclude-from=rsync.exclude -rcv josh@dynamicsuperior.com:/var/www/apps/hacker-news-mini/ ./

fakepull:
	 rsync --exclude-from=rsync.exclude -rcvn josh@dynamicsuperior.com:/var/www/apps/hacker-news-mini/./

push:
ifeq ($(BRANCH),master)
	 rsync --exclude-from=rsync.exclude -rcv ./ josh@dynamicsuperior.com:/var/www/apps/hacker-news-mini/
else
	 @echo "Push must be done from master foo!"
endif

push_delete:
ifeq ($(BRANCH),master)
	 rsync --exclude-from=rsync.exclude -rcv --delete ./ josh@dynamicsuperior.com:/var/www/apps/hacker-news-mini/
else
	 @echo "Push must be done from master foo!"
endif

fakepush:
	rsync --exclude-from=rsync.exclude -rcvn ./ josh@dynamicsuperior.com:/var/www/apps/hacker-news-mini/

fakepush_delete:
	rsync --exclude-from=rsync.exclude -rcvn --delete ./ josh@dynamicsuperior.com:/var/www/apps/hacker-news-mini/