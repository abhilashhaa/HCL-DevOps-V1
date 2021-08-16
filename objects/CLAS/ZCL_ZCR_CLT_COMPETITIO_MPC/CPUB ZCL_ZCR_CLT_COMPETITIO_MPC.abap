class ZCL_ZCR_CLT_COMPETITIO_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  types:
     TS_A_LOGINTYPE type ZCRCPLAYERS .
  types:
TT_A_LOGINTYPE type standard table of TS_A_LOGINTYPE .
  types:
   begin of ts_text_element,
      artifact_name  type c length 40,       " technical name
      artifact_type  type c length 4,
      parent_artifact_name type c length 40, " technical name
      parent_artifact_type type c length 4,
      text_symbol    type textpoolky,
   end of ts_text_element .
  types:
         tt_text_elements type standard table of ts_text_element with key text_symbol .
  types:
     TS_A_PLAYERSTYPE type ZCRCPLAYERS .
  types:
TT_A_PLAYERSTYPE type standard table of TS_A_PLAYERSTYPE .
  types:
     TS_A_GAMESTYPE type ZCRCGAMES .
  types:
TT_A_GAMESTYPE type standard table of TS_A_GAMESTYPE .
  types:
     TS_A_SCHEDULESTYPE type ZCRCSCHEDULES .
  types:
TT_A_SCHEDULESTYPE type standard table of TS_A_SCHEDULESTYPE .
  types:
     TS_A_PAIRSTYPE type ZCRCPAIRS .
  types:
TT_A_PAIRSTYPE type standard table of TS_A_PAIRSTYPE .

  constants GC_A_GAMESTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'A_GamesType' ##NO_TEXT.
  constants GC_A_LOGINTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'A_LoginType' ##NO_TEXT.
  constants GC_A_PAIRSTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'A_PairsType' ##NO_TEXT.
  constants GC_A_PLAYERSTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'A_PlayersType' ##NO_TEXT.
  constants GC_A_SCHEDULESTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'A_SchedulesType' ##NO_TEXT.

  methods LOAD_TEXT_ELEMENTS
  final
    returning
      value(RT_TEXT_ELEMENTS) type TT_TEXT_ELEMENTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .