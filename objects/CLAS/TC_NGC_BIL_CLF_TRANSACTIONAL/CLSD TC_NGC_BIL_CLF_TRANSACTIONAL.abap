class-pool .
*"* class pool for class TC_NGC_BIL_CLF_TRANSACTIONAL

*"* local type definitions
include TC_NGC_BIL_CLF_TRANSACTIONAL==ccdef.

*"* class TC_NGC_BIL_CLF_TRANSACTIONAL definition
*"* public declarations
  include TC_NGC_BIL_CLF_TRANSACTIONAL==cu.
*"* protected declarations
  include TC_NGC_BIL_CLF_TRANSACTIONAL==co.
*"* private declarations
  include TC_NGC_BIL_CLF_TRANSACTIONAL==ci.
endclass. "TC_NGC_BIL_CLF_TRANSACTIONAL definition

*"* macro definitions
include TC_NGC_BIL_CLF_TRANSACTIONAL==ccmac.
*"* local class implementation
include TC_NGC_BIL_CLF_TRANSACTIONAL==ccimp.

*"* test class
include TC_NGC_BIL_CLF_TRANSACTIONAL==ccau.

class TC_NGC_BIL_CLF_TRANSACTIONAL implementation.
*"* method's implementations
  include methods.
endclass. "TC_NGC_BIL_CLF_TRANSACTIONAL implementation
