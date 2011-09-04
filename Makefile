BRANCH=$(shell git status|grep "On branch" | cut -f4 -d" ")

default:
	@echo $(BRANCH)

pull:
	 rsync --exclude-from=rsync.exclude -rcv eli@rhfb.net:/var/www/APPLICATION_PATH/ ./

fakepull:
	 rsync --exclude-from=rsync.exclude -rcvn eli@rhfb.net:/var/www/APPLICATION_PATH/./

push:
ifeq ($(BRANCH),master)
	 rsync --exclude-from=rsync.exclude -rcv ./ eli@rhfb.net:/var/www/APPLICATION_PATH/
else
	 @echo "Push must be done from master foo!"
endif

push_delete:
ifeq ($(BRANCH),master)
	 rsync --exclude-from=rsync.exclude -rcv --delete ./ eli@rhfb.net:/var/www/APPLICATION_PATH/
else
	 @echo "Push must be done from master foo!"
endif

fakepush:
	rsync --exclude-from=rsync.exclude -rcvn ./ eli@rhfb.net:/var/www/APPLICATION_PATH/

fakepush_delete:
	rsync --exclude-from=rsync.exclude -rcvn --delete ./ eli@rhfb.net:/var/www/APPLICATION_PATH/

stagepull:
	 rsync --exclude-from=rsync.exclude -rcv eli@rhfb2.net:/var/www/APPLICATION_PATH/ ./

stagefakepull:
	 rsync --exclude-from=rsync.exclude -rcvn eli@rhfb2.net:/var/www/APPLICATION_PATH/./

stagepush:
ifeq ($(BRANCH),stage)
	 rsync --exclude-from=rsync.exclude -rcv ./ eli@rhfb2.net:/var/www/APPLICATION_PATH/
else
	 @echo "Push must be done from stage foo!"
endif

stagepush_delete:
ifeq ($(BRANCH),stage)
	 rsync --exclude-from=rsync.exclude -rcv --delete ./ eli@rhfb2.net:/var/www/APPLICATION_PATH/
else
	 @echo "Push must be done from stage foo!"
endif

stagefakepush:
	rsync --exclude-from=rsync.exclude -rcvn ./ eli@rhfb2.net:/var/www/APPLICATION_PATH/

stagefakepush_delete:
	rsync --exclude-from=rsync.exclude -rcvn --delete ./ eli@rhfb2.net:/var/www/APPLICATION_PATH/