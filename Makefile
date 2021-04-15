.PHONY: deploy setup

deploy/dry-run:
	bundle exec cap production deploy --dry-run

deploy:
	bundle exec cap production deploy

setup:
	bundle exec cap production puma:make_dirs puma:config puma:systemd:config puma:systemd:enable

restart:
	bundle exec cap production puma:restart

tasks:
	bundle exec cap -T
