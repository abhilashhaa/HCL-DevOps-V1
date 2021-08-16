class-pool .
*"* class pool for class TC_I_CLFNOBJECTCLASS

*"* local type definitions
include TC_I_CLFNOBJECTCLASS==========ccdef.

*"* class TC_I_CLFNOBJECTCLASS definition
*"* public declarations
  include TC_I_CLFNOBJECTCLASS==========cu.
*"* protected declarations
  include TC_I_CLFNOBJECTCLASS==========co.
*"* private declarations
  include TC_I_CLFNOBJECTCLASS==========ci.
endclass. "TC_I_CLFNOBJECTCLASS definition

*"* macro definitions
include TC_I_CLFNOBJECTCLASS==========ccmac.
*"* local class implementation
include TC_I_CLFNOBJECTCLASS==========ccimp.

*"* test class
include TC_I_CLFNOBJECTCLASS==========ccau.

class TC_I_CLFNOBJECTCLASS implementation.
*"* method's implementations
  include methods.
endclass. "TC_I_CLFNOBJECTCLASS implementation
