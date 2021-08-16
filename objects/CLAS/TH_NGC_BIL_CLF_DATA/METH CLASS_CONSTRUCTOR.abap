  METHOD class_constructor.

*--------------------------------------------------------------------*
* Data for Class creation
*--------------------------------------------------------------------*
    gt_objectclass_create_multi = VALUE #(
      (
        %cid                  = 'CID_1'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU1'
        classinternalid       = '0000000001'
       )
      ( " same object, object table and class type but different class
        %cid                  = 'CID_2'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU1'
        classinternalid       = '0000000002'
       )
      (
        %cid                  = 'CID_4'
        clfnobjectid          = 'OBJ_2'
        clfnobjecttable       = 'TBL_2'
        classtype             = 'AU2'
        classinternalid       = '0000000004'
       )
      ( " same object, object table but different class type
        %cid                  = 'CID_3'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU2'
        classinternalid       = '0000000003'
       )
     ).

    gt_objectclass_create_single = VALUE #( ( gt_objectclass_create_multi[ 1 ] ) ).

*--------------------------------------------------------------------*
* Data for Class deletion
*--------------------------------------------------------------------*
    gt_objectclass_delete_multi = VALUE #(
      (
        %cid_ref              = 'CID_1'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classinternalid       = '0000000001'
       )
      ( " same object, object table and class type but different class
        %cid_ref              = 'CID_2'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classinternalid       = '0000000002'
       )
      ( " same object, object table but different class type
        %cid_ref              = 'CID_3'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classinternalid       = '0000000003'
       )
      (
        %cid_ref              = 'CID_4'
        clfnobjectid          = 'OBJ_2'
        clfnobjecttable       = 'TBL_2'
        classinternalid       = '0000000004'
       ) ).

    gt_objectclass_delete_single = VALUE #( ( gt_objectclass_delete_multi[ 1 ] ) ).


*--------------------------------------------------------------------*
* Data for Class read
*--------------------------------------------------------------------*
    gt_objectclass_read_multi_in = VALUE #(
      (
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classinternalid       = '0000000001'
       )
      ( " same object, object table and class type but different class
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classinternalid       = '0000000002'
       )
      ( " same object, object table but different class type
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classinternalid       = '0000000003'
       )
      (
        clfnobjectid          = 'OBJ_2'
        clfnobjecttable       = 'TBL_2'
        classinternalid       = '0000000004'
       ) ).

    gt_objectclass_read_multi_clfd = VALUE #(
      ( classinternalid = '0000000001' class = 'CLS1' classtype = 'AU1' )
      ( classinternalid = '0000000002' class = 'CLS2' classtype = 'AU1' )
      ( classinternalid = '0000000003' class = 'CLS3' classtype = 'AU2' )
      ( classinternalid = '0000000004' class = 'CLS4' classtype = 'AU2' )
    ).

    gt_objectclass_read_multi_obji = VALUE #(
      ( classtype = 'AU1' clfnobjectid = 'OBJ_1' clfnobjectinternalid = '000000000000000001' )
      ( classtype = 'AU1' clfnobjectid = 'OBJ_2' clfnobjectinternalid = '000000000000000004' )
      ( classtype = 'AU2' clfnobjectid = 'OBJ_1' clfnobjectinternalid = '000000000000000002' )
      ( classtype = 'AU2' clfnobjectid = 'OBJ_2' clfnobjectinternalid = '000000000000000003' )
    ).

    DATA:
      lv_timezone     TYPE timezone,
      lv_default_etag TYPE timestampl.

    CALL FUNCTION 'GET_SYSTEM_TIMEZONE'
      IMPORTING
        timezone            = lv_timezone
      EXCEPTIONS
        customizing_missing = 1
        OTHERS              = 2.
    IF sy-subrc <> 0.
      ASSERT 1 = 2.
    ENDIF.

    CONVERT DATE '19720401' TIME '000000' INTO TIME STAMP lv_default_etag TIME ZONE lv_timezone.

    gt_objectclass_read_multi_out = VALUE #(
      ( clfnobjectid = 'OBJ_1' clfnobjecttable = 'TBL_1' classinternalid = 0000000001 classtype = 'AU1' clfnobjectinternalid = 000000000000000001 )
      ( clfnobjectid = 'OBJ_1' clfnobjecttable = 'TBL_1' classinternalid = 0000000002 classtype = 'AU1' clfnobjectinternalid = 000000000000000001 )
      ( clfnobjectid = 'OBJ_1' clfnobjecttable = 'TBL_1' classinternalid = 0000000003 classtype = 'AU2' clfnobjectinternalid = 000000000000000002 )
      ( clfnobjectid = 'OBJ_2' clfnobjecttable = 'TBL_2' classinternalid = 0000000004 classtype = 'AU2' clfnobjectinternalid = 000000000000000003 )
    ).

