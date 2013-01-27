version = `grep -o 'version.*' component.json | awk '{split($$0,a,"\""); print a[3];}'`

component:
	@rm -rf jquery-*
	@wget http://code.jquery.com/jquery-$(version).js
	@cp jquery-$(version).js index.js
	@rm -rf jquery-*
	@sed -i -r 's/window\.jQuery = window\.\$$ = jQuery;/\
		module\.exports = jQuery;/g' index.js

build: components index.js
	@component build --dev

components: component.json
	@component install --dev

clean:
	rm -fr build components template.js

.PHONY: clean
