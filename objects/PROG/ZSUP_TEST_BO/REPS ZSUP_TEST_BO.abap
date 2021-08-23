*****           Implementation of object type ZSUP_TEST            *****
INCLUDE <OBJECT>.
BEGIN_DATA OBJECT. " Do not change.. DATA is generated
* only private members may be inserted into structure private
DATA:
" begin of private,
"   to declare private attributes remove comments and
"   insert private attributes here ...
" end of private,
      KEY LIKE SWOTOBJID-OBJKEY.
END_DATA OBJECT. " Do not change.. DATA is generated

BEGIN_METHOD READ_APP_REJ_COMMENT CHANGING CONTAINER.

DATA: comments TYPE swcont-value,
      reason TYPE swc_object OCCURS 0,
      object_content LIKE solisti1 OCCURS 0,
      workitemid LIKE swr_struct-workitemid,
      subcontainer_all_objects LIKE TABLE OF swr_cont,
      lv_wa_reason LIKE LINE OF subcontainer_all_objects,
      lv_no_att LIKE  sy-index,
      document_id LIKE sofolenti1-doc_id,
      return_code LIKE  sy-subrc,
      ifs_xml_container TYPE  xstring,
      ifs_xml_container_schema TYPE  xstring,
      simple_container LIKE TABLE OF swr_cont,
      message_lines LIKE TABLE OF swr_messag,
      message_struct LIKE TABLE OF swr_mstruc,
      subcontainer_bor_objects LIKE TABLE OF swr_cont.

swc_get_table container 'REASON' reason.
swc_get_element container 'WORKITEMID' workitemid.

  SWC_GET_ELEMENT CONTAINER 'workitemid' WORKITEMID.
  SWC_SET_ELEMENT CONTAINER 'Comments' COMMENTS.

*  SWC_GET_TABLE CONTAINER 'workitemid' WORKITEMID.
*  SWC_SET_TABLE CONTAINER 'Comments' COMMENTS.

* Read the work item container from the work item ID
CALL FUNCTION 'SAP_WAPI_READ_CONTAINER'
  EXPORTING
    workitem_id              = workitemid
    language                 = sy-langu
    user                     = sy-uname
  IMPORTING
    return_code              = return_code
    ifs_xml_container        = ifs_xml_container
    ifs_xml_container_schema = ifs_xml_container_schema
  TABLES
    simple_container         = simple_container
    message_lines            = message_lines
    message_struct           = message_struct
    subcontainer_bor_objects = subcontainer_bor_objects
    subcontainer_all_objects = subcontainer_all_objects.

* Initialize
lv_no_att = 0.

* Read the _ATTACH_OBJECTS element
LOOP AT subcontainer_all_objects INTO lv_wa_reason
                                 WHERE element = '_ATTACH_OBJECTS'.
  lv_no_att = lv_no_att + 1.
  document_id = lv_wa_reason-value.

ENDLOOP.

* Read the SOFM Document
CALL FUNCTION 'SO_DOCUMENT_READ_API1'
  EXPORTING
    document_id    = document_id
  TABLES
    object_content = object_content.

* Pass the text to the exporting parameter
IF sy-subrc = 0.
  READ TABLE object_content INTO comments INDEX 1.
  SHIFT comments BY 5 PLACES LEFT.
  swc_set_element container 'Comments' COMMENTS.
ENDIF.


END_METHOD.