private section.

  types:
    BEGIN OF lts_datatype_instance,
    datatype TYPE atfor,
    instance TYPE REF TO if_ngc_core_chr_value_check,
    END OF lts_datatype_instance .
  types:
    ltt_datatype_instance TYPE STANDARD TABLE OF lts_datatype_instance .

  class-data GT_DATATYPE_INSTANCE_MAP type LTT_DATATYPE_INSTANCE .