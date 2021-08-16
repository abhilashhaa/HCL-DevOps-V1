interface ZIF_CR_I_HEADER_C
  public .


  interfaces /BOBF/IF_LIB_CONSTANTS .

  constants:
    BEGIN OF SC_ACTION,
      BEGIN OF ZCR_I_HEADER,
 ACTIVATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C3AE23350566',
 CREATE_ZCR_I_HEADER            TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C391D6600566',
 DELETE_ZCR_I_HEADER            TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C391D6608566',
 EDIT                           TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C3AE2334E566',
 LOCK_ZCR_I_HEADER              TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C391D65F4566',
 PREPARATION                    TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C3AE23354566',
 SAVE_ZCR_I_HEADER              TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C391D6610566',
 UNLOCK_ZCR_I_HEADER            TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C391D65F8566',
 UPDATE_ZCR_I_HEADER            TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C391D6604566',
 VALIDATE_ZCR_I_HEADER          TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C391D660C566',
 VALIDATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A02B3881EE98094C3AE23352566',
      END OF ZCR_I_HEADER,
    END OF SC_ACTION .
  constants:
    BEGIN OF SC_ACTION_ATTRIBUTE,
        BEGIN OF ZCR_I_HEADER,
        BEGIN OF EDIT,
 PRESERVE_CHANGES               TYPE STRING VALUE 'PRESERVE_CHANGES',
        END OF EDIT,
        BEGIN OF LOCK_ZCR_I_HEADER,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF LOCK_ZCR_I_HEADER,
        BEGIN OF PREPARATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF PREPARATION,
        BEGIN OF UNLOCK_ZCR_I_HEADER,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF UNLOCK_ZCR_I_HEADER,
        BEGIN OF VALIDATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF VALIDATION,
      END OF ZCR_I_HEADER,
    END OF SC_ACTION_ATTRIBUTE .
  constants:
    BEGIN OF SC_ALTERNATIVE_KEY,
      BEGIN OF ZCR_I_HEADER,
 ACTIVE_ENTITY_KEY              TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A02B3881EE98094C3AE2334A566',
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A02B3881EE98094C3AE2334C566',
      END OF ZCR_I_HEADER,
    END OF SC_ALTERNATIVE_KEY .
  constants:
    BEGIN OF SC_ASSOCIATION,
      BEGIN OF ZCR_I_HEADER,
 LOCK                           TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A02B3881EE98094C391D65F2566',
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A02B3881EE98094C391D65EE566',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A02B3881EE98094C391D65FE566',
      END OF ZCR_I_HEADER,
      BEGIN OF ZCR_I_HEADER_LOCK,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A02B3881EE98094C3AE2333E566',
      END OF ZCR_I_HEADER_LOCK,
      BEGIN OF ZCR_I_HEADER_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A02B3881EE98094C3AE2333C566',
      END OF ZCR_I_HEADER_MESSAGE,
      BEGIN OF ZCR_I_HEADER_PROPERTY,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A02B3881EE98094C3AE23340566',
      END OF ZCR_I_HEADER_PROPERTY,
    END OF SC_ASSOCIATION .
  constants:
    BEGIN OF SC_ASSOCIATION_ATTRIBUTE,
      BEGIN OF ZCR_I_HEADER,
        BEGIN OF PROPERTY,
 ALL_NODE_PROPERTY              TYPE STRING VALUE 'ALL_NODE_PROPERTY',
 ALL_NODE_ATTRIBUTE_PROPERTY    TYPE STRING VALUE 'ALL_NODE_ATTRIBUTE_PROPERTY',
 ALL_ASSOCIATION_PROPERTY       TYPE STRING VALUE 'ALL_ASSOCIATION_PROPERTY',
 ALL_ASSOCIATION_ATTRIBUTE_PROP TYPE STRING VALUE 'ALL_ASSOCIATION_ATTRIBUTE_PROP',
 ALL_ACTION_PROPERTY            TYPE STRING VALUE 'ALL_ACTION_PROPERTY',
 ALL_ACTION_ATTRIBUTE_PROPERTY  TYPE STRING VALUE 'ALL_ACTION_ATTRIBUTE_PROPERTY',
 ALL_QUERY_PROPERTY             TYPE STRING VALUE 'ALL_QUERY_PROPERTY',
 ALL_QUERY_ATTRIBUTE_PROPERTY   TYPE STRING VALUE 'ALL_QUERY_ATTRIBUTE_PROPERTY',
 ALL_SUBTREE_PROPERTY           TYPE STRING VALUE 'ALL_SUBTREE_PROPERTY',
        END OF PROPERTY,
      END OF ZCR_I_HEADER,
    END OF SC_ASSOCIATION_ATTRIBUTE .
  constants:
    SC_BO_KEY  TYPE /BOBF/OBM_BO_KEY VALUE '000D3A02B3881EE98094C391D65E4566' .
  constants:
    SC_BO_NAME TYPE /BOBF/OBM_NAME VALUE 'ZCR_I_HEADER' .
  constants:
    BEGIN OF SC_DETERMINATION,
      BEGIN OF ZCR_I_HEADER,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '000D3A02B3881EE98094C3AE23356566',
 CENTRAL_ADMIN_DATA             TYPE /BOBF/DET_KEY VALUE '000D3A02B3881EE98094C3AE23358566',
 DELETE_DRAFT_WHN_ACTIVE_DELETE TYPE /BOBF/DET_KEY VALUE '000D3A02B3881EE98094C3AE23366566',
 DRAFT_ACTION_CONTROL           TYPE /BOBF/DET_KEY VALUE '000D3A02B3881EE98094C3AE23364566',
 DRAFT_SYS_ADMIN_DATA           TYPE /BOBF/DET_KEY VALUE '000D3A02B3881EE98094C3AE2335A566',
 DURABLE_LOCK_CLEANUP_CLEANUP   TYPE /BOBF/DET_KEY VALUE '000D3A02B3881EE98094C3AE23362566',
 DURABLE_LOCK_CLEANUP_DELETE    TYPE /BOBF/DET_KEY VALUE '000D3A02B3881EE98094C3AE2335C566',
 DURABLE_LOCK_CLEANUP_FAIL_SAVE TYPE /BOBF/DET_KEY VALUE '000D3A02B3881EE98094C3AE23360566',
 DURABLE_LOCK_CLEANUP_SUCC_SAVE TYPE /BOBF/DET_KEY VALUE '000D3A02B3881EE98094C3AE2335E566',
      END OF ZCR_I_HEADER,
    END OF SC_DETERMINATION .
  constants:
    BEGIN OF SC_GROUP,
 DRAFT_CONSISTENCY              TYPE /BOBF/OBM_GROUP_KEY VALUE '000D3A02B3881EE98094C3AE23344566',
    END OF SC_GROUP .
  constants:
    SC_MODEL_VERSION TYPE /BOBF/CONF_VERSION VALUE '00000' .
  constants:
    BEGIN OF SC_NODE,
 ZCR_I_HEADER                   TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A02B3881EE98094C391D65E8566',
 ZCR_I_HEADER_LOCK              TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A02B3881EE98094C391D65F0566',
 ZCR_I_HEADER_MESSAGE           TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A02B3881EE98094C391D65EC566',
 ZCR_I_HEADER_PROPERTY          TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A02B3881EE98094C391D65FC566',
    END OF SC_NODE .
  constants:
    BEGIN OF SC_NODE_ATTRIBUTE,
      BEGIN OF ZCR_I_HEADER,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  REQUEST_ID                     TYPE STRING VALUE 'REQUEST_ID',
  BILL2_PARTY                    TYPE STRING VALUE 'BILL2_PARTY',
  NAME                           TYPE STRING VALUE 'NAME',
  CITY                           TYPE STRING VALUE 'CITY',
  POSTAL_CODE                    TYPE STRING VALUE 'POSTAL_CODE',
  STREET                         TYPE STRING VALUE 'STREET',
  TEL_NUM                        TYPE STRING VALUE 'TEL_NUM',
  STERM_1                        TYPE STRING VALUE 'STERM_1',
  STERM_2                        TYPE STRING VALUE 'STERM_2',
  HASACTIVEENTITY                TYPE STRING VALUE 'HASACTIVEENTITY',
  DRAFTENTITYCREATIONDATETIME    TYPE STRING VALUE 'DRAFTENTITYCREATIONDATETIME',
  DRAFTENTITYLASTCHANGEDATETIME  TYPE STRING VALUE 'DRAFTENTITYLASTCHANGEDATETIME',
  DRAFTADMINISTRATIVEDATAUUID    TYPE STRING VALUE 'DRAFTADMINISTRATIVEDATAUUID',
  DRAFTENTITYCONSISTENCYSTATUS   TYPE STRING VALUE 'DRAFTENTITYCONSISTENCYSTATUS',
  DRAFTENTITYOPERATIONCODE       TYPE STRING VALUE 'DRAFTENTITYOPERATIONCODE',
  ISACTIVEENTITY                 TYPE STRING VALUE 'ISACTIVEENTITY',
      END OF ZCR_I_HEADER,
    END OF SC_NODE_ATTRIBUTE .
  constants:
    BEGIN OF SC_NODE_CATEGORY,
      BEGIN OF ZCR_I_HEADER,
 ROOT                           TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '000D3A02B3881EE98094C391D65EA566',
      END OF ZCR_I_HEADER,
    END OF SC_NODE_CATEGORY .
  constants:
    BEGIN OF SC_STATUS_VARIABLE,
      BEGIN OF ZCR_I_HEADER,
 DRAFT_CONSISTENCY_STATUS       TYPE /BOBF/STA_VAR_KEY VALUE '000D3A02B3881EE98094C3AE23342566',
      END OF ZCR_I_HEADER,
    END OF SC_STATUS_VARIABLE .
  constants:
    BEGIN OF SC_VALIDATION,
      BEGIN OF ZCR_I_HEADER,
 DURABLE_LOCK_CREATE_FOR_NEW    TYPE /BOBF/VAL_KEY VALUE '000D3A02B3881EE98094C3AE23368566',
      END OF ZCR_I_HEADER,
    END OF SC_VALIDATION .
endinterface.