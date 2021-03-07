.PHONY: deploy config

deploy/dry-run:
	bundle exec cap production deploy --dry-run

deploy:
	bundle exec cap production deploy

config:
	bundle exec cap production puma:config puma:systemd:config puma:systemd:enable
