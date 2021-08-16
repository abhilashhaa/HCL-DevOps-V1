CLASS ltc_ngc_core_badi_cls_update DEFINITION DEFERRED.
CLASS cl_ngc_core_badi_cls_update DEFINITION LOCAL FRIENDS ltc_ngc_core_badi_cls_update.

CLASS ltc_ngc_core_badi_cls_update DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      go_badi_cls_update TYPE REF TO cl_ngc_core_badi_cls_update.

    METHODS:
      setup.

    METHODS:
      update_called_once FOR TESTING,
      add_node_called FOR TESTING,
      delete_node_called FOR TESTING,
      update_node_called FOR TESTING.
ENDCLASS.

CLASS ltc_ngc_core_badi_cls_update IMPLEMENTATION.
  METHOD setup.
    go_badi_cls_update = NEW #( ).
    go_badi_cls_update->mo_cls_hier_maint ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_hier_maint' ).
  ENDMETHOD.

  METHOD update_called_once.
    cl_abap_testdouble=>configure_call( go_badi_cls_update->mo_cls_hier_maint )->and_expect( )->is_called_once( ).
    go_badi_cls_update->mo_cls_hier_maint->update( ).

    go_badi_cls_update->if_ex_cacl_class_update~before_update(
      VALUE #( ( clint = '0000000001' vondt = '20020101' bisdt = '20201231' klart = '001' chngind = 'I' )
               ( clint = '0000000002' vondt = '20020101' bisdt = '20201231' klart = '001' chngind = 'U' )
               ( clint = '0000000003' vondt = '20020101' bisdt = '20201231' klart = '001' chngind = 'D' ) ) ).

    cl_abap_testdouble=>verify_expectations( go_badi_cls_update->mo_cls_hier_maint ).
  ENDMETHOD.

  METHOD add_node_called.
    cl_abap_testdouble=>configure_call( go_badi_cls_update->mo_cls_hier_maint )->and_expect( )->is_called_once( ).
    go_badi_cls_update->mo_cls_hier_maint->add_node(
      iv_datub = '20201231'
      iv_datuv = '20020101'
      iv_node  = '0000000001'
      iv_klart = '001' ).

    go_badi_cls_update->if_ex_cacl_class_update~before_update(
      VALUE #( ( clint = '0000000001' vondt = '20020101' bisdt = '20201231' klart = '001' chngind = 'I' ) ) ).

    cl_abap_testdouble=>verify_expectations( go_badi_cls_update->mo_cls_hier_maint ).
  ENDMETHOD.

  METHOD delete_node_called.
    cl_abap_testdouble=>configure_call( go_badi_cls_update->mo_cls_hier_maint )->and_expect( )->is_called_once( ).
    go_badi_cls_update->mo_cls_hier_maint->delete_node(
      iv_datuv = '20020101'
      iv_node  = '0000000001' ).

    go_badi_cls_update->if_ex_cacl_class_update~before_update(
      VALUE #( ( clint = '0000000001' vondt = '20020101' bisdt = '20201231' klart = '001' chngind = 'D' ) ) ).

    cl_abap_testdouble=>verify_expectations( go_badi_cls_update->mo_cls_hier_maint ).
  ENDMETHOD.

  METHOD update_node_called.
    cl_abap_testdouble=>configure_call( go_badi_cls_update->mo_cls_hier_maint )->and_expect( )->is_called_once( ).
    go_badi_cls_update->mo_cls_hier_maint->update_node(
      iv_datub = '20201231'
      iv_datuv = '20020101'
      iv_node  = '0000000001' ).

    go_badi_cls_update->if_ex_cacl_class_update~before_update(
      VALUE #( ( clint = '0000000001' vondt = '20020101' bisdt = '20201231' klart = '001' chngind = 'U' ) ) ).

    cl_abap_testdouble=>verify_expectations( go_badi_cls_update->mo_cls_hier_maint ).
  ENDMETHOD.
ENDCLASS.