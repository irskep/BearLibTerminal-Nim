import dynlib
import blt_const
import blt_types

discard """
Notes:
- Whenever we have to pass ptr-type args, we have to create an explicit
  "result" value, because the built-in one doesn't seem to get marked
  correctly by the garbage collector.
"""

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

# Convenience

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