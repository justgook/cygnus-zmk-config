.PHONY: init update build build-left build-right settings-reset clean distclean

# BOARD ?= promicro_nrf52840/nrf52840/uf2/zmk
BOARD ?= nice_nano@1.0.0/nrf52840/zmk

# Put Nix's Python env first so /usr/bin/env python3 used by nanopb sees Python packages.
PYTHON_BIN := $(dir $(shell command -v python))
PYTHON_SITE := $(shell python -c 'import site; print(site.getsitepackages()[0])')
export PATH := $(PYTHON_BIN):$(PATH)
export PYTHONPATH := $(PYTHON_SITE):$(PYTHONPATH)
ZMK_CONFIG ?= $(CURDIR)/config
BUILD_DIR ?= build

CMAKE_ARGS = -DZMK_CONFIG=$(ZMK_CONFIG) -DBOARD_ROOT=$(CURDIR) -DSHIELD_ROOT=$(CURDIR)

init:
	@test -d .west || west init -l config

update: init
	west update

build: build-left build-right

build-left: update
	west build -s zmk/app -d $(BUILD_DIR)/cygnus_left -b '$(BOARD)' -- -DSHIELD=cygnus_left $(CMAKE_ARGS)

build-right: update
	west build -s zmk/app -d $(BUILD_DIR)/cygnus_right -b '$(BOARD)' -- -DSHIELD=cygnus_right $(CMAKE_ARGS)

settings-reset: update
	west build -s zmk/app -d $(BUILD_DIR)/settings_reset -b '$(BOARD)' -- -DSHIELD=settings_reset $(CMAKE_ARGS)

clean:
	rm -rf $(BUILD_DIR)/cygnus_left $(BUILD_DIR)/cygnus_right $(BUILD_DIR)/settings_reset

distclean: clean
	rm -rf .west zmk zephyr modules bootloader tools
