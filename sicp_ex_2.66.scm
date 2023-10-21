 (define (lookup key records)   
   (cond 
     ((null? records) #f) 
     ((= key (entry (car (records)))) (cadar records)) 
     ((< key (entry (car (records)))) (lookup given-key (left-branch records))) 
     ((> key (entry (car (records))))(lookup key (right-branch records)))))