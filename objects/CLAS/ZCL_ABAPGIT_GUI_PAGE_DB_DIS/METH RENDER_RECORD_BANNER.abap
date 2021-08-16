  METHOD render_record_banner.
    rv_html = |<table class="tag"><tr><td class="label">Type:</td>|
           && | <td>{ is_key-type }</td></tr></table>|
           && zif_abapgit_definitions=>c_newline
           && |<table class="tag"><tr><td class="label">Key:</td>|
           && |  <td>{ is_key-value }</td></tr></table>|.
  ENDMETHOD.