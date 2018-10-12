# BearLibTerminal-Nim

This is a port of [BearLibTerminal](http://foo.wyrd.name/en%3Abearlibterminal%3Areference) to Nim.

All functions are identical to the C versions, except:
* `int` is aliased to `BLInt`
* `uint32` is aliased to `BLColor`
* `x, y, w, h` is passed as a single `BLRect`
* `x, y` is passed as a single `BLPoint`
* `w, h` is passed as a single `BLSize`
* Return values of `TK_ON`/`TK_OFF` are converted to `bool`
* Functions requiring mutable pointers for multiple return values are wrapped to return appropriate types (`string`, `BLSize`)

The library also includes some bonus functions to save you some unsafe bit casts:

```nim
proc terminalGetCurrentLayer*(): BLInt = terminalState(TK_LAYER)
proc terminalGetCurrentColor*(): BLColor = cast[BLColor](terminalState(TK_COLOR))
proc terminalGetCurrentBackgroundColor*(): BLColor = cast[BLColor](terminalState(TK_BKCOLOR))
proc terminalGetIsCompositionEnabled*(): bool = terminalCheck(TK_COMPOSITION)
```