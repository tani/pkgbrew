TARGETS = pkgbrew installer

all: $(TARGETS)
	cat bin/pkgbrew                                       \
	| sed -e "s/__PKGBREW_REVISION__/`git show -s --format=%H`/g" \
	| sed -e "s/__PKGSRC_VERSION__/stable/g" \
	> pkgbrew
	mv pkgbrew bin/pkgbrew

$(TARGETS): %: src/%.sh
	perl bin/compile.pl $^ > $@
	chmod +x $@
	mv $@ bin/

.PHONY: clean

clean:
	rm -rf bin/installer bin/pkgbrew *~ */*~
	rm -rf test/ installer.log

test: $(TARGETS)
	sh bin/test.sh
