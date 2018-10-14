import dynlib

### CONSTANTS ###

# Keyboard scancodes for events/states
const TK_A*: int32 = 0x04
const TK_B*: int32 = 0x05
const TK_C*: int32 = 0x06
const TK_D*: int32 = 0x07
const TK_E*: int32 = 0x08
const TK_F*: int32 = 0x09
const TK_G*: int32 = 0x0A
const TK_H*: int32 = 0x0B
const TK_I*: int32 = 0x0C
const TK_J*: int32 = 0x0D
const TK_K*: int32 = 0x0E
const TK_L*: int32 = 0x0F
const TK_M*: int32 = 0x10
const TK_N*: int32 = 0x11
const TK_O*: int32 = 0x12
const TK_P*: int32 = 0x13
const TK_Q*: int32 = 0x14
const TK_R*: int32 = 0x15
const TK_S*: int32 = 0x16
const TK_T*: int32 = 0x17
const TK_U*: int32 = 0x18
const TK_V*: int32 = 0x19
const TK_W*: int32 = 0x1A
const TK_X*: int32 = 0x1B
const TK_Y*: int32 = 0x1C
const TK_Z*: int32 = 0x1D
const TK_1*: int32 = 0x1E
const TK_2*: int32 = 0x1F
const TK_3*: int32 = 0x20
const TK_4*: int32 = 0x21
const TK_5*: int32 = 0x22
const TK_6*: int32 = 0x23
const TK_7*: int32 = 0x24
const TK_8*: int32 = 0x25
const TK_9*: int32 = 0x26
const TK_0*: int32 = 0x27
const TK_RETURN*: int32 = 0x28
const TK_ENTER*: int32 = 0x28
const TK_ESCAPE*: int32 = 0x29
const TK_BACKSPACE*: int32 = 0x2A
const TK_TAB*: int32 = 0x2B
const TK_SPACE*: int32 = 0x2C
const TK_MINUS*: int32 = 0x2D
const TK_EQUALS*: int32 = 0x2E
const TK_LBRACKET*: int32 = 0x2F
const TK_RBRACKET*: int32 = 0x30
const TK_BACKSLASH*: int32 = 0x31
const TK_SEMICOLON*: int32 = 0x33
const TK_APOSTROPHE*: int32 = 0x34
const TK_GRAVE*: int32 = 0x35 # `
const TK_COMMA*: int32 = 0x36
const TK_PERIOD*: int32 = 0x37
const TK_SLASH*: int32 = 0x38
const TK_F1*: int32 = 0x3A
const TK_F2*: int32 = 0x3B
const TK_F3*: int32 = 0x3C
const TK_F4*: int32 = 0x3D
const TK_F5*: int32 = 0x3E
const TK_F6*: int32 = 0x3F
const TK_F7*: int32 = 0x40
const TK_F8*: int32 = 0x41
const TK_F9*: int32 = 0x42
const TK_F10*: int32 = 0x43
const TK_F11*: int32 = 0x44
const TK_F12*: int32 = 0x45
const TK_PAUSE*: int32 = 0x48 # Pause/Break
const TK_INSERT*: int32 = 0x49
const TK_HOME*: int32 = 0x4A
const TK_PAGEUP*: int32 = 0x4B
const TK_DELETE*: int32 = 0x4C
const TK_END*: int32 = 0x4D
const TK_PAGEDOWN*: int32 = 0x4E
const TK_RIGHT*: int32 = 0x4F # Right arrow
const TK_LEFT*: int32 = 0x50 # Left arrow
const TK_DOWN*: int32 = 0x51 # Down arrow
const TK_UP*: int32 = 0x52 # Up arrow
const TK_KP_DIVIDE*: int32 = 0x54 # '/' on numpad
const TK_KP_MULTIPLY*: int32 = 0x55 # '*' on numpad
const TK_KP_MINUS*: int32 = 0x56 # '-' on numpad
const TK_KP_PLUS*: int32 = 0x57 # '+' on numpad
const TK_KP_ENTER*: int32 = 0x58
const TK_KP_1*: int32 = 0x59
const TK_KP_2*: int32 = 0x5A
const TK_KP_3*: int32 = 0x5B
const TK_KP_4*: int32 = 0x5C
const TK_KP_5*: int32 = 0x5D
const TK_KP_6*: int32 = 0x5E
const TK_KP_7*: int32 = 0x5F
const TK_KP_8*: int32 = 0x60
const TK_KP_9*: int32 = 0x61
const TK_KP_0*: int32 = 0x62
const TK_KP_PERIOD*: int32 = 0x63 # '.' on numpad
const TK_SHIFT*: int32 = 0x70
const TK_CONTROL*: int32 = 0x71
const TK_ALT*: int32 = 0x72