*--------------------------------------------------------------------*
* Data for Class read by object
*--------------------------------------------------------------------*
    gt_objectclass_readb_multi_in = VALUE #(
      (
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
       )
      (
        clfnobjectid          = 'OBJ_2'
        clfnobjecttable       = 'TBL_2'
       ) ).

    gt_objectclass_readb_multi_out = VALUE #(
      ( clfnobjectid = 'OBJ_1' clfnobjecttable = 'TBL_1' classinternalid = 0000000001 classtype = 'AU1' clfnobjectinternalid = 000000000000000001 )
      ( clfnobjectid = 'OBJ_1' clfnobjecttable = 'TBL_1' classinternalid = 0000000002 classtype = 'AU1' clfnobjectinternalid = 000000000000000001 )
      ( clfnobjectid = 'OBJ_1' clfnobjecttable = 'TBL_1' classinternalid = 0000000003 classtype = 'AU2' clfnobjectinternalid = 000000000000000002 )
      ( clfnobjectid = 'OBJ_1' clfnobjecttable = 'TBL_1' classinternalid = 0000000004 classtype = 'AU2' clfnobjectinternalid = 000000000000000002 )
      ( clfnobjectid = 'OBJ_2' clfnobjecttable = 'TBL_2' classinternalid = 0000000001 classtype = 'AU1' clfnobjectinternalid = 000000000000000004 )
      ( clfnobjectid = 'OBJ_2' clfnobjecttable = 'TBL_2' classinternalid = 0000000002 classtype = 'AU1' clfnobjectinternalid = 000000000000000004 )
      ( clfnobjectid = 'OBJ_2' clfnobjecttable = 'TBL_2' classinternalid = 0000000003 classtype = 'AU2' clfnobjectinternalid = 000000000000000003 )
      ( clfnobjectid = 'OBJ_2' clfnobjecttable = 'TBL_2' classinternalid = 0000000004 classtype = 'AU2' clfnobjectinternalid = 000000000000000003 )
    ).

    gt_objectclass_readb_multi_l =
    VALUE #(
      ( source = gt_objectclass_readb_multi_in[ 1 ]  target = gt_objectclass_readb_multi_out[ 1 ] )
      ( source = gt_objectclass_readb_multi_in[ 1 ]  target = gt_objectclass_readb_multi_out[ 2 ] )
      ( source = gt_objectclass_readb_multi_in[ 1 ]  target = gt_objectclass_readb_multi_out[ 3 ] )
      ( source = gt_objectclass_readb_multi_in[ 1 ]  target = gt_objectclass_readb_multi_out[ 4 ] )
      ( source = gt_objectclass_readb_multi_in[ 2 ]  target = gt_objectclass_readb_multi_out[ 5 ] )
      ( source = gt_objectclass_readb_multi_in[ 2 ]  target = gt_objectclass_readb_multi_out[ 6 ] )
      ( source = gt_objectclass_readb_multi_in[ 2 ]  target = gt_objectclass_readb_multi_out[ 7 ] )
      ( source = gt_objectclass_readb_multi_in[ 2 ]  target = gt_objectclass_readb_multi_out[ 8 ] )
    ).

