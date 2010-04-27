(set tiny ((REQUEST bindings) tinyurl:))

(set results (mongo findArray:(dict $query:(dict tiny:tiny) $orderby:(dict created:-1))
                    inCollection:"tinyio.hits" 
                    numberToReturn:100 
                    numberToSkip:0))

(&html
      (&head
            (&meta http-equiv:"Content-type" content:"text/html;charset=UTF8")
            (&link href:"/css/style.css" rel:"stylesheet" type:"text/css")
            (&title "tiny.io"))
      (&body
            (&h1 (&a href:"/hits/recent" "Recent Visitors"))
            (eval (parse (NSString stringWithContentsOfFile:"site/hits-table.nu")))))
