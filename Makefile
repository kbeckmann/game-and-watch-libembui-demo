######################################
# building variables
######################################
# debug build?
DEBUG ?= 1
# optimization
OPT ?= -Og


#######################################
# paths
#######################################
# Build path
TARGET = libembui
BUILD_DIR ?= build_$(TARGET)

# Version and URL for the STM32CubeH7 SDK
SDK_VERSION ?= v1.8.0
SDK_URL ?= https://raw.githubusercontent.com/STMicroelectronics/STM32CubeH7

# Local path for the SDK
SDK_DIR ?= Drivers

DEBUG = 1

OPT = -O2 -ggdb

######################################
# source
######################################
# C sources
C_SOURCES =  \
Core/Src/gw_buttons.c \
Core/Src/gw_flash.c \
Core/Src/gw_lcd.c \
Core/Src/main.c \
Core/Src/stm32h7xx_hal_msp.c \
Core/Src/stm32h7xx_it.c \
Core/Src/system_stm32h7xx.c \
Core/Src/demo/embui_demo.c \
libembui/src/embui.c \

C_INCLUDES +=  \
-Ilibembui/src

C_DEFS += 


# SDK C sources
SDK_C_SOURCES =  \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_cortex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_exti.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_gpio.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_hsem.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_ltdc_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_ltdc.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_mdma.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_ospi.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rtc_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rtc.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_sai_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_sai.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_spi_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_spi.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim_ex.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim.c \
Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal.c \


# SDK ASM sources
SDK_ASM_SOURCES =  \
Drivers/CMSIS/Device/ST/STM32H7xx/Source/Templates/gcc/startup_stm32h7b0xx.s

# SDK headers
SDK_HEADERS = \
Drivers/CMSIS/Device/ST/STM32H7xx/Include/stm32h7b0xx.h \
Drivers/CMSIS/Device/ST/STM32H7xx/Include/stm32h7xx.h \
Drivers/CMSIS/Device/ST/STM32H7xx/Include/system_stm32h7xx.h \
Drivers/CMSIS/Include/cmsis_compiler.h \
Drivers/CMSIS/Include/cmsis_gcc.h \
Drivers/CMSIS/Include/cmsis_version.h \
Drivers/CMSIS/Include/core_cm7.h \
Drivers/CMSIS/Include/mpu_armv7.h \
Drivers/STM32H7xx_HAL_Driver/Inc/Legacy/stm32_hal_legacy.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_cortex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_def.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_dma_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_dma.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_exti.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_flash_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_flash.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_gpio_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_gpio.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_hsem.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_i2c_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_i2c.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_ltdc_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_ltdc.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_mdma.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_ospi.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_pwr_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_pwr.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_rcc_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_rcc.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_rtc_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_rtc.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_sai_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_sai.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_spi_ex.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal_spi.h \
Drivers/STM32H7xx_HAL_Driver/Inc/stm32h7xx_hal.h \


#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
# either it can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S

#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m7

# fpu
FPU = -mfpu=fpv5-d16

# float-abi
FLOAT-ABI = -mfloat-abi=hard

# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# macros for gcc
# AS defines
AS_DEFS +=

# C defines
C_DEFS +=  \
-DUSE_HAL_DRIVER \
-DSTM32H7B0xx \
-DVECT_TAB_ITCM \
-DIS_LITTLE_ENDIAN \
-D_FORTIFY_SOURCE=1 \


# AS includes
AS_INCLUDES +=

# C includes
C_INCLUDES +=  \
-ICore/Inc \
-IDrivers/STM32H7xx_HAL_Driver/Inc \
-IDrivers/STM32H7xx_HAL_Driver/Inc/Legacy \
-IDrivers/CMSIS/Device/ST/STM32H7xx/Include \
-IDrivers/CMSIS/Include \


# compile gcc flags
ASFLAGS += $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS += $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT ?= STM32H7B0VBTx_FLASH.ld

# libraries
LIBS = -lc -lm -lnosys
LIBDIR +=
LDFLAGS += $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET)_extflash.bin

#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o) $(SDK_C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES) $(SDK_C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(SDK_ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(SDK_ASM_SOURCES)))

# function used to generate prerequisite rules for SDK objects
define sdk_obj_prereq_gen
$(BUILD_DIR)/$(patsubst %.c,%.o,$(patsubst %.s,%.o,$(notdir $1))): $1

endef
# note: the blank line above is intentional

# generate all object prerequisite rules
$(eval $(foreach obj,$(SDK_C_SOURCES) $(SDK_ASM_SOURCES),$(call sdk_obj_prereq_gen,$(obj))))

$(BUILD_DIR)/%.o: %.c Makefile $(LDSCRIPT) $(SDK_HEADERS) | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile $(LDSCRIPT) | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile $(LDSCRIPT)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@
	./size.sh $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@

$(BUILD_DIR):
	mkdir $@


$(BUILD_DIR)/$(TARGET)_extflash.bin: $(BUILD_DIR)/$(TARGET).elf | $(BUILD_DIR)
	$(BIN) -j ._ram_exec -j ._extflash $< $(BUILD_DIR)/$(TARGET)_extflash.bin


#######################################
# Flashing
#######################################

OPENOCD ?= openocd
ADAPTER ?= stlink
FLSHLD_DIR ?= ../game-and-watch-flashloader
FLASHLOADER ?= $(FLSHLD_DIR)/flash_multi.sh

# Starts openocd and attaches to the target. To be used with 'flashx' and 'gdb'
openocd:
	$(OPENOCD) -f $(FLSHLD_DIR)/interface_$(ADAPTER).cfg -c "init; halt"
.PHONY: openocd


# Flashes using a new openocd instance
flash: $(BUILD_DIR)/$(TARGET).elf
	$(OPENOCD) -f $(FLSHLD_DIR)/interface_$(ADAPTER).cfg -c "program $(BUILD_DIR)/$(TARGET).elf reset exit"
.PHONY: flash


# Flash without building or so
jflash:
	$(OPENOCD) -f $(FLSHLD_DIR)/interface_$(ADAPTER).cfg -c "program $(BUILD_DIR)/$(TARGET).elf reset exit"
.PHONY: jflash


# Flashes using an existing openocd instance
flashx: $(BUILD_DIR)/$(TARGET).elf
	echo "program $(BUILD_DIR)/$(TARGET).elf; reset run; exit" | nc localhost 4444
.PHONY: flashx


flash_extmem: $(BUILD_DIR)/$(TARGET)_extflash.bin
	$(FLASHLOADER) $(BUILD_DIR)/$(TARGET)_extflash.bin
.PHONY: flash_extmem


# Programs both the external and internal flash.
flash_all:
	$(V)$(MAKE) flash_extmem
	$(V)$(MAKE) flash
.PHONY: flash_all


GDB ?= $(PREFIX)gdb
gdb: $(BUILD_DIR)/$(TARGET).elf
	$(GDB) $< -ex "target extended-remote :3333"
.PHONY: gdb


#######################################
# download SDK files
#######################################
$(SDK_DIR)/%:
	wget $(SDK_URL)/$(SDK_VERSION)/$@ -P $(dir $@)

.PHONY: download_sdk
download_sdk: $(SDK_HEADERS) $(SDK_C_SOURCES) $(SDK_ASM_SOURCES)

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)

distclean: clean
	rm -rf $(SDK_DIR)

#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***
