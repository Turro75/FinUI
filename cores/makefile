# this logic was broken out from picoarch's all-in-one makefile

CORES = fceumm gambatte gpsp pcsx_rearmed picodrive snes9x2005_plus
CORES+= beetle-pce-fast mednafen_supafaust mgba puae beetle-vb fake-08 pokemini race fbneo mame2003-plus prboom retroarch

ifeq ($(FBABI), softfp)
CORES = snes9x2005_plus retroarch
endif

###############################

# optional core vars
# *_REPO=
# *_HASH=
# *_CORE=
# *_FLAGS=
# *_MAKEFILE=
# *_BUILD_PATH=

beetle-pce-fast_REPO = https://github.com/libretro/beetle-pce-fast-libretro
beetle-pce-fast_CORE = mednafen_pce_fast_libretro.so

beetle-vb_REPO = https://github.com/libretro/beetle-vb-libretro
beetle-vb_CORE = mednafen_vb_libretro.so

fake-08_REPO = https://github.com/jtothebell/fake-08
fake-08_CORE = fake08_libretro.so
fake-08_BUILD_PATH = fake-08/platform/libretro

fceumm_REPO = https://github.com/libretro/libretro-fceumm

gambatte_REPO = https://github.com/libretro/gambatte-libretro

#gpsp_HASH = 1d1c719 # last known working save states

mednafen_supafaust_REPO = https://github.com/libretro/supafaust

pcsx_rearmed_MAKEFILE = Makefile.libretro
pcsx_rearmed_HASH = 1fec8a9

picodrive_REPO = https://github.com/irixxxx/picodrive
picodrive_MAKEFILE = Makefile.libretro

pokemini_REPO = https://github.com/libretro/PokeMini
pokemini_MAKEFILE = Makefile.libretro

snes9x2005_plus_REPO = https://github.com/libretro/snes9x2005
snes9x2005_plus_FLAGS = USE_BLARGG_APU=1

mame2003-plus_REPO = https://github.com/libretro/mame2003-plus-libretro
mame2003-plus_CORE = mame2003_plus_libretro.so

fbneo_REPO = https://github.com/libretro/fbneo
fbneo_CORE = fbneo_libretro.so
#same version as garlicos
#fbneo_HASH = db9f7e9
fbneo_BUILD_PATH = fbneo/src/burner/libretro

prboom_REPO = https://github.com/libretro/libretro-prboom
prboom_CORE = prboom_libretro.so

retroarch_REPO = https://github.com/libretro/RetroArch
retroarch_CORE = retroarch.elf
#retroarch 1.14
retroarch_HASH = ad89b0c
#retroarch 1.15
#retroarch_HASH = 6616b80
retroarch_MAKEFILE = Makefile.rg35xx

puae_REPO = https://github.com/libretro/libretro-uae
puae_BR = 2.6.1
puae_CORE = puae2021_libretro.so

###############################

PATCH = git apply
PROCS = -j4 
ifeq ($(FBABI), softfp)
PROCS = -j1
endif


###############################

define TEMPLATE=

$1_REPO ?= https://github.com/libretro/$(1)
$1_MAKE ?= make $(and $($1_MAKEFILE),-f $($1_MAKEFILE)) platform=$(UNION_PLATFORM) $($(1)_FLAGS)
$1_BUILD_PATH ?= $(1)

src/$(1):
	mkdir -p src
	cd src && git clone $(if $($1_HASH),,--depth 1) --recursive $$($(1)_REPO) $(if $($1_BR),--branch $($1_BR),) $(1)
	$(if $($1_HASH),cd src/$$($1_BUILD_PATH) && git checkout $($1_HASH) && echo $($1_HASH),)

src/$(1)/.patched: src/$(1)
	(test ! -f patches/$(1).patch) || (test -f src/$(1)/.patched) || (cd src/$(1) && $(PATCH) -p1 < ../../patches/$(1).patch && touch .patched && true)

output/$(1)_libretro.so: src/$(1)/.patched
	mkdir -p output
	cd src/$$($1_BUILD_PATH) && $$($1_MAKE) $(PROCS)
	cp src/$$($1_BUILD_PATH)/$(if $($(1)_CORE),$($(1)_CORE),$(1)_libretro.so) ./output

clone-$(1): src/$(1)

patch-$(1): src/$(1)/.patched

clean-$(1):
	cd src/$$($(1)_BUILD_PATH) && $$($(1)_MAKE) clean

$(1): output/$(1)_libretro.so

endef

###############################

all: cores

$(foreach CORE,$(CORES),$(eval $(call TEMPLATE,$(CORE))))

cores: $(foreach CORE,$(CORES),$(CORE))

CLEANCORES = $(addprefix clean-,$(CORES))

clean: $(CLEANCORES)
	rm -rf ./output

nuke:
	rm -rf ./output
	rm -rf ./src
