  METHOD conv_db_to_ngc.

    DATA:
      lo_ngc_api                     TYPE REF TO if_ngc_api,
      lo_clf_persistency             TYPE REF TO if_ngc_core_clf_persistency,
      lo_ngc_core_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect,
      lt_characteristic_key          TYPE ngct_characteristic_key,
      lt_characteristic_header       TYPE ngct_characteristic,
      lt_class_key                   TYPE ngct_class_key,
      ls_class_header                TYPE ngcs_class,
      lv_index                       TYPE syst_tabix,
      lt_kssk_all                    TYPE tt_kssk,
      lo_clf_api_result              TYPE REF TO cl_ngc_clf_api_result,
      lt_kssk_insert                 TYPE tt_kssk,
      lt_kssk_delete                 TYPE tt_kssk,
      lt_ausp_insert                 TYPE tt_ausp,
      lt_ausp_delete                 TYPE tt_ausp,
      lt_kssk_insert_w_inob          TYPE tt_kssk,
      lt_kssk_insert_wo_inob         TYPE tt_kssk,
      lt_ausp_insert_w_inob          TYPE tt_ausp,
      lt_ausp_insert_wo_inob         TYPE tt_ausp,
      lt_kssk_delete_w_inob          TYPE tt_kssk,
      lt_kssk_delete_wo_inob         TYPE tt_kssk,
      lt_ausp_delete_w_inob          TYPE tt_ausp,
      lt_ausp_delete_wo_inob         TYPE tt_ausp,
      ls_classification_key          TYPE ngcs_classification_key,
      ls_classification_msg	         TYPE ngcs_classification_msg,
      lt_classification_msg	         TYPE ngct_classification_msg.


    CLEAR: eo_clf_api_result, et_classification.


    " initialize classification results object
    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).
    lo_clf_api_result ?= eo_clf_api_result.

    IF ( it_inob        IS NOT SUPPLIED OR it_inob        IS INITIAL ) AND
       ( it_kssk_insert IS NOT SUPPLIED OR it_kssk_insert IS INITIAL ) AND
       ( it_kssk_delete IS NOT SUPPLIED OR it_kssk_delete IS INITIAL ) AND
       ( it_ausp_insert IS NOT SUPPLIED OR it_ausp_insert IS INITIAL ) AND
       ( it_ausp_delete IS NOT SUPPLIED OR it_ausp_delete IS INITIAL ).
      " no input --> nothing to do
      RETURN.
    ENDIF.

    " initialize NGC API
    IF io_ngc_api IS NOT SUPPLIED.
      lo_ngc_api = cl_ngc_api_factory=>get_instance( )->get_api( ).
    ELSE.
      lo_ngc_api = io_ngc_api.
    ENDIF.

    " initialize intersection utility for build_string call
    IF io_ngc_core_cls_util_intersect IS NOT SUPPLIED.
      lo_ngc_core_cls_util_intersect = cl_ngc_core_cls_util_intersect=>get_instance( ).
    ELSE.
      lo_ngc_core_cls_util_intersect = io_ngc_core_cls_util_intersect.
    ENDIF.

    " Collect characteristic headers.
    " Indices in IT_AUSP_INSERT and LT_CHARACTERISTIC_KEY are the same.
    LOOP AT it_ausp_insert ASSIGNING FIELD-SYMBOL(<ls_ausp_insert>).
      APPEND VALUE #( charcinternalid = <ls_ausp_insert>-atinn
                      key_date        = iv_key_date ) TO lt_characteristic_key.
    ENDLOOP.

    " get CLF persistency
    IF io_ngc_core_clf_persistency IS NOT SUPPLIED.
      lo_clf_persistency = cl_ngc_core_factory=>get_clf_persistency( ).
    ELSE.
      lo_clf_persistency = io_ngc_core_clf_persistency.
    ENDIF.

    " separate insert and delete entries for KSSK and AUSP, with and without INOB entry
    lt_kssk_insert = it_kssk_insert.
    lt_kssk_delete = it_kssk_delete.
    lt_ausp_insert = it_ausp_insert.
    lt_ausp_delete = it_ausp_delete.

    LOOP AT it_inob ASSIGNING FIELD-SYMBOL(<ls_inob>).
      " KSSK insert
      LOOP AT lt_kssk_insert ASSIGNING FIELD-SYMBOL(<ls_kssk_insert>) WHERE objek = CONV cuobn( <ls_inob>-cuobj ).
        lv_index = sy-tabix.
        APPEND <ls_kssk_insert> TO lt_kssk_insert_w_inob.
        DELETE lt_kssk_insert INDEX lv_index.
      ENDLOOP.

      " AUSP insert
      LOOP AT lt_ausp_insert ASSIGNING <ls_ausp_insert> WHERE objek = CONV cuobn( <ls_inob>-cuobj ).
        lv_index = sy-tabix.
        APPEND <ls_ausp_insert> TO lt_ausp_insert_w_inob.
        DELETE lt_ausp_insert INDEX lv_index.
      ENDLOOP.

      " KSSK delete
      LOOP AT lt_kssk_delete ASSIGNING FIELD-SYMBOL(<ls_kssk_delete>) WHERE objek = CONV cuobn( <ls_inob>-cuobj ).
        lv_index = sy-tabix.
        APPEND <ls_kssk_delete> TO lt_kssk_delete_w_inob.
        DELETE lt_kssk_delete INDEX lv_index.
      ENDLOOP.

      " AUSP delete
      LOOP AT lt_ausp_delete ASSIGNING FIELD-SYMBOL(<ls_ausp_delete>) WHERE objek = CONV cuobn( <ls_inob>-cuobj ).
        lv_index = sy-tabix.
        APPEND <ls_ausp_delete> TO lt_ausp_delete_w_inob.
        DELETE lt_ausp_delete INDEX lv_index.
      ENDLOOP.

    ENDLOOP.

    " collect entries without INOB
    lt_kssk_insert_wo_inob = lt_kssk_insert.
    lt_ausp_insert_wo_inob = lt_ausp_insert.
    lt_kssk_delete_wo_inob = lt_kssk_delete.
    lt_ausp_delete_wo_inob = lt_ausp_delete.


    " select class type data from customizing in order to know
    " the object type of class types without INOB
    query_classtypes( it_kssk_insert = lt_kssk_insert_wo_inob
                      it_kssk_delete = lt_kssk_delete_wo_inob
                      it_ausp_insert = lt_ausp_insert_wo_inob
                      it_ausp_delete = lt_ausp_delete_wo_inob ).

    " read characteristics header data
    lo_ngc_api->if_ngc_chr_api_read~read(
      EXPORTING
        it_characteristic_key = lt_characteristic_key
      IMPORTING
        et_characteristic     = DATA(lt_characteristic)
        eo_chr_api_result     = DATA(lo_chr_api_result)
    ).
    DATA(lt_chr_msg) = lo_chr_api_result->get_messages( ).
    LOOP AT lt_chr_msg ASSIGNING FIELD-SYMBOL(<ls_chr_msg>).
      LOOP AT lt_characteristic_key ASSIGNING FIELD-SYMBOL(<ls_characteristic_key>)
        WHERE charcinternalid = <ls_chr_msg>-charcinternalid.
        lv_index = sy-tabix.
        READ TABLE it_ausp_insert ASSIGNING <ls_ausp_insert> INDEX lv_index.
        ASSERT sy-subrc = 0.
        READ TABLE it_inob ASSIGNING <ls_inob> WITH KEY cuobj = <ls_ausp_insert>-objek.
        IF sy-subrc = 0.
          ls_classification_key-object_key       = <ls_inob>-objek.
          ls_classification_key-technical_object = <ls_inob>-obtab.
          ls_classification_key-change_number    = ''.
          ls_classification_key-key_date         = iv_key_date.
        ELSE.
          READ TABLE it_kssk_insert ASSIGNING <ls_kssk_insert>
            WITH KEY objek = <ls_ausp_insert>-objek
                     mafid = if_ngc_c=>gc_clf_object_class_indicator-object
                     klart = <ls_ausp_insert>-klart.
          ASSERT sy-subrc = 0.
          ls_classification_key-object_key       = <ls_kssk_insert>-objek.
          ls_classification_key-technical_object = get_clfnobjecttable( <ls_kssk_insert>-klart ).
          ls_classification_key-change_number    = ''.
          ls_classification_key-key_date         = iv_key_date.
        ENDIF.
        MOVE-CORRESPONDING ls_classification_key TO ls_classification_msg.
        MOVE-CORRESPONDING <ls_chr_msg> TO ls_classification_msg.
        APPEND ls_classification_msg TO lt_classification_msg.
      ENDLOOP.
    ENDLOOP.

    lo_clf_api_result->add_messages( lt_classification_msg ).
    IF eo_clf_api_result->has_error_or_worse( ) = abap_true.
      RETURN.
    ENDIF.

    LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
      APPEND <ls_characteristic>-characteristic_object->get_header( ) TO lt_characteristic_header.
    ENDLOOP.


    " Collect class master data to have the external keys
    LOOP AT it_kssk_insert ASSIGNING <ls_kssk_insert>.
      APPEND VALUE #( classinternalid = <ls_kssk_insert>-clint
                      key_date        = iv_key_date ) TO lt_class_key.
    ENDLOOP.
    LOOP AT it_kssk_delete ASSIGNING <ls_kssk_delete>.
      APPEND VALUE #( classinternalid = <ls_kssk_delete>-clint
                      key_date        = iv_key_date ) TO lt_class_key.
    ENDLOOP.

    " Indices in LT_KSSK_ALL and LT_CLASS_KEY are the same.
    APPEND LINES OF it_kssk_insert TO lt_kssk_all.
    APPEND LINES OF it_kssk_delete TO lt_kssk_all.

    lo_ngc_api->if_ngc_cls_api_read~read(
      EXPORTING
        it_class_key      = lt_class_key
      IMPORTING
        et_class          = DATA(lt_class)
        eo_cls_api_result = DATA(lo_cls_api_result)
    ).

    DATA(lt_cls_msg) = lo_cls_api_result->get_messages( ).
    LOOP AT lt_cls_msg ASSIGNING FIELD-SYMBOL(<ls_cls_msg>).
      LOOP AT lt_class_key ASSIGNING FIELD-SYMBOL(<ls_class_key>)
        WHERE classinternalid = <ls_cls_msg>-classinternalid.
        lv_index = sy-tabix.
        READ TABLE lt_kssk_all ASSIGNING FIELD-SYMBOL(<ls_kssk>) INDEX lv_index.
        ASSERT sy-subrc = 0.
        READ TABLE it_inob ASSIGNING <ls_inob> WITH KEY cuobj = <ls_kssk>-objek.
        IF sy-subrc = 0.
          ls_classification_key-object_key       = <ls_inob>-objek.
          ls_classification_key-technical_object = <ls_inob>-obtab.
          ls_classification_key-change_number    = ''.
          ls_classification_key-key_date         = iv_key_date.
        ELSE.
          ls_classification_key-object_key       = <ls_kssk>-objek.
          ls_classification_key-technical_object = get_clfnobjecttable( <ls_kssk>-klart ).
          ls_classification_key-change_number    = ''.
          ls_classification_key-key_date         = iv_key_date.
        ENDIF.
        MOVE-CORRESPONDING ls_classification_key TO ls_classification_msg.
        MOVE-CORRESPONDING <ls_cls_msg> TO ls_classification_msg.
        APPEND ls_classification_msg TO lt_classification_msg.
      ENDLOOP.
    ENDLOOP.

    lo_clf_api_result->add_messages( lt_classification_msg ).
    IF eo_clf_api_result->has_error_or_worse( ) = abap_true.
      RETURN.
    ENDIF.

    " process KSSK and AUSP entries with INOB
    LOOP AT it_inob ASSIGNING <ls_inob>.
      " class assignments
      LOOP AT lt_kssk_insert_w_inob ASSIGNING FIELD-SYMBOL(<ls_kssk_insert_w_inob>)
        WHERE objek = <ls_inob>-cuobj.
        READ TABLE et_classification ASSIGNING FIELD-SYMBOL(<ls_classification>)
          WITH KEY classification_key-object_key       = <ls_inob>-objek
                   classification_key-technical_object = <ls_inob>-obtab
                   classification_key-change_number    = ''
                   classification_key-key_date         = iv_key_date.
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO et_classification ASSIGNING <ls_classification>.
          <ls_classification>-classification_key-object_key       = <ls_inob>-objek.
          <ls_classification>-classification_key-technical_object = <ls_inob>-obtab.
          <ls_classification>-classification_key-change_number    = ''.
          <ls_classification>-classification_key-key_date         = iv_key_date.
        ENDIF.
        APPEND VALUE #( classinternalid = <ls_kssk_insert_w_inob>-clint
                        key_date        = iv_key_date ) TO <ls_classification>-assign_class_int_key.
        ls_class_header = lt_class[ classinternalid = <ls_kssk_insert_w_inob>-clint
                                    key_date        = iv_key_date ]-class_object->get_header( ).
        APPEND VALUE #( classtype = ls_class_header-classtype
                        class     = ls_class_header-class
                        key_date  = iv_key_date ) TO <ls_classification>-assign_class_ext_key.
        APPEND VALUE #( classinternalid     = <ls_kssk_insert_w_inob>-clint
                        clfnstatus          = <ls_kssk_insert_w_inob>-statu
                        classpositionnumber = <ls_kssk_insert_w_inob>-zaehl ) TO <ls_classification>-classification_data.
      ENDLOOP.

      " class removals
      LOOP AT lt_kssk_delete_w_inob ASSIGNING FIELD-SYMBOL(<ls_kssk_delete_w_inob>)
        WHERE objek = <ls_inob>-cuobj.
        READ TABLE et_classification ASSIGNING <ls_classification>
          WITH KEY classification_key-object_key       = <ls_inob>-objek
                   classification_key-technical_object = <ls_inob>-obtab
                   classification_key-change_number    = ''
                   classification_key-key_date         = iv_key_date.
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO et_classification ASSIGNING <ls_classification>.
          <ls_classification>-classification_key-object_key       = <ls_inob>-objek.
          <ls_classification>-classification_key-technical_object = <ls_inob>-obtab.
          <ls_classification>-classification_key-change_number    = ''.
          <ls_classification>-classification_key-key_date         = iv_key_date.
        ENDIF.
        ls_class_header = lt_class[ classinternalid = <ls_kssk_delete_w_inob>-clint
                                    key_date        = iv_key_date ]-class_object->get_header( ).
        APPEND VALUE #( classtype = ls_class_header-classtype
                        class     = ls_class_header-class
                        key_date  = iv_key_date ) TO <ls_classification>-remove_class_ext_key.
        APPEND VALUE #( classinternalid = <ls_kssk_delete_w_inob>-clint
                        key_date        = iv_key_date ) TO <ls_classification>-remove_class_int_key.
      ENDLOOP.

      " value assignments
      LOOP AT lt_ausp_insert_w_inob ASSIGNING FIELD-SYMBOL(<ls_ausp_insert_w_inob>)
        WHERE objek = <ls_inob>-cuobj.
        READ TABLE et_classification ASSIGNING <ls_classification>
          WITH KEY classification_key-object_key       = <ls_inob>-objek
                   classification_key-technical_object = <ls_inob>-obtab
                   classification_key-change_number    = ''
                   classification_key-key_date         = iv_key_date.
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO et_classification ASSIGNING <ls_classification>.
          <ls_classification>-classification_key-object_key       = <ls_inob>-objek.
          <ls_classification>-classification_key-technical_object = <ls_inob>-obtab.
          <ls_classification>-classification_key-change_number    = ''.
          <ls_classification>-classification_key-key_date         = iv_key_date.
        ENDIF.

        " read characteristic header
        READ TABLE lt_characteristic_header ASSIGNING FIELD-SYMBOL(<ls_characteristic_header>)
          WITH KEY charcinternalid = <ls_ausp_insert_w_inob>-atinn.
        ASSERT sy-subrc = 0.

        " conversion to ATWRT >>>
        build_string(
          EXPORTING
            is_classification_key          = <ls_classification>-classification_key
            is_characteristic_header       = <ls_characteristic_header>
            is_ausp                        = <ls_ausp_insert_w_inob>
            io_ngc_core_cls_util_intersect = lo_ngc_core_cls_util_intersect
            io_clf_api_result              = lo_clf_api_result
          IMPORTING
            ev_charcvalue                  = DATA(lv_charcvalue)
        ).
        IF eo_clf_api_result->has_error_or_worse( ) = abap_true.
          RETURN.
        ENDIF.

        APPEND INITIAL LINE TO <ls_classification>-change_value ASSIGNING FIELD-SYMBOL(<ls_change_value>).
        <ls_change_value>-classtype       = <ls_ausp_insert_w_inob>-klart.
        <ls_change_value>-charcinternalid = <ls_ausp_insert_w_inob>-atinn.
        <ls_change_value>-charcvalueold   = ''.
        <ls_change_value>-charcvaluenew   = lv_charcvalue.
        " <<< end of conversion to ATWRT

      ENDLOOP.

      " value removals
      LOOP AT lt_ausp_delete_w_inob ASSIGNING FIELD-SYMBOL(<ls_ausp_delete_w_inob>)
        WHERE objek = <ls_inob>-cuobj.
        READ TABLE et_classification ASSIGNING <ls_classification>
          WITH KEY classification_key-object_key       = <ls_inob>-objek
                   classification_key-technical_object = <ls_inob>-obtab
                   classification_key-change_number    = ''
                   classification_key-key_date         = iv_key_date.
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO et_classification ASSIGNING <ls_classification>.
          <ls_classification>-classification_key-object_key       = <ls_inob>-objek.
          <ls_classification>-classification_key-technical_object = <ls_inob>-obtab.
          <ls_classification>-classification_key-change_number    = ''.
          <ls_classification>-classification_key-key_date         = iv_key_date.
        ENDIF.

        " read characteristic header
        READ TABLE lt_characteristic_header ASSIGNING <ls_characteristic_header>
          WITH KEY charcinternalid = <ls_ausp_insert_w_inob>-atinn.
        ASSERT sy-subrc = 0.

        " conversion to ATWRT >>>
        build_string(
          EXPORTING
            is_classification_key          = <ls_classification>-classification_key
            is_characteristic_header       = <ls_characteristic_header>
            is_ausp                        = <ls_ausp_delete_w_inob>
            io_ngc_core_cls_util_intersect = lo_ngc_core_cls_util_intersect
            io_clf_api_result              = lo_clf_api_result
          IMPORTING
            ev_charcvalue                  = lv_charcvalue
        ).
        IF eo_clf_api_result->has_error_or_worse( ) = abap_true.
          RETURN.
        ENDIF.
        APPEND INITIAL LINE TO <ls_classification>-change_value ASSIGNING <ls_change_value>.
        <ls_change_value>-classtype       = <ls_ausp_delete_w_inob>-klart.
        <ls_change_value>-charcinternalid = <ls_ausp_delete_w_inob>-atinn.
        <ls_change_value>-charcvalueold   = lv_charcvalue.
        <ls_change_value>-charcvaluenew   = ''.
        " <<< end of conversion to ATWRT

      ENDLOOP.

    ENDLOOP.


    " process KSSK and AUSP entries without INOB
    " class assignments
    LOOP AT lt_kssk_insert_wo_inob ASSIGNING FIELD-SYMBOL(<ls_kssk_insert_wo_inob>).
      READ TABLE et_classification ASSIGNING <ls_classification>
        WITH KEY classification_key-object_key       = <ls_kssk_insert_wo_inob>-objek
                 classification_key-technical_object = get_clfnobjecttable( <ls_kssk_insert_wo_inob>-klart )
                 classification_key-change_number    = ''
                 classification_key-key_date         = iv_key_date.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO et_classification ASSIGNING <ls_classification>.
        <ls_classification>-classification_key-object_key       = <ls_kssk_insert_wo_inob>-objek.
        <ls_classification>-classification_key-technical_object = get_clfnobjecttable( <ls_kssk_insert_wo_inob>-klart ).
        <ls_classification>-classification_key-change_number    = ''.
        <ls_classification>-classification_key-key_date         = iv_key_date.
      ENDIF.
      ls_class_header = lt_class[ classinternalid = <ls_kssk_insert_wo_inob>-clint
                                  key_date        = iv_key_date ]-class_object->get_header( ).
      APPEND VALUE #( classtype = ls_class_header-classtype
                      class     = ls_class_header-class
                      key_date  = iv_key_date ) TO <ls_classification>-assign_class_ext_key.
      APPEND VALUE #( classinternalid = <ls_kssk_insert_wo_inob>-clint
                      key_date        = iv_key_date ) TO <ls_classification>-assign_class_int_key.
      APPEND VALUE #( classinternalid     = <ls_kssk_insert_wo_inob>-clint
                      clfnstatus          = <ls_kssk_insert_wo_inob>-statu
                      classpositionnumber = <ls_kssk_insert_wo_inob>-zaehl ) TO <ls_classification>-classification_data.
    ENDLOOP.

    " class removals
    LOOP AT lt_kssk_delete_wo_inob ASSIGNING FIELD-SYMBOL(<ls_kssk_delete_wo_inob>).
      READ TABLE et_classification ASSIGNING <ls_classification>
        WITH KEY classification_key-object_key       = <ls_kssk_delete_wo_inob>-objek
                 classification_key-technical_object = get_clfnobjecttable( <ls_kssk_delete_wo_inob>-klart )
                 classification_key-change_number    = ''
                 classification_key-key_date         = iv_key_date.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO et_classification ASSIGNING <ls_classification>.
        <ls_classification>-classification_key-object_key       = <ls_kssk_delete_wo_inob>-objek.
        <ls_classification>-classification_key-technical_object = get_clfnobjecttable( <ls_kssk_delete_wo_inob>-klart ).
        <ls_classification>-classification_key-change_number    = ''.
        <ls_classification>-classification_key-key_date         = iv_key_date.
      ENDIF.
      ls_class_header = lt_class[ classinternalid = <ls_kssk_delete_wo_inob>-clint
                                  key_date        = iv_key_date ]-class_object->get_header( ).
      APPEND VALUE #( classtype = ls_class_header-classtype
                      class     = ls_class_header-class
                      key_date  = iv_key_date ) TO <ls_classification>-remove_class_ext_key.
      APPEND VALUE #( classinternalid = <ls_kssk_delete_wo_inob>-clint
                      key_date        = iv_key_date ) TO <ls_classification>-remove_class_int_key.
    ENDLOOP.

    " value assignments
    LOOP AT lt_ausp_insert_wo_inob ASSIGNING FIELD-SYMBOL(<ls_ausp_insert_wo_inob>).
      READ TABLE et_classification ASSIGNING <ls_classification>
        WITH KEY classification_key-object_key       = <ls_ausp_insert_wo_inob>-objek
                 classification_key-technical_object = get_clfnobjecttable( <ls_ausp_insert_wo_inob>-klart )
                 classification_key-change_number    = ''
                 classification_key-key_date         = iv_key_date.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO et_classification ASSIGNING <ls_classification>.
        <ls_classification>-classification_key-object_key       = <ls_ausp_insert_wo_inob>-objek.
        <ls_classification>-classification_key-technical_object = get_clfnobjecttable( <ls_ausp_insert_wo_inob>-klart ).
        <ls_classification>-classification_key-change_number    = ''.
        <ls_classification>-classification_key-key_date         = iv_key_date.
      ENDIF.

      " read characteristic header
      READ TABLE lt_characteristic_header ASSIGNING <ls_characteristic_header>
        WITH KEY charcinternalid = <ls_ausp_insert_wo_inob>-atinn.
      ASSERT sy-subrc = 0.

      " conversion to ATWRT >>>
      build_string(
        EXPORTING
          is_classification_key          = <ls_classification>-classification_key
          is_characteristic_header       = <ls_characteristic_header>
          is_ausp                        = <ls_ausp_insert_wo_inob>
          io_ngc_core_cls_util_intersect = lo_ngc_core_cls_util_intersect
          io_clf_api_result              = lo_clf_api_result
        IMPORTING
          ev_charcvalue                  = lv_charcvalue
      ).
      IF eo_clf_api_result->has_error_or_worse( ) = abap_true.
        RETURN.
      ENDIF.
      APPEND INITIAL LINE TO <ls_classification>-change_value ASSIGNING <ls_change_value>.
      <ls_change_value>-classtype       = <ls_ausp_insert_wo_inob>-klart.
      <ls_change_value>-charcinternalid = <ls_ausp_insert_wo_inob>-atinn.
      <ls_change_value>-charcvalueold   = ''.
      <ls_change_value>-charcvaluenew   = lv_charcvalue.
      " <<< end of conversion to ATWRT

    ENDLOOP.

    " value removals
    LOOP AT lt_ausp_delete_wo_inob ASSIGNING FIELD-SYMBOL(<ls_ausp_delete_wo_inob>).
      READ TABLE et_classification ASSIGNING <ls_classification>
        WITH KEY classification_key-object_key       = <ls_ausp_delete_wo_inob>-objek
                 classification_key-technical_object = get_clfnobjecttable( <ls_ausp_delete_wo_inob>-klart )
                 classification_key-change_number    = ''
                 classification_key-key_date         = iv_key_date.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO et_classification ASSIGNING <ls_classification>.
        <ls_classification>-classification_key-object_key       = <ls_ausp_delete_wo_inob>-objek.
        <ls_classification>-classification_key-technical_object = get_clfnobjecttable( <ls_ausp_delete_wo_inob>-klart ).
        <ls_classification>-classification_key-change_number    = ''.
        <ls_classification>-classification_key-key_date         = iv_key_date.
      ENDIF.

      " read characteristic header
      READ TABLE lt_characteristic_header ASSIGNING <ls_characteristic_header>
        WITH KEY charcinternalid = <ls_ausp_insert_wo_inob>-atinn.
      ASSERT sy-subrc = 0.

      " conversion to ATWRT >>>
      build_string(
        EXPORTING
          is_classification_key          = <ls_classification>-classification_key
          is_characteristic_header       = <ls_characteristic_header>
          is_ausp                        = <ls_ausp_delete_wo_inob>
          io_ngc_core_cls_util_intersect = lo_ngc_core_cls_util_intersect
          io_clf_api_result              = lo_clf_api_result
        IMPORTING
          ev_charcvalue                  = lv_charcvalue
      ).
      IF eo_clf_api_result->has_error_or_worse( ) = abap_true.
        RETURN.
      ENDIF.
      APPEND INITIAL LINE TO <ls_classification>-change_value ASSIGNING <ls_change_value>.
      <ls_change_value>-classtype       = <ls_ausp_delete_wo_inob>-klart.
      <ls_change_value>-charcinternalid = <ls_ausp_delete_wo_inob>-atinn.
      <ls_change_value>-charcvalueold   = lv_charcvalue.
      <ls_change_value>-charcvaluenew   = ''.
      " <<< end of conversion to ATWRT

    ENDLOOP.

  ENDMETHOD.