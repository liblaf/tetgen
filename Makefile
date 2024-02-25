NAME    := tetgen
SRC_DIR := tetgen1.6.0

RUNNER_OS   ?= $(shell uname -s)
RUNNER_ARCH ?= $(shell uname -m)

override RUNNER_OS   != echo "$(RUNNER_OS)" | tr '[:upper:]' '[:lower:]'
override RUNNER_ARCH != echo "$(RUNNER_ARCH)" | tr '[:upper:]' '[:lower:]'

EXE := $(if $(filter windows,$(RUNNER_OS)),.exe,)

default: $(SRC_DIR)/$(NAME)$(EXE)

clean:
	git clean -d --force -X

dist: dist/$(NAME)-$(RUNNER_OS)-$(RUNNER_ARCH)$(EXE)

#####################
# Auxiliary Targets #
#####################

$(SRC_DIR): tetgen1.6.0.tar.gz
	tar --extract --file="$<" --gzip --verbose

.PHONY: $(SRC_DIR)/$(NAME)$(EXE)
$(SRC_DIR)/$(NAME)$(EXE): $(SRC_DIR)
	$(MAKE) --directory="$<"

dist/$(NAME)-$(RUNNER_OS)-$(RUNNER_ARCH)$(EXE): $(SRC_DIR)/$(NAME)$(EXE)
	@ install -D --no-target-directory --verbose "$<" "$@"

tetgen1.6.0.tar.gz:
	wget --output-document="$@" "https://wias-berlin.de/software/tetgen/1.5/src/tetgen1.6.0.tar.gz"
