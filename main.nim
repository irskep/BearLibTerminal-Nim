import blt_const
import blt_funcs
import blt_types

when isMainModule:
  discard terminalOpen()
  discard terminalSet("window: size=30x10;")
  let printSize = terminalPrint(newBLRect(0, 0, 4, 4), TK_ALIGN_LEFT, "ooga booga")
  echo "print size ", printSize.w, " ", printSize.h
  terminalRefresh()
  # echo "your string: ", terminalReadString(newBLPoint(0, 0), 4)
  discard terminalRead()
  echo terminalCheck(TK_RETURN)
  terminalClearArea(newBLRect(0, 0, 1, 1))
  let size: BLSize = terminalMeasure(newBLSize(4, 4), "ooga booga")
  echo "measure size ", size.w, " ", size.h
  terminalClose()