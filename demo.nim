import bearlibterminal

when (compiles do: import rexpaint):
  # REXPaintImage + BearLibTerminal (ignore this block if you don't care about REXPaint)

  # You might want to copy/paste these into your own code if you're using
  # both REXPaint and BearLibTerminal.
  import rexpaint

  proc get*(image: REXPaintImage, layer: int, point: BLPoint): REXPaintCell =
    return image.layers[layer][point.x.int * int(image.height) + point.y.int]

  proc bltForegroundColor*(cell: REXPaintCell): BLColor =
    return colorFromARGB(255, cell.fgColor[0], cell.fgColor[1], cell.fgColor[2])

  proc bltBackgroundColor*(cell: REXPaintCell): BLColor =
    return colorFromARGB(255, cell.bgColor[0], cell.bgColor[1], cell.bgColor[2])

  proc renderToBearLibTerminal*(image: REXPaintImage, offset: BLPoint) =
    const transparentColor: (uint8, uint8, uint8) = (255.uint8, 0.uint8, 255.uint8)
    let wasCompositing = terminalGetIsCompositionEnabled()
    if image.layers.len > 1:
      terminalComposition(true)
    let originalBG = terminalGetCurrentBackgroundColor()
    for layer in 0..<image.layers.len:
      for y in 0..<image.height:
        for x in 0..<image.width:
          let cell = image.get(layer, x, y)
          if cell.code == 0:
            continue
          terminalColor(cell.bltForegroundColor)
          if cell.bgColor == transparentColor:
            terminalBackgroundColor(originalBG)
          else:
            terminalBackgroundColor(cell.bltBackgroundColor)
          terminalPut(newBLPoint(offset.x.int32 + x.int32, offset.y .int32 + y.int32), cell.code)
    terminalComposition(wasCompositing)

when isMainModule:
  # Do some basic bearlibterminal stuff
  discard terminalOpen()
  discard terminalSet("""
  window: size=30x10;
  input.filter=[keyboard,mouse];
  font: cp437_10x10.png, size=10x10;
  """)
  echo "BearLibTerminal version: ", terminalGet("version", "???")
  let printSize = terminalPrint(newBLRect(0, 0, 4, 4), TK_ALIGN_LEFT, "ooga booga")
  echo "size of printed text ", printSize.w, " ", printSize.h

  when (compiles do: import rexpaint):
    # if you have the rexpaint module installed, you can render rexpaint
    # images using the code earlier in the file
    let image = newREXPaintImage("xptest.xp")
    echo image
    image.renderToBearLibTerminal(newBLPoint(0, 0))

  terminalRefresh()

  # you could have the user enter a string if you wanted:
  # echo "your string: ", terminalReadString(newBLPoint(0, 0), 4)

  while terminalRead() != TK_CLOSE:
    echo terminalCheck(TK_RETURN)
    discard

  # call the clear function because why not
  terminalClearArea(newBLRect(0, 0, 1, 1))

  terminalClose()