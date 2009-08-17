
################################
# Function to choose the dataframe : builds a listbox containing the dataframes
# that are in the global environment and allows the user to choose one
################################
"ChooseDataFrame" <- function(df.entry, dfnr.label, dfnc.label)
{
	tf <- tktoplevel()
	tkwm.title(tf,"Choose dataframe")
	done <- tclVar(0)

	vnr <- NULL
	vnc <- NULL
	numi <- 1

	listbox.df <- tklistbox(tf)
	scr.df <- tkscrollbar(tf, repeatinterval=5, command=function(...)tkyview(listbox.df,...))
	tkconfigure(listbox.df, yscrollcommand=function(...)tkset(scr.df,...))
	frame1 <- tkframe(tf, relief="groove", borderwidth=2)
	cancel.but <- tkbutton(frame1, text="Cancel", command=function()tkdestroy(tf))
	submit.but <- tkbutton(frame1, text="Choose", default="active", command=function()tclvalue(done)<-1)
	tkpack(cancel.but, submit.but, side="left")
	tkpack(frame1, side="bottom")
	tkpack(listbox.df, side="left", fill="both", expand=TRUE)
	tkpack(scr.df, side="right", fill="y")

	obj <- ls(globalenv())
#
# For all objects in the global environment, check to see if it is a dataframe
# or a list. If it is a data frame, insert it in the listbox, and if it is a list,
# check its elements.
#
	flb <- function(x1) {
		xobj <- get(x1, envir=globalenv())
		if (is.data.frame(xobj)) {
			tkinsert(listbox.df , "end", x1)
			cbind(nrow(xobj),ncol(xobj))
		} else if (is.list(xobj)) {
			if (length(names(xobj)) != 0) {
				fn1 <- function(x) {
					sobjn <- paste(x1,"$",x,sep="")
					sobj <- try(eval(parse(text=sobjn)), silent=TRUE)
					if (is.data.frame(sobj)) {
						tkinsert(listbox.df , "end", sobjn)
					}
				}
				sapply(names(xobj), fn1)
				fn2 <- function(x) {
					sobjn <- paste(x1,"$",x,sep="")
					sobj <- try(eval(parse(text=sobjn)), silent=TRUE)
					if (is.data.frame(sobj)) {
						cbind(nrow(sobj), ncol(sobj))
					}
				}
				res <- sapply(names(xobj), fn2)
				return(res)
			}
		}
	}
	v <- unlist(lapply(obj, flb))
	if (length(v) > 0) {
		vnr <- v[seq(from=1,to=length(v),by=2)]
		vnc <- v[seq(from=2,to=length(v),by=2)]
	}

	tkbind(listbox.df , "<Double-ButtonPress-1>", function() tclvalue(done)<-1)
	tkbind(tf, "<Destroy>", function() tclvalue(done)<-2)
	tkbind(tf, "<KeyPress-Return>", function() tclvalue(done)<-1)
	tkbind(tf, "<KeyPress-Escape>", function() tkdestroy(tf))

	tkwait.variable(done)
	if(tclvalue(done)=="2") return(0)
#
# Get the number of the element choosed by the user
#
	numc <- tclvalue(tkcurselection(listbox.df))
	numi <- as.integer(numc)+1

	if(numc == "") {
		tkdestroy(tf)
		return(0)
	}

	choix <- tclvalue(tkget(listbox.df, numc))

#
# Put the name of the object in the dataframe text entry
#
	tkdelete(df.entry, 0, "end")
	tkinsert(df.entry, "end", choix)
#
# Put the row and column numbers of the dataframe in the corresponding labels
#
	tkconfigure(dfnr.label, text=as.character(vnr[numi]))
	tkconfigure(dfnc.label, text=as.character(vnc[numi]))

	tkdestroy(tf)
}
