class-pool .
*"* class pool for class ZTESTFEF

*"* local type definitions
include ZTESTFEF======================ccdef.

*"* class ZTESTFEF definition
*"* public declarations
  include ZTESTFEF======================cu.
*"* protected declarations
  include ZTESTFEF======================co.
*"* private declarations
  include ZTESTFEF======================ci.
endclass. "ZTESTFEF definition

*"* macro definitions
include ZTESTFEF======================ccmac.
*"* local class implementation
include ZTESTFEF======================ccimp.

*"* test class
include ZTESTFEF======================ccau.

class ZTESTFEF implementation.
*"* method's implementations
  include methods.
endclass. "ZTESTFEF implementation
