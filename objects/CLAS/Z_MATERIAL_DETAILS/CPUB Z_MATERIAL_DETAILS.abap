class Z_MATERIAL_DETAILS definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF ty_check,
             matnr TYPE matnr,
             werks TYPE werks_d,
           END OF ty_check .
  types:
    tt_mat TYPE STANDARD TABLE OF ty_check .

  data:
    li_find TYPE STANDARD TABLE OF ty_check .

  class-methods MATNR_WERKS
    changing
      value(LI_MAT) type TT_MAT .