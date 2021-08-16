CLASS th_ngc_core_chr_pers_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING .

  PUBLIC SECTION.

    TYPES:
      tt_i_clfncharacteristic TYPE STANDARD TABLE OF i_clfncharacteristicforkeydate WITH DEFAULT KEY .
    TYPES:
      tt_i_clfncharcvalue   TYPE STANDARD TABLE OF i_clfncharcvalueforkeydate WITH DEFAULT KEY .
    TYPES:
      tt_i_clfncharcreference      TYPE STANDARD TABLE OF i_clfncharcreference WITH DEFAULT KEY .
    TYPES:
      tt_mara TYPE STANDARD TABLE OF mara WITH DEFAULT KEY .
    TYPES:
      tt_makt TYPE STANDARD TABLE OF makt WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ts_charc_value_fm,
        charcinternalid       TYPE atinn,
        charcvalue            TYPE atwrt,
        charcvaluedescription TYPE atwtb,
        phrase                TYPE rcgatf4phr-phrcode,
        keydate               TYPE dats,
      END OF ts_charc_value_fm .
    TYPES:
      tt_charc_value_fm TYPE STANDARD TABLE OF ts_charc_value_fm WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ts_characteristic_with_keydate,
        characteristics TYPE tt_i_clfncharacteristic,
        keydate         TYPE dats,
      END OF ts_characteristic_with_keydate .
    TYPES:
      tt_characteristic_with_keydate TYPE STANDARD TABLE OF ts_characteristic_with_keydate .
    TYPES:
      BEGIN OF ts_charc_value_with_keydate,
        charc_values TYPE tt_i_clfncharcvalue,
        keydate      TYPE dats,
      END OF ts_charc_value_with_keydate .
    TYPES:
      tt_charc_value_with_keydate TYPE STANDARD TABLE OF ts_charc_value_with_keydate .
    TYPES:
      tt_charc_ref_table TYPE STANDARD TABLE OF tt_i_clfncharcreference WITH DEFAULT KEY .

    CONSTANTS cv_keydate_2017 TYPE dats VALUE '20170101' ##NO_TEXT.
    CONSTANTS cv_keydate_2018 TYPE dats VALUE '20180101' ##NO_TEXT.
    CONSTANTS cv_checktable_mara TYPE tabelle VALUE 'MARA' ##NO_TEXT.
    CONSTANTS cv_texttable_makt TYPE tabelle VALUE 'MAKT' ##NO_TEXT.
    CONSTANTS cv_function_module_01 TYPE rs38l_fnam VALUE 'CHARC_FM' ##NO_TEXT.
    CONSTANTS cv_function_module_charcid_01 TYPE atinn VALUE '0000000100' ##NO_TEXT.
    CONSTANTS cv_function_moduel_charc_01 TYPE atnam VALUE 'FUNCMOD_CHARC' ##NO_TEXT.
    CONSTANTS cv_value_01 TYPE atwrt VALUE 'VALUE_01' ##NO_TEXT.
    CONSTANTS cv_value_02 TYPE atwrt VALUE 'VALUE_02' ##NO_TEXT.
    CONSTANTS cv_phrase_01 TYPE rcgatf4phr-phrcode VALUE 'Phrase' ##NO_TEXT.

    CLASS-METHODS get_characteristics_2017
      RETURNING
        VALUE(rt_characteristic) TYPE tt_i_clfncharacteristic .
    CLASS-METHODS get_characteristics_2018
      RETURNING
        VALUE(rt_characteristic) TYPE tt_i_clfncharacteristic .
    CLASS-METHODS get_charc_value_2017
      RETURNING
        VALUE(rt_charc_value) TYPE tt_i_clfncharcvalue .
    CLASS-METHODS get_charc_value_2018
      RETURNING
        VALUE(rt_charc_value) TYPE tt_i_clfncharcvalue .
    CLASS-METHODS get_charc_value_fm_exp
      RETURNING
        VALUE(rt_charc_value) TYPE ngct_core_charc_value .
    CLASS-METHODS get_charc_ref
      RETURNING
        VALUE(rt_charc_ref) TYPE tt_i_clfncharcreference .
    CLASS-METHODS get_charc_checktab_2017
      RETURNING
        VALUE(rt_characteristic) TYPE tt_i_clfncharacteristic .
    CLASS-METHODS get_charc_funcmod_2017
      RETURNING
        VALUE(rt_characteristic) TYPE tt_i_clfncharacteristic .
    CLASS-METHODS get_not_existing_charc
      RETURNING
        VALUE(rt_characteristic) TYPE tt_i_clfncharacteristic .
    CLASS-METHODS get_mara_for_checktable
      RETURNING
        VALUE(rt_mara) TYPE tt_mara .
    CLASS-METHODS get_makt_for_checktable
      RETURNING
        VALUE(rt_makt) TYPE tt_makt .
    CLASS-METHODS get_fm_charc_01_values
      RETURNING
        VALUE(rt_value) TYPE tt_charc_value_fm .