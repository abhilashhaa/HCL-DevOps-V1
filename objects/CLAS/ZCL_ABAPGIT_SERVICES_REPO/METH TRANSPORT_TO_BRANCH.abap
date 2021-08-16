  METHOD transport_to_branch.

    DATA:
      lo_repository          TYPE REF TO zcl_abapgit_repo_online,
      lo_transport_to_branch TYPE REF TO zcl_abapgit_transport_2_branch,
      lt_transport_headers   TYPE trwbo_request_headers,
      lt_transport_objects   TYPE zif_abapgit_definitions=>ty_tadir_tt,
      ls_transport_to_branch TYPE zif_abapgit_definitions=>ty_transport_to_branch.


    IF zcl_abapgit_auth=>is_allowed( zif_abapgit_auth=>gc_authorization-transport_to_branch ) = abap_false.
      zcx_abapgit_exception=>raise( 'Not authorized' ).
    ENDIF.

    lo_repository ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_repository_key ).

    lt_transport_headers = zcl_abapgit_ui_factory=>get_popups( )->popup_to_select_transports( ).
    lt_transport_objects = zcl_abapgit_transport=>to_tadir( lt_transport_headers ).
    IF lt_transport_objects IS INITIAL.
      zcx_abapgit_exception=>raise( 'Canceled or List of objects is empty ' ).
    ENDIF.

    ls_transport_to_branch = zcl_abapgit_ui_factory=>get_popups( )->popup_to_create_transp_branch(
      lt_transport_headers ).

    CREATE OBJECT lo_transport_to_branch.
    lo_transport_to_branch->create(
      io_repository          = lo_repository
      is_transport_to_branch = ls_transport_to_branch
      it_transport_objects   = lt_transport_objects ).

  ENDMETHOD.