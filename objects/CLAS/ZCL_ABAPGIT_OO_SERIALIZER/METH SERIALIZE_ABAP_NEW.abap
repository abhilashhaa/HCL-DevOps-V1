  METHOD serialize_abap_new.

    DATA: lo_source   TYPE REF TO object,
          lo_instance TYPE REF TO object.

* do not call the class/methods statically, as it will
* give syntax errors on old versions
    CALL METHOD ('CL_OO_FACTORY')=>('CREATE_INSTANCE')
      RECEIVING
        result = lo_instance.

    CALL METHOD lo_instance->('CREATE_CLIF_SOURCE')
      EXPORTING
        clif_name = is_clskey-clsname
        version   = 'A'
      RECEIVING
        result    = lo_source.

    CALL METHOD lo_source->('GET_SOURCE')
      IMPORTING
        source = rt_source.

  ENDMETHOD.