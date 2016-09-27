help:
	echo make preview
	echo make deploy

preview:
	jekyll serve &
	sleep 3
	open http://localhost:4000/
	echo
	echo To clean up run: kill \`pgrep jekyll\`

deploy:
	jekyll build
	s3_website push
