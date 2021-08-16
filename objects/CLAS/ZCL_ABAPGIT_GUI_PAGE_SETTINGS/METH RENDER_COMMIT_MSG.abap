  METHOD render_commit_msg.
    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<h2>Commit Message</h2>| ).
    ri_html->add( |<label for="comment_length" title="(Recommendation 50)">Max. Length of Comment</label>| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<input name="comment_length" type="number" step="10" size="3" maxlength="3" min="50"| &&
                  | value="{ mo_settings->get_commitmsg_comment_length( ) }">| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<label for="comment_default"| &&
                  |title="(Possible Variables: $OBJECT, $FILE)">Default for Comment</label>| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<input name="comment_default" type="text" size="80" maxlength="255"| &&
                  | value="{ mo_settings->get_commitmsg_comment_default( ) }">| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<label for="body_size" title="(Recommendation 72)">Max. Line Size of Body</label>| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<input name="body_size" type="number" size="3" maxlength="3" min="50"| &&
                  | value="{ mo_settings->get_commitmsg_body_size( ) }">| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).
  ENDMETHOD.