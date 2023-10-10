NAME := tetgen

SYSTEM  != python -c "import platform; print(platform.system().lower())"
MACHINE != python -c "import platform; print(platform.machine().lower())"

SRC_DIR      := tetgen1.6.0
DIST_DIR := dist

ifeq ($(SYSTEM), windows)
  EXE := .exe
else
  EXE :=
endif
TARGET      := $(SRC_DIR)/$(NAME)$(EXE)
TARGET_DIST := $(DIST_DIR)/$(NAME)-$(SYSTEM)-$(MACHINE)$(EXE)

all: $(TARGET)

clean:
	@ $(RM) --recursive --verbose $(DIST_DIR)
	@ $(RM) --recursive --verbose $(SRC_DIR)
	@ $(RM) --verbose tetgen1.6.0.tar.gz

dist: $(TARGET_DIST)

#####################
# Auxiliary Targets #
#####################

tetgen1.6.0.tar.gz:
	wget --output-document=$@ https://wias-berlin.de/software/tetgen/1.5/src/$(@F)

$(TARGET): tetgen1.6.0.tar.gz
	tar --extract --file=$< --gzip
	$(MAKE) --directory=$(SRC_DIR)

$(TARGET_DIST): $(TARGET)
	@ mkdir -p -v $(@D)
	@ cp -f -v $< $@
