  METHOD create_package.

    DATA ls_package_data TYPE scompkdtln.
    DATA lv_create       TYPE abap_bool.
    DATA li_popup        TYPE REF TO zif_abapgit_popups.

    ls_package_data-devclass = to_upper( iv_prefill_package ).

    li_popup = zcl_abapgit_ui_factory=>get_popups( ).

    li_popup->popup_to_create_package(
      IMPORTING
        es_package_data = ls_package_data
        ev_create       = lv_create ).

    IF lv_create = abap_true.
      zcl_abapgit_factory=>get_sap_package( ls_package_data-devclass )->create( ls_package_data ).
      rv_package = ls_package_data-devclass.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.