*--------------------------------------------------------------------*
* Characteristic Header data
*--------------------------------------------------------------------*
    gt_objectcharcval_charc_header = VALUE #( (
      charcinternalid           = '0000000001'
      charcdatatype             = if_ngc_c=>gc_charcdatatype-char
      multiplevaluesareallowed  = abap_true
    ) (
      charcinternalid           = '0000000002'
      charcdatatype             = if_ngc_c=>gc_charcdatatype-num
      multiplevaluesareallowed  = abap_true
    ) (
      charcinternalid           = '0000000003'
      charcdatatype             = if_ngc_c=>gc_charcdatatype-curr
      multiplevaluesareallowed  = abap_true
    ) (
      charcinternalid           = '0000000004'
      charcdatatype             = if_ngc_c=>gc_charcdatatype-date
      multiplevaluesareallowed  = abap_true
    ) (
      charcinternalid           = '0000000005'
      charcdatatype             = if_ngc_c=>gc_charcdatatype-time
      multiplevaluesareallowed  = abap_true
    ) (
      charcinternalid           = '0000000006'
      charcdatatype             = if_ngc_c=>gc_charcdatatype-num
      multiplevaluesareallowed  = abap_true
    ) ).

    gs_objectcharcval_charc_header = VALUE #( gt_objectcharcval_charc_header[ 1 ] ).

*--------------------------------------------------------------------*
* Data for characteristic value creation
*--------------------------------------------------------------------*
    gt_objectcharcval_create = VALUE #(
      (
        %cid                  = 'CID1'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU1'
        charcinternalid       = gt_objectcharcval_charc_header[ 1 ]-charcinternalid
      )
      (
        %cid                  = 'CID2'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU1'
        charcinternalid       = gt_objectcharcval_charc_header[ 2 ]-charcinternalid
      )
      (
        %cid                  = 'CID3'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU1'
        charcinternalid       = gt_objectcharcval_charc_header[ 3 ]-charcinternalid
      )
      (
        %cid                  = 'CID4'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU1'
        charcinternalid       = gt_objectcharcval_charc_header[ 4 ]-charcinternalid
      )
      (
        %cid                  = 'CID5'
        clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU1'
        charcinternalid       = gt_objectcharcval_charc_header[ 5 ]-charcinternalid
      )
     ).

    gt_objectcl_create_cls_by_obj = VALUE #( (
      clfnobjectid = 'OBJ_3'
      clfnobjecttable = 'TBL_1'
      %target = VALUE #(
        ( classtype             = 'AU1'
          classinternalid       = '0000000001' )
        ( classtype             = 'AU2'
          classinternalid       = '0000000003' )
      )
    ) ).

    gt_objectcharcval_cret_by_chr = VALUE #(
      ( clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU1'
        charcinternalid       = gt_objectcharcval_charc_header[ 1 ]-charcinternalid "char
        %target = VALUE #(
          ( charcvalue        = 'A' )
      ) )
      ( clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU1'
        charcinternalid       = gt_objectcharcval_charc_header[ 2 ]-charcinternalid "num
        %target = VALUE #(
          ( charcvalue               = 15
            charcvaluedependency     = 1 )
      ) )
      ( clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
        classtype             = 'AU2'
        charcinternalid       = gt_objectcharcval_charc_header[ 6 ]-charcinternalid "num
        %target = VALUE #(
          ( charcvaluedependency     = 1
            charcvalue               = 10 )
      ) )
    ).

