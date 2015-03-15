serve:
	bundle exec jekyll serve

build:
	bundle exec jekyll build

upload:
	make build
	cd ../piotrm0.github.io; \
	git stage -u; \
	git commit . -m "updating website"; \
	git push
