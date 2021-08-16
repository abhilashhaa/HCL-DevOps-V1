class-pool .
*"* class pool for class TC_NGC_BIL_CLS_TRANSACTIONAL

*"* local type definitions
include TC_NGC_BIL_CLS_TRANSACTIONAL==ccdef.

*"* class TC_NGC_BIL_CLS_TRANSACTIONAL definition
*"* public declarations
  include TC_NGC_BIL_CLS_TRANSACTIONAL==cu.
*"* protected declarations
  include TC_NGC_BIL_CLS_TRANSACTIONAL==co.
*"* private declarations
  include TC_NGC_BIL_CLS_TRANSACTIONAL==ci.
endclass. "TC_NGC_BIL_CLS_TRANSACTIONAL definition

*"* macro definitions
include TC_NGC_BIL_CLS_TRANSACTIONAL==ccmac.
*"* local class implementation
include TC_NGC_BIL_CLS_TRANSACTIONAL==ccimp.

*"* test class
include TC_NGC_BIL_CLS_TRANSACTIONAL==ccau.

class TC_NGC_BIL_CLS_TRANSACTIONAL implementation.
*"* method's implementations
  include methods.
endclass. "TC_NGC_BIL_CLS_TRANSACTIONAL implementation