*--------------------------------------------------------------------*
* Data for characteristic value update
*--------------------------------------------------------------------*
    gt_objectcharcval_update = VALUE #(
      (
        clfnobjectid              = 'OBJ_1'
        clfnobjecttable           = 'TBL_1'
        classtype                 = 'AU1'
        charcinternalid           = gt_objectcharcval_charc_header[ 1 ]-charcinternalid
        charcvaluepositionnumber  = '001'
        charcvaluedependency      = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
        %control-charcvalue       = cl_abap_behavior_handler=>flag_changed
      )
      (
        clfnobjectid              = 'OBJ_1'
        clfnobjecttable           = 'TBL_1'
        classtype                 = 'AU1'
        charcinternalid           = gt_objectcharcval_charc_header[ 2 ]-charcinternalid
        charcvaluepositionnumber  = '001'
        charcvaluedependency      = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
      )
      (
        clfnobjectid              = 'OBJ_1'
        clfnobjecttable           = 'TBL_1'
        classtype                 = 'AU1'
        charcinternalid           = gt_objectcharcval_charc_header[ 3 ]-charcinternalid
        charcvaluepositionnumber  = '001'
        charcvaluedependency      = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
      )
      (
        clfnobjectid              = 'OBJ_1'
        clfnobjecttable           = 'TBL_1'
        classtype                 = 'AU1'
        charcinternalid           = gt_objectcharcval_charc_header[ 4 ]-charcinternalid
        charcvaluepositionnumber  = '001'
        charcvaluedependency      = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
      )
      (
        clfnobjectid              = 'OBJ_1'
        clfnobjecttable           = 'TBL_1'
        classtype                 = 'AU1'
        charcinternalid           = gt_objectcharcval_charc_header[ 5 ]-charcinternalid
        charcvaluepositionnumber  = '001'
        charcvaluedependency      = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
      )
     ).
*--------------------------------------------------------------------*
* Data for characteristic value deletion
*--------------------------------------------------------------------*
    gt_objectcharcval_delete_multi = VALUE #( (
      charcinternalid          = '0000000001'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
    ) (
      charcinternalid          = '0000000002'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
    ) (
      charcinternalid          = '0000000003'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
    ) (
      charcinternalid          = '0000000004'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
    ) (
      charcinternalid          = '0000000005'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
    ) ).

    gt_objectcharcval_delete_singl = VALUE #( ( gt_objectcharcval_delete_multi[ 1 ] ) ).

    gt_objectcharcval_val_data_sng = VALUE #( (
      charcinternalid          = '0000000001'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
      charcvalue               = 'X'
      clfnobjecttype           = 'O'
    ) ).

    gt_objectcharcval_val_data_mul = VALUE #( (
      clfnobjectid             = 'OBJ_1'
      charcinternalid          = '0000000001'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
      charcvalue               = 'X'
      clfnobjecttype           = 'O'
      charcvaluedependency     = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
    ) (
      clfnobjectid             = 'OBJ_1'
      charcinternalid          = '0000000002'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
      charcvalue               = '1'
      clfnobjecttype           = 'O'
      charcvaluedependency     = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
    ) (
      clfnobjectid             = 'OBJ_1'
      charcinternalid          = '0000000003'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
      charcvalue               = '1'
      clfnobjecttype           = 'O'
      charcvaluedependency     = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
    ) (
      clfnobjectid             = 'OBJ_1'
      charcinternalid          = '0000000004'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
      charcvalue               = '20010101'
      clfnobjecttype           = 'O'
      charcvaluedependency     = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
    ) (
      clfnobjectid             = 'OBJ_1'
      charcinternalid          = '0000000005'
      charcvaluepositionnumber = '001'
      classtype                = 'AU1'
      charcvalue               = '12:34:56'
      clfnobjecttype           = 'O'
      charcvaluedependency     = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
    ) (
      clfnobjectid             = 'OBJ_1'
      charcinternalid          = '1000000010'
      charcvaluepositionnumber = '001'
      classtype                = 'AU2'
      charcvalue               = 'GREEN'
      clfnobjecttype           = 'O'
      charcvaluedependency     = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
    ) (
      clfnobjectid             = 'OBJ_1'
      charcinternalid          = '1000000010'
      charcvaluepositionnumber = '002'
      classtype                = 'AU2'
      charcvalue               = 'YELLOW'
      clfnobjecttype           = 'O'
      charcvaluedependency     = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
    ) (
      clfnobjectid             = 'OBJ_1'
      charcinternalid          = '1000000011'
      charcvaluepositionnumber = '001'
      classtype                = 'AU2'
      charcvalue               = 'AAA'
      clfnobjecttype           = 'O'
      charcvaluedependency     = if_ngc_core_c=>gc_chr_charcvaluedependency-eq
    )
    ).

