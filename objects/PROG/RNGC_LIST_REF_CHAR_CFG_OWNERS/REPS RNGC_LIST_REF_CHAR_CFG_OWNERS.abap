*&---------------------------------------------------------------------*
*& Report RNGC_LIST_REF_CHAR_CFG_OWNERS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT rngc_list_ref_char_cfg_owners LINE-SIZE 244.

START-OF-SELECTION.

  DATA:
    lt_fieldcat_temp TYPE slis_t_fieldcat_alv,
    lt_fieldcat      TYPE slis_t_fieldcat_alv.

  DATA(lt_valuations) = cl_ngc_core_list_ref_char_cfg=>get_valuations( ).

  " Get all owner for this char & value, where author is Classification.
  DATA(lt_config_owners) = cl_ngc_core_list_ref_char_cfg=>get_config_owners( lt_valuations ).

  LOOP AT lt_config_owners REFERENCE INTO DATA(lr_configuration).
    DATA(lv_objtyp_ext) = cl_ngc_core_list_ref_char_cfg=>get_objtyp_ext_by_int( lr_configuration->inttyp ).
    WRITE:
      / lr_configuration->instance,
      lv_objtyp_ext,
      lr_configuration->objkey,
      lr_configuration->atinn,
      lr_configuration->atwrt,
      lr_configuration->atflv,
      lr_configuration->atflb,
      lr_configuration->atcod.
    NEW-LINE.
  ENDLOOP.

TOP-OF-PAGE.
  FORMAT COLOR 1 ON.
  WRITE: / TEXT-001, 20 TEXT-002, 31 TEXT-003, 82 TEXT-004, 113 TEXT-005, 185 TEXT-006, 208 TEXT-007, 230 TEXT-008.
  FORMAT COLOR 1 OFF.