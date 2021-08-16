METHOD if_ngc_drf_ewm_util~change_classtype_tcme.

  MODIFY ct_tcme FROM VALUE tcme( klart = iv_class_type_to ) TRANSPORTING klart WHERE klart = iv_class_type_from.

ENDMETHOD.