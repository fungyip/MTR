myList <- list(`0` = c(`1` = 10, `2` = 20, `3` = 30, `4` = 72),
               `1` = c(`1` = 15, `2` = 9, `3` = 7))


myList


# As a list of one-column data.frames
lapply(myList, `[`, 1)
# $`0`
#  1 
# 10 
# 
# $`1`
#  1 
# 15 


# As a list of vectors
lapply(myList, `[[`, 1)
# $`0`
# [1] 10
# 
# $`1`
# [1] 15

# As a named vector
sapply(myList, `[[`, 1)
#  0  1 
# 10 15 

# As an unnamed vector
unname(sapply(myList, `[[`, 1))
# [1] 10 15



## Same output as above, different syntax
lapply(myList, function(x) x[1])
lapply(myList, function(x) x[[1]])
sapply(myList, function(x) x[[1]])
unname(sapply(myList, function(x) x[[1]]))


######################################################################################
# http://stackoverflow.com/questions/13016359/how-to-directly-select-the-same-column-from-all-nested-lists-within-a-list
# An example nested list
myNestedList <- list(A = list(`0` = c(`1` = 10, `2` = 20, `3` = 30, `4` = 72),
                              `1` = c(`1` = 15, `2` = 9, `3` = 7)),
                     B = list(`0` = c(A = 11, B = 12, C = 13),
                              `1` = c(X = 14, Y = 15, Z = 16)))

# Run the following and see what you come up with....
lapply(unlist(myNestedList, recursive = FALSE), `[`, 1)
lapply(unlist(myNestedList, recursive = FALSE), `[[`, 1)
sapply(unlist(myNestedList, recursive = FALSE), `[[`, 1)
rapply(myNestedList, f=`[[`, ...=1, how="unlist")






# https://www.r-bloggers.com/converting-a-list-to-a-data-frame/

test1 <- list( c(a='a',b='b',c='c'), c(a='d',b='e',c='f'))
as.data.frame(test1)