class-pool .
*"* class pool for class ZMAT_DETAIL

*"* local type definitions
include ZMAT_DETAIL===================ccdef.

*"* class ZMAT_DETAIL definition
*"* public declarations
  include ZMAT_DETAIL===================cu.
*"* protected declarations
  include ZMAT_DETAIL===================co.
*"* private declarations
  include ZMAT_DETAIL===================ci.
endclass. "ZMAT_DETAIL definition

*"* macro definitions
include ZMAT_DETAIL===================ccmac.
*"* local class implementation
include ZMAT_DETAIL===================ccimp.

*"* test class
include ZMAT_DETAIL===================ccau.

class ZMAT_DETAIL implementation.
*"* method's implementations
  include methods.
endclass. "ZMAT_DETAIL implementation
