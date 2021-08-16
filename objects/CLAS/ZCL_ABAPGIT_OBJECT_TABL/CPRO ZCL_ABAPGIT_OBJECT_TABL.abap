  PROTECTED SECTION.
    TYPES: BEGIN OF ty_segment_definition,
             segmentheader     TYPE edisegmhd,
             segmentdefinition TYPE edisegmdef,
             segmentstructures TYPE STANDARD TABLE OF edisegstru WITH DEFAULT KEY,
           END OF ty_segment_definition.
    TYPES: ty_segment_definitions TYPE STANDARD TABLE OF ty_segment_definition WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_tabl_extras,
             tddat TYPE tddat,
           END OF ty_tabl_extras.

    "! get additional data like table authorization group
    "! @parameter iv_tabname | name of the table
    METHODS read_extras IMPORTING iv_tabname            TYPE ddobjname
                        RETURNING VALUE(rs_tabl_extras) TYPE ty_tabl_extras.

    "! Update additional data
    "! @parameter iv_tabname | name of the table
    "! @parameter is_tabl_extras | additional table data
    METHODS update_extras IMPORTING iv_tabname     TYPE ddobjname
                                    is_tabl_extras TYPE ty_tabl_extras.

    "! Delete additional data
    "! @parameter iv_tabname | name of the table
    METHODS delete_extras IMPORTING iv_tabname TYPE ddobjname.

    "! Serialize IDoc Segment type/definition if exits
    "! @parameter io_xml | XML writer
    "! @raising zcx_abapgit_exception | Exceptions
    METHODS serialize_idoc_segment IMPORTING io_xml TYPE REF TO zif_abapgit_xml_output
                                   RAISING   zcx_abapgit_exception.

    "! Deserialize IDoc Segment type/definition if exits
    "! @parameter io_xml | XML writer
    "! @parameter iv_package | Target package
    "! @parameter rv_deserialized | It's a segment and was desserialized
    "! @raising zcx_abapgit_exception | Exceptions
    METHODS deserialize_idoc_segment IMPORTING io_xml                 TYPE REF TO zif_abapgit_xml_input
                                               iv_package             TYPE devclass
                                     RETURNING VALUE(rv_deserialized) TYPE abap_bool
                                     RAISING   zcx_abapgit_exception.
    "! Delete the IDoc Segment type if exists
    "! @parameter rv_deleted | It's a segment and was deleted
    "! @raising zcx_abapgit_exception | Exceptions
    METHODS delete_idoc_segment RETURNING VALUE(rv_deleted) TYPE abap_bool
                                RAISING   zcx_abapgit_exception.