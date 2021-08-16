  METHOD if_message~get_longtext.

    " You should remember that we have to call ZCL_ABAPGIT_MESSAGE_HELPER
    " dynamically, because the compiled abapGit report puts the definition
    " of the exception classes on the top and therefore ZCL_ABAPGIT_MESSAGE_HELPER
    " isn't statically known

    DATA: lo_message_helper TYPE REF TO object.

    result = super->get_longtext( ).

    IF if_t100_message~t100key IS NOT INITIAL.

      CREATE OBJECT lo_message_helper TYPE ('ZCL_ABAPGIT_MESSAGE_HELPER')
        EXPORTING
          io_exception = me.

      CALL METHOD lo_message_helper->('GET_T100_LONGTEXT')
        RECEIVING
          rv_longtext = result.

    ENDIF.

  ENDMETHOD.