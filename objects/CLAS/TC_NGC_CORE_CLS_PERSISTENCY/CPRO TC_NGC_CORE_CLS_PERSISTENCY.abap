protected section.

  data MO_CUT type ref to CL_NGC_CORE_CLS_PERSISTENCY .
  class-data GO_SQL_ENVIRONMENT type ref to IF_OSQL_TEST_ENVIRONMENT .

  methods READ_EMPTY_EXTERNAL
  for testing .
  methods READ_EMPTY_INTERNAL
  for testing .
  methods READ_EXTERNAL_KEY
  for testing .
  methods READ_INTERNAL_KEY
  for testing .
  methods READ_EXTERNAL_KEY_OVERWRITE
  for testing .
  methods READ_INTERNAL_KEY_OVERWRITE
  for testing .
  methods READ_EXTERNAL_KEY_INHERIT
  for testing .
  methods READ_INTERNAL_KEY_INHERIT
  for testing .
  methods READ_CLASS_STATUS
  for testing .
  methods READ_CLASS_STATUSES
  for testing .
  methods CLEANUP
  for testing .