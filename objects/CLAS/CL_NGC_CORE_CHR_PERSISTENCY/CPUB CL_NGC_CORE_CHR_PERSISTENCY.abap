class CL_NGC_CORE_CHR_PERSISTENCY definition
  public
  final
  create public

  global friends TC_NGC_CORE_CHR_PERS_BASE .

public section.

  interfaces IF_NGC_CORE_CHR_PERSISTENCY .

  methods CONSTRUCTOR
    importing
      !IO_CORE_UTIL type ref to IF_NGC_CORE_UTIL
      !IO_CHR_UTIL_CHCKTABLE type ref to IF_NGC_CORE_CHR_UTIL_CHCKTABLE
      !IO_CHR_UTIL_FUNCMOD type ref to IF_NGC_CORE_CHR_UTIL_FUNCMOD .