METHOD if_ngc_drf_ewm_util~change_classtype_class.

  MODIFY ct_klah FROM VALUE klah( klart = iv_class_type_to ) TRANSPORTING klart WHERE klart = iv_class_type_from.

  MODIFY ct_ksml FROM VALUE ksml( klart = iv_class_type_to ) TRANSPORTING klart WHERE klart = iv_class_type_from.

ENDMETHOD.