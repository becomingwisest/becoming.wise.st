all:
	jekyll build
	s3_website push
