interface IF_NGC_CORE_C
  public .


  constants gc_range_entries_max TYPE int4 VALUE 16000 .
  constants:
    BEGIN OF gc_range_sign,
      include TYPE c LENGTH 1 VALUE 'I' ##NO_TEXT,
*      exclude TYPE c LENGTH 1 VALUE 'E' ##NO_TEXT,
    END OF gc_range_sign .
  constants:
    BEGIN OF gc_range_option,
      equals TYPE c LENGTH 2 VALUE 'EQ' ##NO_TEXT,
    END OF gc_range_option .
  constants:
    BEGIN OF gc_object_state,
      loaded  TYPE ngc_core_object_state VALUE 'L' ##NO_TEXT,
      created TYPE ngc_core_object_state VALUE 'C' ##NO_TEXT,
      deleted TYPE ngc_core_object_state VALUE 'D' ##NO_TEXT,
      updated TYPE ngc_core_object_state VALUE 'U' ##NO_TEXT,
*      archived      TYPE ngc_core_object_state VALUE 'A' ##NO_TEXT,
*      deleted       TYPE ngc_core_object_state VALUE 'D' ##NO_TEXT,
*      freed         TYPE ngc_core_object_state VALUE 'F' ##NO_TEXT,
*      to_be_created TYPE ngc_core_object_state VALUE '2' ##NO_TEXT,
*      deleted       TYPE ngc_core_object_state VALUE '3' ##NO_TEXT,
    END OF gc_object_state .
  constants:
    BEGIN OF gc_msg_severity_category,
      error_or_worse TYPE c LENGTH 3 VALUE 'EAX' ##NO_TEXT,
    END OF gc_msg_severity_category .
  constants GC_OBJ_CLF_ECN_OBJ_TYPE type AETYP value '53' ##NO_TEXT.
  constants:
*  1 EQ         =  V1
*  2 GE  LT     >= V1   <  V2
*  3 GE  LE     >= V1   <= V2
*  4 GT  LT     >  V1   <  V2
*  5 GT  LE     >  V1   <= V2
*  6 LT         <  V1
*  7 LE         <= V1
*  8 GT         >  V1
*  9 GE         >= V1
    BEGIN OF gc_chr_charcvaluedependency,
      eq    TYPE atcod VALUE '1' ##NO_TEXT,
      ge_lt TYPE atcod VALUE '2' ##NO_TEXT,
      ge_le TYPE atcod VALUE '3' ##NO_TEXT,
      gt_lt TYPE atcod VALUE '4' ##NO_TEXT,
      gt_le TYPE atcod VALUE '5' ##NO_TEXT,
      lt    TYPE atcod VALUE '6' ##NO_TEXT,
      le    TYPE atcod VALUE '7' ##NO_TEXT,
      gt    TYPE atcod VALUE '8' ##NO_TEXT,
      ge    TYPE atcod VALUE '9' ##NO_TEXT,
    END OF gc_chr_charcvaluedependency .
  constants:
    BEGIN OF gc_charcnumericvalue_bounds,
      max_charcfromnumericvalue TYPE f VALUE '-999999999999999' ##NO_TEXT,
      max_charctonumericvalue   TYPE f VALUE '999999999999999' ##NO_TEXT,
    END OF gc_charcnumericvalue_bounds .
  constants:
    BEGIN OF gc_clf_object_class_indicator,
      object TYPE klmaf VALUE 'O' ##NO_TEXT,
      class  TYPE klmaf VALUE 'K' ##NO_TEXT,
    END OF gc_clf_object_class_indicator .
  constants:
    BEGIN OF gc_inob_cuobj_number_range,
      number TYPE nrnr VALUE '01' ##NO_TEXT,
      object TYPE nrobj VALUE 'CU_INOB  ' ##NO_TEXT,
    END OF gc_inob_cuobj_number_range .
  constants GC_DATE_ZERO type DATS value '00000000' ##NO_TEXT.
  constants GC_DATE_MIN type DATS value '19000101' ##NO_TEXT.
  constants GC_DATE_MAX type DATS value '99991231' ##NO_TEXT.
  constants GC_TIME_MAX type TIMS value '235959' ##NO_TEXT.
  constants GC_TIME_MIN type TIMS value '000000' ##NO_TEXT.
  constants GC_MAX_ENTRIES_FOR_CHECKTABLE type SYDBCNT value 1000 ##NO_TEXT.
  constants:
    BEGIN OF gc_charcdatatype,
      char TYPE atfor VALUE 'CHAR',
      num  TYPE atfor VALUE 'NUM',
      curr TYPE atfor VALUE 'CURR',
      date TYPE atfor VALUE 'DATE',
      time TYPE atfor VALUE 'TIME',
    END OF gc_charcdatatype .
  constants:
    gc_charc_f4_fm_suffix TYPE c LENGTH 3 value '_F4' ##NO_TEXT.
  constants GC_FM_CHARC_IS_PHRASED type RS38L_FNAM value 'C14K_CHARACT_IS_PHRASED' ##NO_TEXT.
  constants GC_FM_CHARC_PHRASE_TEXT_READ type RS38L_FNAM value 'C14X_PHRASE_TEXT_READ' ##NO_TEXT.
  constants:
    BEGIN OF gc_enqmode,
      shared    TYPE enqmode VALUE 'S' ##NO_TEXT,
      exclusive TYPE enqmode VALUE 'E' ##NO_TEXT,
    END OF gc_enqmode .
  constants GC_MAX_CHARCNUMERICVALUEFROM type F value '-1E308' ##NO_TEXT.
  constants GC_MAX_CHARCNUMERICVALUETO type F value '1E308' ##NO_TEXT.
  constants GC_CHARC_OVERWRITE_REF_IND type C length 1 value '*'.
endinterface.