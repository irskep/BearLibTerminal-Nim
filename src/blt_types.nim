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