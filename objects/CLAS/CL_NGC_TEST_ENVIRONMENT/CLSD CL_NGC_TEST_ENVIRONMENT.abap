class-pool .
*"* class pool for class CL_NGC_TEST_ENVIRONMENT

*"* local type definitions
include CL_NGC_TEST_ENVIRONMENT=======ccdef.

*"* class CL_NGC_TEST_ENVIRONMENT definition
*"* public declarations
  include CL_NGC_TEST_ENVIRONMENT=======cu.
*"* protected declarations
  include CL_NGC_TEST_ENVIRONMENT=======co.
*"* private declarations
  include CL_NGC_TEST_ENVIRONMENT=======ci.
endclass. "CL_NGC_TEST_ENVIRONMENT definition

*"* macro definitions
include CL_NGC_TEST_ENVIRONMENT=======ccmac.
*"* local class implementation
include CL_NGC_TEST_ENVIRONMENT=======ccimp.

*"* test class
include CL_NGC_TEST_ENVIRONMENT=======ccau.

class CL_NGC_TEST_ENVIRONMENT implementation.
*"* method's implementations
  include methods.
endclass. "CL_NGC_TEST_ENVIRONMENT implementation
