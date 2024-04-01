#
#	DinguxCommander Makefile for RG35xx garlic
#

CXX := $(CROSS_COMPILE)g++
CXXFLAGS := -Os -marm -mtune=cortex-a9 -mfpu=neon-fp16 -mfloat-abi=${FBABI} -march=armv7-a
SDL_CONFIG := $(PREFIX)/bin/sdl-config
CXXFLAGS += $(shell $(SDL_CONFIG) --cflags) -I$(PREFIX)/include/SDL -I./

CXXFLAGS += -DPATH_DEFAULT=\"/mnt/sdcard\"
CXXFLAGS += -DFILE_SYSTEM=\"/dev/block/mmcblk1\"
CXXFLAGS += -DCMDR_KEY_UP=SDLK_KATAKANA
CXXFLAGS += -DCMDR_KEY_RIGHT=SDLK_KATAKANAHIRAGANA
CXXFLAGS += -DCMDR_KEY_DOWN=SDLK_HIRAGANA
CXXFLAGS += -DCMDR_KEY_LEFT=SDLK_HENKAN
CXXFLAGS += -DCMDR_KEY_OPEN=SDLK_MUHENKAN	# A
CXXFLAGS += -DCMDR_KEY_PARENT=SDLK_KP_JPCOMMA		# B
CXXFLAGS += -DCMDR_KEY_OPERATION=SDLK_KP_ENTER	# X
CXXFLAGS += -DCMDR_KEY_SYSTEM=SDLK_RCTRL		# Y
CXXFLAGS += -DCMDR_KEY_PAGEUP=SDLK_RALT		# L1 / L2 = SDLK_j
CXXFLAGS += -DCMDR_KEY_PAGEDOWN=SDLK_BREAK		# R1 / R2 = SDLK_k
CXXFLAGS += -DCMDR_KEY_SELECT=SDLK_PRINT		# SELECT
CXXFLAGS += -DCMDR_KEY_TRANSFER=SDLK_KP_DIVIDE		# START
CXXFLAGS += -DCMDR_KEY_MENU=SDLK_PAGEUP	# MENU (added)
CXXFLAGS += -DOSK_KEY_SYSTEM_IS_BACKSPACE=ON
CXXFLAGS += -DSCREEN_WIDTH=640
CXXFLAGS += -DSCREEN_HEIGHT=480
CXXFLAGS += -DPPU_X=1.666666
CXXFLAGS += -DPPU_Y=1.666666
CXXFLAGS += -DAUTOSCALE=0
CXXFLAGS += -DSCREEN_BPP=16
CXXFLAGS += -DFONTS='{"FreeSans.ttf",18}'
#CXXFLAGS += -DFONTS='{"FreeSans.ttf",18},{"DroidSansFallback.ttf",15},{"/mnt/mmc/CFW/skin/font.ttf",14}'
#CXXFLAGS += -DLOW_DPI_FONTS='{"Fiery_Turk.ttf",8},{"/mnt/mmc/CFW/skin/font.ttf",9}'

RESDIR := res
CXXFLAGS += -DRESDIR="\"$(RESDIR)\""

LINKFLAGS += -s
LINKFLAGS += $(shell $(SDL_CONFIG) --libs) -lSDL_image -lSDL_ttf

CMD := @
SUM := @echo

OUTDIR := ./output

EXECUTABLE := $(OUTDIR)/DinguxCommander.elf

OBJS :=	main.o commander.o config.o dialog.o fileLister.o fileutils.o keyboard.o panel.o resourceManager.o \
	screen.o sdl_ttf_multifont.o sdlutils.o text_edit.o utf8.o text_viewer.o image_viewer.o  window.o \
	SDL_rotozoom.o

DEPFILES := $(patsubst %.o,$(OUTDIR)/%.d,$(OBJS))

.PHONY: all clean

all: $(EXECUTABLE)

$(EXECUTABLE): $(addprefix $(OUTDIR)/,$(OBJS))
	$(SUM) "  LINK    $@"
	$(CMD)$(CXX) $(LINKFLAGS) -o $@ $^

$(OUTDIR)/%.o: src/%.cpp
	@mkdir -p $(@D)
	$(SUM) "  CXX     $@"
	$(CMD)$(CXX) $(CXXFLAGS) -MP -MMD -MF $(@:%.o=%.d) -c $< -o $@
	@touch $@ # Force .o file to be newer than .d file.

$(OUTDIR)/%.o: src/%.c
	@mkdir -p $(@D)
	$(SUM) "  CXX     $@"
	$(CMD)$(CXX) $(CXXFLAGS) -MP -MMD -MF $(@:%.o=%.d) -c $< -o $@
	@touch $@ # Force .o file to be newer than .d file.

clean:
	$(SUM) "  RM      $(OUTDIR)"
	$(CMD)rm -rf $(OUTDIR)

# Load dependency files.
-include $(DEPFILES)

# Generate dependencies that do not exist yet.
# This is only in case some .d files have been deleted;
# in normal operation this rule is never triggered.
$(DEPFILES):