# Mouse events/states
const TK_MOUSE_LEFT*: int32 = 0x80
const TK_MOUSE_RIGHT*: int32 = 0x81
const TK_MOUSE_MIDDLE*: int32 = 0x82
const TK_MOUSE_X1*: int32 = 0x83
const TK_MOUSE_X2*: int32 = 0x84
const TK_MOUSE_MOVE*: int32 = 0x85
const TK_MOUSE_SCROLL*: int32 = 0x86
const TK_MOUSE_X*: int32 = 0x87
const TK_MOUSE_Y*: int32 = 0x88
const TK_MOUSE_PIXEL_X*: int32 = 0x89
const TK_MOUSE_PIXEL_Y*: int32 = 0x8A
const TK_MOUSE_WHEEL*: int32 = 0x8B
const TK_MOUSE_CLICKS*: int32 = 0x8C

# If key was released instead of pressed, it's code will be OR'ed with TK_KEY_RELEASED:
# a) pressed 'A': 0x04
# b) released 'A': 0x04|VK_KEY_RELEASED = 0x104
const TK_KEY_RELEASED*: int32 = 0x100

# Virtual key-codes for internal terminal states/variables.
# These can be accessed via terminal_state function.
const TK_WIDTH*: int32 = 0xC0 # Terminal window size in cells
const TK_HEIGHT*: int32 = 0xC1
const TK_CELL_WIDTH*: int32 = 0xC2 # Character cell size in pixels
const TK_CELL_HEIGHT*: int32 = 0xC3
const TK_COLOR*: int32 = 0xC4 # Current foregroung color
const TK_BKCOLOR*: int32 = 0xC5 # Current background color
const TK_LAYER*: int32 = 0xC6 # Current layer
const TK_COMPOSITION*: int32 = 0xC7 # Current composition state
const TK_CHAR*: int32 = 0xC8 # Translated ANSI code of last produced character
const TK_WCHAR*: int32 = 0xC9 # Unicode codepoint of last produced character
const TK_EVENT*: int32 = 0xCA # Last dequeued event
const TK_FULLSCREEN*: int32 = 0xCB # Fullscreen state

# Other events
const TK_CLOSE*: int32 = 0xE0
const TK_RESIZED*: int32 = 0xE1

# Generic mode enum.
# Right now it is used for composition option only.
const TK_OFF*: int32 = 0
const TK_ON*: int32 = 1

# Input result codes for terminal_read function.
const TK_INPUT_NONE*: int32 = 0
const TK_INPUT_CANCELLED*: int32 = -1

# Text printing alignment.
const TK_ALIGN_DEFAULT*: int32 = 0
const TK_ALIGN_LEFT*: int32 = 1
const TK_ALIGN_RIGHT*: int32 = 2
const TK_ALIGN_CENTER*: int32 = 3
const TK_ALIGN_TOP*: int32 = 4
const TK_ALIGN_BOTTOM*: int32 = 8
const TK_ALIGN_MIDDLE*: int32 = 12

### TYPES ###

type BLInt* = int32
type BLColor* = uint32

type BLPoint* = ref object
  x*: BLInt
  y*: BLInt
proc newBLPoint*(x: BLInt, y: BLInt): BLPoint =
  BLPoint(x: x, y: y)

type BLSize* = ref object
  w*: BLInt
  h*: BLInt
proc newBLSize*(w: BLInt, h: BLInt): BLSize =
  BLSize(w: w, h: h)

type BLRect* = ref object
  x*: BLInt
  y*: BLInt
  w*: BLInt
  h*: BLInt
proc newBLRect*(x: BLInt, y: BLInt, w: BLInt, h: BLInt): BLRect =
  BLRect(x: x, y: y, w: w, h: h)

