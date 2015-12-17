RELEASE ?= R2-rc1

DIRS = \
	anaconda \
	backgrounds \
	grub \
	icons \
	firstboot/qubes \
	plymouth

RPMDIR = rpm/

all:
	@for dir in $(DIRS); do $(MAKE) -C $$dir RELEASE=$(RELEASE) $@ || exit 1; done
.PHONY: all

clean:
	@for dir in $(DIRS); do $(MAKE) -C $$dir $@ || exit 1; done
	$(RM) -r $(RPMDIR) *.list
.PHONY: clean

install:
	install -d $(DESTDIR)
	@for dir in $(DIRS); do $(MAKE) -C $$dir DESTDIR=$(DESTDIR) $@ || exit 1; done
.PHONY: install

rpms:
	rpmbuild --define "_rpmdir $(RPMDIR)" -bb qubes-artwork.spec
#	rpm --addsign $(RPMDIR)/x86_64/qubes-artwork-*$(VERSION)*.rpm
.PHONY: rpms
