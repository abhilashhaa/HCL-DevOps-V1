  PRIVATE SECTION.

    DATA mi_persistence TYPE REF TO if_wb_object_persist .
    DATA mi_appl_obj_data TYPE REF TO if_wb_object_data_model .
    DATA mv_data_structure_name TYPE string .
    DATA mv_appl_obj_cls_name TYPE seoclsname .
    DATA mv_persistence_cls_name TYPE seoclsname .

    METHODS create_channel_objects
      RAISING
        zcx_abapgit_exception .
    METHODS get_data
      EXPORTING
        !eg_data TYPE any
      RAISING
        zcx_abapgit_exception .
    METHODS lock
      RAISING
        zcx_abapgit_exception .
    METHODS unlock
      RAISING
        zcx_abapgit_exception .
    METHODS get_names .