  METHOD lock_all_with_messages.

    " Given: A list of classification keys
    DATA(lt_classification_key) = VALUE ngct_core_classification_key(
      ( object_key       = 'OBJECT_01'
        technical_object = 'MARA'
        key_date         = sy-datum )
      ( object_key       = 'OBJECT_02'
        technical_object = 'MARA'
        key_date         = sy-datum )
      ( object_key       = 'OBJECT_01'
        technical_object = 'MCH1'
        key_date         = sy-datum ) ).

    " And: A list of assigned classes
    mo_cut->mt_kssk_changes = VALUE #(
      ( object_key       = 'OBJECT_01'
        technical_object = 'MARA'
        key_date         = sy-datum
        classinternalid  = '1'
        classtype        = '001' )
      ( object_key       = 'OBJECT_01'
        technical_object = 'MARA'
        key_date         = sy-datum
        classinternalid  = '2'
        classtype        = '001' )
      ( object_key       = 'OBJECT_02'
        technical_object = 'MARA'
        key_date         = sy-datum
        classinternalid  = '3'
        classtype        = '001' )
      ( object_key       = 'OBJECT_01'
        technical_object = 'MCH1'
        key_date         = sy-datum
        classinternalid  = '4'
        classtype        = '023' ) ).

    mo_cut->mt_classes = VALUE #(
      ( classinternalid = '1'
        class           = 'CLASS_01' )
      ( classinternalid = '2'
        class           = 'CLASS_02' )
      ( classinternalid = '3'
        class           = 'CLASS_03' )
      ( classinternalid = '4'
        class           = 'CLASS_01' ) ).

    " And: Locking fails for certain keys
    cl_abap_testdouble=>configure_call( mo_cut->mo_locking )->set_parameter(
      name  = 'ev_subrc'
      value = '1' ).
    mo_cut->mo_locking->clen_enqueue_classification(
      EXPORTING
        iv_enqmode = 'E'
        iv_mafid   = 'O'
        iv_klart   = '001'
        iv_objek   = 'OBJECT_01'
        iv_class   = 'CLASS_02' ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_locking )->set_parameter(
      name  = 'ev_subrc'
      value = '0'
    )->and_expect( )->is_called_once( ).
    mo_cut->mo_locking->clen_enqueue_classification(
      EXPORTING
        iv_enqmode = 'E'
        iv_mafid   = 'O'
        iv_klart   = '023'
        iv_objek   = 'OBJECT_01'
        iv_class   = 'CLASS_01' ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_locking )->set_parameter(
      name  = 'ev_subrc'
      value = '0'
    )->and_expect( )->is_called_once( ).
    mo_cut->mo_locking->clen_enqueue_classification(
      EXPORTING
        iv_enqmode = 'E'
        iv_mafid   = 'O'
        iv_klart   = '001'
        iv_objek   = 'OBJECT_01'
        iv_class   = 'CLASS_01' ).

    " And: Certain classes are already locked
    mo_cut->mt_enqueue_log = VALUE #(
      ( enqmode = 'E'
        mafid   = 'O'
        objek   = 'OBJECT_02'
        klart   = '001'
        class   = 'CLASS_03' ) ).

    " And: I have locking expectations
    cl_abap_testdouble=>configure_call( mo_cut->mo_locking )->and_expect( )->is_never_called( ).
    mo_cut->mo_locking->clen_enqueue_classification(
      EXPORTING
        iv_enqmode = 'E'
        iv_mafid   = 'O'
        iv_klart   = '001'
        iv_objek   = 'OBJECT_02'
        iv_class   = 'CLASS_03' ).

    " When: I call lock all
    mo_cut->if_ngc_core_clf_persistency~lock_all(
      EXPORTING
        it_classification_key = VALUE #(
          ( object_key       = 'OBJECT_01'
            technical_object = 'MARA'
            key_date         = sy-datum )
          ( object_key       = 'OBJECT_02'
            technical_object = 'MARA'
            key_date         = sy-datum )
          ( object_key       = 'OBJECT_01'
            technical_object = 'MCH1'
            key_date         = sy-datum ) )
       IMPORTING
         et_message           = DATA(lt_message)   ).

    " Then: Required objects should be locked
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_locking ).

    " And: Lock buffer should be updated
    cl_abap_unit_assert=>assert_equals(
      act = lines( mo_cut->mt_enqueue_log )
      exp = 3 ).

    " And: Messages should be retrurned
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 1 ).

  ENDMETHOD.