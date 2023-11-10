(meeting ?dept (Friday . ?t)) 

(rule   (meeting-time ?p ?day-and-time) 
        (or (meeting the-whole-company ?day-and-time) 
            (and (job ?p (?d . ?rest)) 
                (meeting ?d ?day-and-time))))