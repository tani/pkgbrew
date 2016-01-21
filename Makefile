TARGETS = pkgbrew installer

all: $(TARGETS)

$(TARGETS): %: src/%.sh
	perl bin/compile.pl $^ \
	| sed -e "s/__PKGBREW_REVISION__/`git rev-parse --short HEAD`/g" \
	| sed -e "s/__PKGSRC_VERSION__/stable/g" \
	> bin/$@
	chmod +x bin/$@

.PHONY: clean

clean:
	rm -rf bin/installer bin/pkgbrew *~ */*~
	rm -rf test/ installer.log

test: $(TARGETS)
	sh bin/test.sh
