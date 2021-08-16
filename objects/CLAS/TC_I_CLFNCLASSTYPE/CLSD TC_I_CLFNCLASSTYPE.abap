class-pool .
*"* class pool for class TC_I_CLFNCLASSTYPE

*"* local type definitions
include TC_I_CLFNCLASSTYPE============ccdef.

*"* class TC_I_CLFNCLASSTYPE definition
*"* public declarations
  include TC_I_CLFNCLASSTYPE============cu.
*"* protected declarations
  include TC_I_CLFNCLASSTYPE============co.
*"* private declarations
  include TC_I_CLFNCLASSTYPE============ci.
endclass. "TC_I_CLFNCLASSTYPE definition

*"* macro definitions
include TC_I_CLFNCLASSTYPE============ccmac.
*"* local class implementation
include TC_I_CLFNCLASSTYPE============ccimp.

*"* test class
include TC_I_CLFNCLASSTYPE============ccau.

class TC_I_CLFNCLASSTYPE implementation.
*"* method's implementations
  include methods.
endclass. "TC_I_CLFNCLASSTYPE implementation
