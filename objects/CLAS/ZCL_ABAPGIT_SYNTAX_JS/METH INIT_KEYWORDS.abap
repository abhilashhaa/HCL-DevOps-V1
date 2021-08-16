  METHOD init_keywords.

    DATA: lv_keywords TYPE string.

    CLEAR gt_keywords.

    " 1) General keywords
    lv_keywords =
    'alert|all|body|break|bytetostring|case|continue|default|delete|do|document|else|event|export|for|function|if|' &&
    'import|in|innerhtml|isnan|item|mimetypes|navigator|new|onabort|onblur|onchange|onclick|ondblclick|ondragdrop|' &&
    'onerror|onfocus|onkeydown|onkeypress|onkeyup|onload|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|' &&
    'onmove|onreset|onselect|onsubmit|onunload|onresize|options|parsefloat|parseint|prototype|return|screen|switch|' &&
    'unit|var|void|while|window|with|anchor|applet|area|button|checkbox|fileupload|form|frame|hidden|link|mimetype|' &&
    'password|plugin|radio|reset|select|submit|text|textarea|abs|acos|alert|anchor|asin|atan|atan2|back|big|blink|' &&
    'blur|bold|captureevents|ceil|charat|charcodeat|clearinterval|cleartimeout|click|close|concat|confirm|cos|' &&
    'disableexternalcapture|enableexternalcapture|eval|exp|find|fixed|floor|focus|fontcolor|fontsize|forward|' &&
    'fromcharcode|getdate|getday|getelementbyid|gethours|getminutes|getmonth|getoptionvalue|getoptionvaluecount|' &&
    'getseconds|getselection|gettime|gettimezoneoffset|getyear|go|handleevent|home|indexof|italics|javaenabled|join|' &&
    'lastindexof|link|load|log|match|max|min|moveabove|movebelow|moveby|moveto|movetoabsolute|open|parse|plugins|' &&
    'pop|pow|preference|print|prompt|push|random|refresh|releaseevents|reload|replace|reset|resizeby|resizeto|' &&
    'reverse|round|routeevent|scroll|scrollby|scrollto|search|select|setdate|sethours|setinterval|setminutes|' &&
    'setmonth|setseconds|settime|settimeout|setyear|shift|sin|slice|small|sort|splice|split|sqrt|stop|strike|sub|' &&
    'submit|substr|substring|sup|taintenabled|tan|togmtstring|tolocalestring|tolowercase|tostring|touppercase|' &&
    'unshift|unwatch|utc|valueof|watch|write|writeln|e|ln10|ln2|log10e|log2e|max_value|min_value|negative_infinity|' &&
    'nan|pi|positive_infinity|url|above|action|alinkcolor|anchors|appcodename|appname|appversion|applets|arguments|' &&
    'arity|availheight|availwidth|background|backgroundcolor|below|bgcolor|border|bottom|caller|cancelbubble|' &&
    'checked|clientheight|clientwidth|clientx|clienty|clip|closed|color|colordepth|complete|constructor|cookie|' &&
    'count|current|defaultchecked|defaultselected|defaultstatus|defaultvalue|description|display|document|domain|' &&
    'elements|embeds|enabledplugin|encoding|false|fgcolor|filename|form|formname|forms|frames|hash|height|history|' &&
    'host|hostname|href|hspace|images|innerheight|innerwidth|language|lastmodified|layers|left|length|linkcolor|' &&
    'links|location|locationbar|lowsrc|menubar|method|mimetypes|name|next|null|offsetheight|offsetleft|offsetparent|' &&
    'offsetwidth|opener|outerheight|outerwidth|pagex|pagexoffset|pagey|pageyoffset|parent|parentlayer|pathname|' &&
    'personalbar|pixeldepth|platform|plugins|port|poswidth|previous|protocol|prototype|referrer|right|scrolltop|' &&
    'scrollbars|search|selected|selectedindex|self|siblingabove|siblingbelow|src|srcelement|status|statusbar|style|' &&
    'suffixes|tags|target|text|this|title|toolbar|top|true|type|useragent|value|visibility|vlinkcolor|vspace|width|' &&
    'window|zindex'.
    insert_keywords( iv_keywords = lv_keywords
                     iv_token = c_token-keyword ).

    " 2) Variable types
    lv_keywords =
    'array|boolean|date|function|image|layer|math|number|object|option|regexp|string'.
    insert_keywords( iv_keywords = lv_keywords
                     iv_token = c_token-variables ).

  ENDMETHOD.