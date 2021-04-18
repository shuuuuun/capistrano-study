.PHONY: deploy puma tasks

deploy/dry-run:
	bundle exec cap production deploy --dry-run

deploy:
	bundle exec cap production deploy

puma/setup:
	bundle exec cap production puma:make_dirs puma:config puma:systemd:config puma:systemd:enable

puma/restart:
	bundle exec cap production puma:restart

puma/stop:
	bundle exec cap production puma:stop

puma/start:
	bundle exec cap production puma:start

tasks:
	bundle exec cap -T