### C BRIDGES ###

#[
Note: Whenever we have to pass ptr-type args, we have to create an explicit
  result" value, because the built-in one doesn't seem to get marked
  correctly by the garbage collector.
]#

# {.deadCodeElim: on.}
when defined(windows):
  const libName = "libBearLibTerminal.dll"
  let lib = loadLib(libName)
elif defined(macosx):
  const libName = "libBearLibTerminal.dylib"
  let lib = loadLib(libName)
else:
  const libName = "libBearLibTerminal.so"
  let lib = loadLib(libName)

if lib == nil:
  echo "Can't load {libName}"
  quit(QuitFailure)

type dimensions_t = ref object
  width: BLInt
  height: BLInt

# Functions that can be bridged directly

proc terminalOpen*(): BLInt {.cdecl, importc: "terminal_open", dynlib: libName}
proc terminalClose*(): void {.cdecl, importc: "terminal_close", dynlib: libName}
proc terminalClear*(): void {.cdecl, importc: "terminal_clear", dynlib: libName}
proc terminalRefresh*(): void {.cdecl, importc: "terminal_refresh", dynlib: libName}
proc terminalRead*(): BLInt {.cdecl, importc: "terminal_read", dynlib: libName}
proc terminalPeek*(): BLInt {.cdecl, importc: "terminal_peek", dynlib: libName}
proc terminalSet*(configString: cstring): BLInt {.cdecl, importc: "terminal_set8", dynlib: libName}
proc terminalGet*(key: cstring, defaultValue: cstring): cstring {.cdecl, importc: "terminal_get8", dynlib: libName}
proc terminalState*(slot: BLInt): BLInt {.cdecl, importc: "terminal_state", dynlib: libName}
proc terminalDelay*(milliseconds: BLInt): void {.cdecl, importc: "terminal_delay", dynlib: libName}
proc terminalLayer*(layer: BLInt): void {.cdecl, importc: "terminal_layer", dynlib: libName}
proc terminalColor*(color: BLColor): void {.cdecl, importc: "terminal_color", dynlib: libName}
proc terminalBackgroundColor*(color: BLColor): void {.cdecl, importc: "terminal_bkcolor", dynlib: libName}
proc colorFromName*(name: cstring): BLColor {.cdecl, importc: "color_from_name8", dynlib: libName}

# Functions that need some glue code to be nimmy

proc terminalHasInputRaw(): BLInt {.cdecl, importc: "terminal_has_input", dynlib: libName}
proc terminalHasInput*(): bool =
  terminalHasInputRaw() != TK_OFF

proc terminalCompositionRaw(mode: BLInt): void {.cdecl, importc: "terminal_composition", dynlib: libName}
proc terminalComposition*(isOn: bool): void =
  terminalCompositionRaw(if isOn: TK_ON
                         else: TK_OFF)

proc terminalClearAreaRaw(x: BLInt, y: BLInt, w: BLInt, h: BLInt): void {.cdecl, importc: "terminal_clear_area", dynlib: libName}
proc terminalClearArea*(rect: BLRect): void =
  terminalClearAreaRaw(rect.x, rect.y, rect.w, rect.h)

proc terminalCropRaw(x: BLInt, y: BLInt, w: BLInt, h: BLInt): void {.cdecl, importc: "terminal_crop", dynlib: libName}
proc terminalCrop*(rect: BLRect): void =
  terminalCropRaw(rect.x, rect.y, rect.w, rect.h)

proc terminalMeasureExtRaw(inW: BLInt, inH: BLInt, stringToMeasure: cstring, outW: ptr BLInt, outH: ptr BLInt): void {.cdecl, importc: "terminal_measure_ext8", dynlib: libName}
proc terminalMeasure*(size: BLSize, stringToMeasure: cstring): BLSize =
  var finalSize = newBLSize(0, 0)
  terminalMeasureExtRaw(
    size.w,
    size.h,
    stringToMeasure,
    addr finalSize.w,
    addr finalSize.h)
  return finalSize

proc terminalPrintRaw(
    x: BLInt, y: BLInt, w: BLInt, h: BLInt, align: BLInt, s: cstring, outW: ptr BLInt, outH: ptr BLInt
    ): void {.cdecl, importc: "terminal_print_ext8", dynlib: libName}
