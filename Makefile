STAMPS := stamps
STAMP_DEPS := $(STAMPS)/stamp-deps
STAMP_COMPILE := $(STAMPS)/stamp-compile
STAMP_GENERATE := $(STAMPS)/stamp-generate

ALLFILES := $(shell find * -xdev \
        -name .svn -prune \
        -o -name '* *' -prune \
        -o -path $(PLAT_TMP) -prune \
        -o -name '*\#*' -prune \
        -o -xtype f -print)

ALLFILES := $(sort $(ALLFILES) $(ALL_GENERATED))
APP_SOURCE := $(filter apps/%.app.src, $(ALLFILES))
ERL_SOURCE := $(filter apps/%.erl, $(ALLFILES))
ERL_HEADER := $(filter apps/%.hrl, $(ALLFILES))

$(STAMP_DEPS): rebar.config
	rebar get-deps
	@mkdir -p $(@D)
	touch $@

deps: $(STAMP_DEPS)

$(STAMP_COMPILE): $(STAMP_DEPS) $(APP_SOURCE) $(ERL_SOURCE)
	rebar compile
	@mkdir -p $(@D)
	touch $@

compile: $(STAMP_COMPILE)

$(STAMP_GENERATE): $(STAMP_COMPILE) rel/reltool.config
	rebar generate
	@mkdir -p $(@D)
	touch $@

generate: $(STAMP_GENERATE)

run: $(STAMP_GENERATE)
	rel/thana/bin/thana console

clean:
	rebar clean
	rm -rf $(STAMPS) deps

.PHONY: clean compile generate run deps
