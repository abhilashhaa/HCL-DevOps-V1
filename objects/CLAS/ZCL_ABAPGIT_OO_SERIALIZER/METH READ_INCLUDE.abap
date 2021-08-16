  METHOD read_include.

    DATA: ls_include TYPE progstruc.


    ASSERT iv_type = seop_ext_class_locals_def
      OR iv_type = seop_ext_class_locals_imp
      OR iv_type = seop_ext_class_macros
      OR iv_type = seop_ext_class_testclasses.

    ls_include-rootname = is_clskey-clsname.
    TRANSLATE ls_include-rootname USING ' ='.
    ls_include-categorya = iv_type(1).
    ls_include-codea = iv_type+1(4).

* it looks like there is an issue in function module SEO_CLASS_GET_INCLUDE_SOURCE
* on 750 kernels, where the READ REPORT without STATE addition does not
* return the active version, this method is a workaround for this issue
    READ REPORT ls_include INTO rt_source STATE 'A'.

  ENDMETHOD.