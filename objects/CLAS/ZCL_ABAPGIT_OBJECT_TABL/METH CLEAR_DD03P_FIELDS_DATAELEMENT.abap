  METHOD clear_dd03p_fields_dataelement.

* type specified via data element
    CLEAR: cs_dd03p-domname,
           cs_dd03p-inttype,
           cs_dd03p-intlen,
           cs_dd03p-mask,
           cs_dd03p-memoryid,
           cs_dd03p-headlen,
           cs_dd03p-scrlen1,
           cs_dd03p-scrlen2,
           cs_dd03p-scrlen3,
           cs_dd03p-datatype,
           cs_dd03p-leng,
           cs_dd03p-outputlen,
           cs_dd03p-deffdname,
           cs_dd03p-convexit,
           cs_dd03p-entitytab,
           cs_dd03p-dommaster,
           cs_dd03p-domname3l,
           cs_dd03p-decimals,
           cs_dd03p-lowercase,
           cs_dd03p-signflag.

  ENDMETHOD.