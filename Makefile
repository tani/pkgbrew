TARGETS = pkgbrew installer

all: $(TARGETS)

$(TARGETS): %: src/%.sh
	perl bin/compile.pl $^ \
	| sed -e "s/__PKGBREW_REVISION__/`git describe --long`/g" \
	| sed -e "s/__PKGSRC_VERSION__/trunk/g" \
	> bin/$@
	chmod +x bin/$@

.PHONY: clean

clean:
	rm -rf bin/installer bin/pkgbrew *~ */*~
	rm -rf test/

test: clean $(TARGETS)
	sh bin/test.sh
