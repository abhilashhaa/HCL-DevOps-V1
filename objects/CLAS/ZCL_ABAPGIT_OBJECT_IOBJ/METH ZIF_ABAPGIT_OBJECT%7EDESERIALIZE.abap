  METHOD zif_abapgit_object~deserialize.

    DATA:
      lr_details                  TYPE REF TO data,
      lr_infoobj                  TYPE REF TO data,
      ls_return                   TYPE bapiret2,
      lt_return                   TYPE STANDARD TABLE OF bapiret2,
      lr_compounds                TYPE REF TO data,
      lr_attributes               TYPE REF TO data,
      lr_navigationattributes     TYPE REF TO data,
      lr_atrnavinfoprovider       TYPE REF TO data,
      lr_hierarchycharacteristics TYPE REF TO data,
      lr_elimination              TYPE REF TO data,
      lr_hanafieldsmapping        TYPE REF TO data,
      lr_xxlattributes            TYPE REF TO data.

    FIELD-SYMBOLS:
      <lg_details>                  TYPE any,
      <lt_compounds>                TYPE STANDARD TABLE,
      <lt_attributes>               TYPE STANDARD TABLE,
      <lt_navigationattributes>     TYPE STANDARD TABLE,
      <lt_atrnavinfoprovider>       TYPE STANDARD TABLE,
      <lt_hierarchycharacteristics> TYPE STANDARD TABLE,
      <lt_elimination>              TYPE STANDARD TABLE,
      <lt_hanafieldsmapping>        TYPE STANDARD TABLE,
      <lt_xxlattributes>            TYPE STANDARD TABLE,
      <lg_infoobject>               TYPE data,
      <lt_infoobjects>              TYPE STANDARD TABLE.

    TRY.
        CREATE DATA lr_details TYPE ('BAPI6108').
        CREATE DATA lr_compounds TYPE STANDARD TABLE OF ('BAPI6108CM').
        CREATE DATA lr_attributes TYPE STANDARD TABLE OF ('BAPI6108AT').
        CREATE DATA lr_navigationattributes TYPE STANDARD TABLE OF ('BAPI6108AN').
        CREATE DATA lr_atrnavinfoprovider TYPE STANDARD TABLE OF ('BAPI6108NP').
        CREATE DATA lr_hierarchycharacteristics TYPE STANDARD TABLE OF ('BAPI6108HC').
        CREATE DATA lr_elimination TYPE STANDARD TABLE OF ('BAPI6108IE').
        CREATE DATA lr_hanafieldsmapping TYPE STANDARD TABLE OF ('BAPI6108HANA_MAP').
        CREATE DATA lr_xxlattributes TYPE STANDARD TABLE OF ('BAPI6108ATXXL').
        CREATE DATA lr_infoobj TYPE STANDARD TABLE OF ('BAPI6108').
      CATCH cx_sy_create_data_error.
        zcx_abapgit_exception=>raise( |IOBJ is not supported on this system| ).
    ENDTRY.

    ASSIGN lr_details->* TO <lg_details>.
    ASSIGN lr_compounds->* TO <lt_compounds>.
    ASSIGN lr_attributes->* TO <lt_attributes>.
    ASSIGN lr_navigationattributes->* TO <lt_navigationattributes>.
    ASSIGN lr_atrnavinfoprovider->* TO <lt_atrnavinfoprovider>.
    ASSIGN lr_hierarchycharacteristics->* TO <lt_hierarchycharacteristics>.
    ASSIGN lr_elimination->* TO <lt_elimination>.
    ASSIGN lr_hanafieldsmapping->* TO <lt_hanafieldsmapping>.
    ASSIGN lr_xxlattributes->* TO <lt_xxlattributes>.
    ASSIGN lr_infoobj->* TO <lt_infoobjects>.

    io_xml->read( EXPORTING iv_name = 'IOBJ'
                  CHANGING cg_data = <lg_details> ).

    io_xml->read( EXPORTING iv_name = 'COMPOUNDS'
                  CHANGING  cg_data = <lt_compounds> ).

    io_xml->read( EXPORTING iv_name = 'ATTRIBUTES'
                  CHANGING  cg_data = <lt_attributes> ).

    io_xml->read( EXPORTING iv_name = 'NAVIGATION_ATTRIBUTES'
                  CHANGING  cg_data = <lt_navigationattributes> ).

    io_xml->read( EXPORTING iv_name = 'ATTR_NAVIGATION'
                  CHANGING  cg_data = <lt_atrnavinfoprovider> ).

    io_xml->read( EXPORTING iv_name = 'HIERARCHY'
                  CHANGING  cg_data = <lt_hierarchycharacteristics> ).

    io_xml->read( EXPORTING iv_name = 'ELIMINATION'
                  CHANGING  cg_data = <lt_elimination> ).

    io_xml->read( EXPORTING iv_name = 'HANA_FIELDS_MAPPING'
                  CHANGING  cg_data = <lt_hanafieldsmapping> ).

    io_xml->read( EXPORTING iv_name = 'XXL_ATTRIBUTES'
                  CHANGING  cg_data = <lt_xxlattributes> ).

    " Number ranges are local (should not have been serialized)
    clear_field( EXPORTING iv_fieldname = 'NUMBRANR'
                 CHANGING  cg_metadata  = <lg_details> ).

    TRY.

        CALL FUNCTION 'BAPI_IOBJ_CREATE'
          EXPORTING
            details                  = <lg_details>
          IMPORTING
            return                   = ls_return
          TABLES
            compounds                = <lt_compounds>
            attributes               = <lt_attributes>
            navigationattributes     = <lt_navigationattributes>
            atrnavinfoprovider       = <lt_atrnavinfoprovider>
            hierarchycharacteristics = <lt_hierarchycharacteristics>
            elimination              = <lt_elimination>
            hanafieldsmapping        = <lt_hanafieldsmapping>
            xxlattributes            = <lt_xxlattributes>.

        IF ls_return-type = 'E'.
          zcx_abapgit_exception=>raise( |Error when creating iobj: { ls_return-message }| ).
        ENDIF.

        ASSIGN
          COMPONENT 'INFOOBJECT'
          OF STRUCTURE <lg_details>
          TO <lg_infoobject>.
        ASSERT sy-subrc = 0.

        APPEND <lg_infoobject> TO <lt_infoobjects>.

        CALL FUNCTION 'BAPI_IOBJ_ACTIVATE_MULTIPLE'
          TABLES
            infoobjects = <lt_infoobjects>
            return      = lt_return.

        READ TABLE lt_return WITH KEY type = 'E' INTO ls_return.
        IF sy-subrc = 0.
          zcx_abapgit_exception=>raise( |Error when activating iobj: { ls_return-message }| ).
        ENDIF.

      CATCH  cx_sy_dyn_call_illegal_func.
        zcx_abapgit_exception=>raise( |Necessary BW function modules not found| ).
    ENDTRY.

    tadir_insert( iv_package ).

    corr_insert( iv_package ).

  ENDMETHOD.