proc terminalPrint*(rect: BLRect, align: BLInt, s: cstring): BLSize =
  var size = newBLSize(0, 0)  
  terminalPrintRaw(rect.x, rect.y, rect.w, rect.h, align, s, addr size.w, addr size.h)
  return size

proc terminalReadStringRaw(x: BLInt, y: BLInt, buffer: ptr int8, maxSize: BLInt): BLInt {.cdecl, importc: "terminal_read_str8", dynlib: libName}
proc terminalReadString*(point: BLPoint, maxSize: BLInt): string =
  var buffer = newSeq[int8](maxSize)
  let actualSize = terminalReadStringRaw(point.x, point.y, addr buffer[0], maxSize)
  result = newStringOfCap(actualSize)
  for ch in buffer[0..<actualSize]:
    add(result, char(ch))

proc terminalPutRaw(x: BLInt, y: BLInt, code: BLInt): void {.cdecl, importc: "terminal_put", dynlib: libName}
proc terminalPut*(point: BLPoint, code: BLInt): void =
  terminalPutRaw(point.x, point.y, code)

proc terminalPutExtRaw(x: BLInt, y: BLInt, dx: BLInt, dy: BLInt, code: BLInt, corners: ptr array[4, BLColor]): void {.cdecl, importc: "terminal_put_ext", dynlib: libName}
proc terminalPut*(point: BLPoint, deltaPoint: BLPoint, code: BLInt, cornerColors: array[4, BLColor]): void =
  var tmp: array[4, BLColor] = cornerColors
  terminalPutExtRaw(point.x, point.y, deltaPoint.x, deltaPoint.y, code, addr tmp)

proc terminalPickCodeRaw(x: BLInt, y: BLInt, index: BLInt): BLInt {.cdecl, importc: "terminal_pick", dynlib: libName}
proc terminalPickCode*(point: BLPoint, index: BLInt): BLInt =
  terminalPickCodeRaw(point.x, point.y, index)

proc terminalPickColorRaw(x: BLInt, y: BLInt, index: BLInt): BLColor {.cdecl, importc: "terminal_pick_color", dynlib: libName}
proc terminalPickColor*(point: BLPoint, index: BLInt): BLColor =
  terminalPickColorRaw(point.x, point.y, index)

proc terminalPickBackgroundColorRaw(x: BLInt, y: BLInt): BLColor {.cdecl, importc: "terminal_pick_bkcolor", dynlib: libName}
proc terminalPickBackgroundColor*(point: BLPoint): BLColor =
  terminalPickBackgroundColorRaw(point.x, point.y)

### CONVENIENCE FUNCTIONS ###

proc colorFromARGB*(a: uint8, r: uint8, g: uint8, b: uint8): BLColor =
  return (cast[BLColor](a) shl 24) or (cast[BLColor](r) shl 16) or (cast[BLColor](g) shl 8) or cast[BLColor](b)

proc terminalMeasure*(stringToMeasure: cstring): BLSize =
  terminalMeasure(newBLSize(0, 0), stringToMeasure)

proc terminalPrint*(rect: BLRect, s: cstring): BLSize =
  terminalPrint(rect, TK_ALIGN_DEFAULT, s)

proc terminalPrint*(point: BLPoint, s: cstring): BLSize =
  terminalPrint(newBLRect(point.x, point.y, 0, 0), TK_ALIGN_DEFAULT, s)

proc terminalCheck*(slot: BLInt): bool =
  terminalState(slot) != TK_OFF

proc terminalPickCode*(point: BLPoint): BLInt =
  terminalPickCode(point, 0)

proc terminalPickColor*(point: BLPoint): BLColor =
  terminalPickColor(point, 0)

proc terminalGetCurrentLayer*(): BLInt = terminalState(TK_LAYER)
proc terminalGetCurrentColor*(): BLColor = cast[BLColor](terminalState(TK_COLOR))
proc terminalGetCurrentBackgroundColor*(): BLColor = cast[BLColor](terminalState(TK_BKCOLOR))
proc terminalGetIsCompositionEnabled*(): bool = terminalCheck(TK_COMPOSITION)