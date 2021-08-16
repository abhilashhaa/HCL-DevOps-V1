class CL_NGC_CORE_LIST_REF_CHAR_CFG definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF ty_s_valuation.
    TYPES: obtab TYPE inob-obtab.
    TYPES: objek TYPE inob-objek.
    TYPES: objnr TYPE ibin-objnr.
    TYPES: cuobj TYPE inob-cuobj.
    TYPES: atinn TYPE ausp-atinn.
    TYPES: atwrt TYPE ausp-atwrt.
    TYPES: atflv TYPE ausp-atflv.
    TYPES: atflb TYPE ausp-atflb.
    TYPES: atcod TYPE ausp-atcod.
    TYPES: END OF ty_s_valuation .
  types:
    ty_t_valuation TYPE STANDARD TABLE OF ty_s_valuation WITH NON-UNIQUE DEFAULT KEY .
  types:
    BEGIN OF ty_s_config_owners.
    TYPES: instance TYPE ib_instance.
    TYPES: inttyp TYPE ibinttyp.
    TYPES: objkey TYPE ibobjkey.
    TYPES: atinn TYPE atinn.
    TYPES: atwrt TYPE atwrt.
    TYPES: atflv TYPE atflv.
    TYPES: atflb TYPE atflb.
    TYPES: atcod TYPE ibvalcod.
    TYPES: END OF ty_s_config_owners .
  types:
    ty_t_config_owners TYPE STANDARD TABLE OF ty_s_config_owners WITH NON-UNIQUE DEFAULT KEY .

  class-methods GET_VALUATIONS
    returning
      value(RT_VALUATIONS) type TY_T_VALUATION .
  class-methods GET_CONFIG_OWNERS
    importing
      !IT_VALUATION type TY_T_VALUATION
    returning
      value(RT_CONFIG_OWNERS) type TY_T_CONFIG_OWNERS .
  class-methods GET_OBJTYP_EXT_BY_INT
    importing
      !IV_OBJTYP_INT type IBINTTYP
    returning
      value(RV_OBJTYP_EXT) type IBOBJTYP .
  class-methods CLASS_CONSTRUCTOR .