  METHOD update_cs_number_of_methods.

    " Indirect access to keep downward compatibility
    DATA lr_cache_entry TYPE REF TO data.

    FIELD-SYMBOLS: <lg_cache_entry> TYPE any,
                   <lg_field>       TYPE any.


    TRY.
        CREATE DATA lr_cache_entry TYPE ('SEO_CS_CACHE').
      CATCH cx_sy_create_data_error.
* does not exist in some older systems
        RETURN.
    ENDTRY.

    ASSIGN lr_cache_entry->* TO <lg_cache_entry>.
    ASSERT sy-subrc = 0.

    ASSIGN COMPONENT 'CLSNAME' OF STRUCTURE <lg_cache_entry>
           TO <lg_field>.
    ASSERT sy-subrc = 0.
    <lg_field> = iv_classname.

    ASSIGN COMPONENT 'NO_OF_METHOD_IMPLS' OF STRUCTURE <lg_cache_entry>
           TO <lg_field>.
    ASSERT sy-subrc = 0.
    <lg_field> = iv_number_of_impl_methods.

    MODIFY ('SEO_CS_CACHE') FROM <lg_cache_entry>.

  ENDMETHOD.