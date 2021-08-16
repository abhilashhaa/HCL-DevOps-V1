class-pool .
*"* class pool for class TC_I_CLFNCLASS

*"* local type definitions
include TC_I_CLFNCLASS================ccdef.

*"* class TC_I_CLFNCLASS definition
*"* public declarations
  include TC_I_CLFNCLASS================cu.
*"* protected declarations
  include TC_I_CLFNCLASS================co.
*"* private declarations
  include TC_I_CLFNCLASS================ci.
endclass. "TC_I_CLFNCLASS definition

*"* macro definitions
include TC_I_CLFNCLASS================ccmac.
*"* local class implementation
include TC_I_CLFNCLASS================ccimp.

*"* test class
include TC_I_CLFNCLASS================ccau.

class TC_I_CLFNCLASS implementation.
*"* method's implementations
  include methods.
endclass. "TC_I_CLFNCLASS implementation