*--------------------------------------------------------------------*
* Data for characteristic value reading
*--------------------------------------------------------------------*

    gt_objectcharc_read_multi = VALUE #(
      ( clfnobjectid          = gt_objectcharcval_val_data_mul[ 1 ]-clfnobjectid
        clfnobjecttable       = 'TBL_1'
        classtype             = gt_objectcharcval_val_data_mul[ 1 ]-classtype
        charcinternalid       = gt_objectcharcval_charc_header[ 1 ]-charcinternalid
      ) "char
      ( clfnobjectid          = gt_objectcharcval_val_data_mul[ 2 ]-clfnobjectid
        clfnobjecttable       = 'TBL_1'
        classtype             = gt_objectcharcval_val_data_mul[ 2 ]-classtype
        charcinternalid       = gt_objectcharcval_charc_header[ 2 ]-charcinternalid
      ) "char
    ).

    gt_objectcharc_read_by_object = VALUE #(
      ( clfnobjectid          = 'OBJ_1'
        clfnobjecttable       = 'TBL_1'
      )
    ).

    gt_objectcharcval_read = VALUE #(
      ( clfnobjectid             = gt_objectcharcval_val_data_mul[ 1 ]-clfnobjectid
        clfnobjecttable          = 'TBL_1'
        charcinternalid          = gt_objectcharcval_val_data_mul[ 1 ]-charcinternalid
        charcvaluepositionnumber = gt_objectcharcval_val_data_mul[ 1 ]-charcvaluepositionnumber
        classtype                = gt_objectcharcval_val_data_mul[ 1 ]-classtype )
      ( clfnobjectid             = gt_objectcharcval_val_data_mul[ 4 ]-clfnobjectid
        clfnobjecttable          = 'TBL_1'
        charcinternalid          = gt_objectcharcval_val_data_mul[ 4 ]-charcinternalid
        charcvaluepositionnumber = gt_objectcharcval_val_data_mul[ 4 ]-charcvaluepositionnumber
        classtype                = gt_objectcharcval_val_data_mul[ 4 ]-classtype )
      ( clfnobjectid             = gt_objectcharcval_val_data_mul[ 7 ]-clfnobjectid
        clfnobjecttable          = 'TBL_1'
        charcinternalid          = gt_objectcharcval_val_data_mul[ 7 ]-charcinternalid
        charcvaluepositionnumber = gt_objectcharcval_val_data_mul[ 7 ]-charcvaluepositionnumber
        classtype                = gt_objectcharcval_val_data_mul[ 7 ]-classtype )
    ).

    gt_objectcharcval_read_by_chr = VALUE #(
      ( clfnobjectid          = gt_objectcharcval_val_data_mul[ 1 ]-clfnobjectid
        clfnobjecttable       = 'TBL_1'
        charcinternalid       = gt_objectcharcval_val_data_mul[ 1 ]-charcinternalid
        classtype             = gt_objectcharcval_val_data_mul[ 1 ]-classtype
      )
      ( clfnobjectid          = gt_objectcharcval_val_data_mul[ 6 ]-clfnobjectid
        clfnobjecttable       = 'TBL_1'
        charcinternalid       = gt_objectcharcval_val_data_mul[ 6 ]-charcinternalid
        classtype             = gt_objectcharcval_val_data_mul[ 6 ]-classtype
      )
      ( clfnobjectid          = gt_objectcharcval_val_data_mul[ 8 ]-clfnobjectid
        clfnobjecttable       = 'TBL_1'
        charcinternalid       = gt_objectcharcval_val_data_mul[ 8 ]-charcinternalid
        classtype             = gt_objectcharcval_val_data_mul[ 8 ]-classtype
      )
    ).

  ENDMETHOD.