(load "NuHTTPHelpers")
(load "NuJSON")
(load "NuMarkup")
(load "NuMarkup:xhtml")

(load "common/application.nu")
(load "common/database.nu")

(set codecache (dict))

(macro generate (format code)
     `(progn
            (try
                ;; if necessary, parse and cache the action-handling code.
                (set parsed (codecache ,code))
                (unless parsed
                        (set parsed (_parser parse:(NSString stringWithContentsOfFile:,code)))
                        (codecache setObject:parsed forKey:,code))
                ;; run the action handler
                (set result (eval parsed))
                ;; handle exceptions, including early returns
                (catch (exception)
                       (if (exception isKindOfClass:NuReturnException)
                           (then (set result (exception value)))
                           (else (set result (+ "error: " (exception description)))))))
            (case ,format
                  (html: ;; all handlers used with this macro are expected to return HTML
                   (REQUEST setContentType:"text/html")
                   (result dataUsingEncoding:NSUTF8StringEncoding))
                  (json: ;; all handlers used with this macro are expected to return a dictionary that we convert to JSON
                   (REQUEST setContentType:"application/json")
                   (puts (result description))
                   ((result JSONRepresentation) dataUsingEncoding:NSUTF8StringEncoding)))))

(set HOST "tiny.io")

(post "/api/shorten"
      (generate json:"site/shorten.nu"))

(get "/hits/recent"
     (generate html:"site/hits-recent.nu"))

(get "/hits/referrer"
     (generate html:"site/hits-referrer.nu"))

(get "/hits/useragent"
     (generate html:"site/hits-useragent.nu"))

(get "/hits/url/tinyurl:"
     (generate html:"site/hits-tinyurl.nu"))

(get "/hits/ip/ip:"
     (generate html:"site/hits-ip.nu"))

(get "/id:"
     (generate html:"site/redirect.nu"))

