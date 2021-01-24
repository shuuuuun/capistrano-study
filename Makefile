deploy/dry-run:
	bundle exec cap production deploy --dry-run

deploy:
	bundle exec cap production deploy

run-app:
	bundle exec ruby app.rb
