
################################
# GUI for CA functions
################################
"caTkGUI" <- function()
{
	require(tcltk2) || stop("Package tcltk2 required for running of this program")
  require(ca) || stop("Package ca required for running of this program")
	require(grDevices) || stop("Package grDevices required for running of this program")

#	cmdlist <<- "cmdlist"
#	assign("cmdlist", "cmdlist", envir=.GlobalEnv)
#	winlist <<- 1
#	assign("winlist", 1, envir=.GlobalEnv)

#	if (exists("caTkGUIFlag")) rm("caTkGUIFlag", envir=.GlobalEnv)
#
# Main dialog window with title
#
  env<-environment()
  tt <- tktoplevel()
	tkwm.title(tt,"caTkGUI - A Tcl/Tk GUI for the ca package")
  Rico <- tk2ico.load(file.path(Sys.getenv("R_HOME"), "bin",
      "R.exe"), res = "R")
  tk2ico.set(tt, Rico)
  tk2ico.destroy(Rico)
  rm(Rico)
  tkwm.deiconify(tt)

	#op=options()
	#options(warn=-1)

# Main dialog window with title

# Variables for text fields
  dfvar <- tclVar()
  dudivar <- tclVar()
  nfvar <- tclVar()
	rowsupvar <- tclVar()
	colsupvar <- tclVar()
	rowsubvar <- tclVar()
	colsubvar <- tclVar()
	 
#
# Checkboxes
#

#
# Title
#
	TFrame <- tkframe(tt, relief="groove")
	tkgrid(tklabel(TFrame,text="Simple Correspondence Analysis", font="Times 16", foreground="blue"))
  tkgrid(TFrame)

# Dataframe I/O
	IOFrame <- tkframe(tt, relief="groove", borderwidth=2)
	tkgrid(tklabel(IOFrame,text="- Input & Output -", foreground="blue"), columnspan=5)
	df.entry <- tkentry(IOFrame, textvariable=dfvar)
  dudi.entry <- tkentry(IOFrame, textvariable=dudivar)
  tkinsert(dudi.entry, "end", "res")
  dfnr.label <- tklabel(IOFrame, width=4)
	dfnc.label <- tklabel(IOFrame, width=4)
	
	choosedf.but <- tkbutton(IOFrame, text="Select", command=function() ChooseDataFrame(df.entry, dfnr.label, dfnc.label))
	choosedfHlp.but <- tkbutton(IOFrame,text="?",command=function() tkmessageBox(title="Help",message="The input data set",icon="info",type="ok"))
  tkgrid(tklabel(IOFrame,text="Input data frame : "), df.entry, choosedf.but, choosedfHlp.but, dfnr.label, dfnc.label, sticky="w")
	
  tkgrid(tklabel(IOFrame,text="Output object name : "), dudi.entry, sticky="w")
	tkgrid(IOFrame)

  tkgrid(tklabel(tt,text="    ")) # Blank line

# Buttons for Suprows, Supcols, SubsetRows, SubsetCols
   
# Supframe 
  SupFrame <- tkframe(tt, relief="groove", borderwidth=2)
	tkgrid(tklabel(SupFrame,text="- Supplementary -", foreground="blue"), columnspan=5)
  
  rowsup.entry <- tkentry(SupFrame, textvariable=rowsupvar)
	rowsup.label <- tklabel(SupFrame, width=4)
	ChooseRowSup.but <- tkbutton(SupFrame, text="Select", command=function() OnRowSup(df.entry,ChooseRowSup.but,rowsupvar))
  RowSupHlp.but <- tkbutton(SupFrame,text="?",command=function() tkmessageBox(title="Help",message="Indices of supplementary rows",icon="info",type="ok"))
  tkgrid(tklabel(SupFrame,text="Supplementary Rows : "), rowsup.entry, ChooseRowSup.but,RowSupHlp.but, rowsup.label, sticky="w")
	
	colsup.entry <- tkentry(SupFrame, textvariable=colsupvar)
  colsup.label <- tklabel(SupFrame, width=4)
  ChooseColSup.but <- tkbutton(SupFrame, text="Select", command=function() OnColSup(df.entry,ChooseColSup.but,colsupvar))
	ColSupHlp.but <- tkbutton(SupFrame,text="?",command=function() tkmessageBox(title="Help",message="Indices of supplementary columns",icon="info",type="ok"))
  tkgrid(tklabel(SupFrame,text="Supplementary Columns : "), colsup.entry, ChooseColSup.but, ColSupHlp.but,colsup.label,sticky='w')
  tkgrid(SupFrame)
  
  tkgrid(tklabel(tt,text="    ")) # Blank line

# Subframe 
  SubFrame <- tkframe(tt, relief="groove", borderwidth=2)
	tkgrid(tklabel(SubFrame,text="- Subsets -", foreground="blue"), columnspan=5)
  
  rowsub.entry <- tkentry(SubFrame, textvariable=rowsubvar)
	rowsub.label <- tklabel(SubFrame, width=4)
	ChooseRowSub.but <- tkbutton(SubFrame, text="Select", command=function() OnRowSub(df.entry,ChooseRowSub.but,rowsubvar))
  RowSubHlp.but <- tkbutton(SubFrame,text="?",command=function() tkmessageBox(title="Help",message="Row indices of subset",icon="info",type="ok"))
  tkgrid(tklabel(SubFrame,text="Subset Rows : "), rowsub.entry, ChooseRowSub.but,RowSubHlp.but, rowsub.label, sticky="w")
	
	colsub.entry <- tkentry(SubFrame, textvariable=colsubvar)
  colsub.label <- tklabel(SubFrame, width=4)
  ChooseColSub.but <- tkbutton(SubFrame, text="Select", command=function() OnColSub(df.entry,ChooseColSub.but,colsubvar))
	ColSubHlp.but <- tkbutton(SubFrame,text="?",command=function() tkmessageBox(title="Help",message="Column indices of subset",icon="info",type="ok"))
  tkgrid(tklabel(SubFrame,text="Subset Columns : "), colsub.entry, ChooseColSub.but, ColSubHlp.but,colsub.label,sticky='w')
  tkgrid(SubFrame)

  tkgrid(tklabel(tt,text="    ")) # Blank line
  
# Options
  NAFrame <- tkframe(tt, relief="groove", borderwidth=2)
	tkgrid(tklabel(NAFrame,text="        - Options -        ", foreground="blue"), columnspan=5)
	nf.entry <- tkentry(NAFrame, textvariable=nfvar, width=4, state="normal")
	tkgrid(tklabel(NAFrame,text="Number of dimensions : "), nf.entry, sticky="w")
  tkgrid(tklabel(NAFrame,text="    ")) # Blank line
  tclvalue(nfvar) = 2
  Options.but <- tkbutton(NAFrame, text="Options", command=function() OnColSup(df.entry,ChooseColSub.but))
  OptionsHlp.but <- tkbutton(NAFrame, text="?", command=function() tkmessageBox(title="Help",message="Options",icon="info",type="ok"))
  tkgrid(Options.but, OptionsHlp.but)
  tkgrid(NAFrame)

  tkgrid(tklabel(tt,text="    ")) # Blank line
  
 
#
# Local variables
#
#	vnr=NULL			# Vector of dataframes row numbers
#	vnc=NULL			# Vector of dataframes column numbers
#	numi=1				# Number of choosed element
	#done <- tclVar(0)	# To terminate the dialog

################################
# Function to build the command line from dialog widgets
################################
	"build" <- function()
	{
	#
	# Check that the data frame is not empty and get its name
	#
		if (tclvalue(dfvar) != "") {
			obj  <- parse(text=tclvalue(dfvar))[[1]]
		} else {
			return(0)
		}
		
					if (tclvalue(nfvar) != "")
				nf <- parse(text=tclvalue(nfvar))[[1]]
				else nf <- 2

#   obj<-tclvalue(tkget(df.entry))
#   nf<-tclvalue(tkget(nf.entry))
   substitute(ca(obj = obj,nd = nf)) #suprow = , supcol = NA, subsetrow = NA, subsetcol = NA)) #scannf = scannf, nf = nf
	}

	#
	# If scannf is false, check that nf is not empty and get it
	#
#			if (tclvalue(nfvar) != "")
#				nf <- parse(text=tclvalue(nfvar))[[1]]
#				else nf <- 2
	    	
#	 	  if (tclvalue(tkget(df.entry))!='')  {
#        obj<-(tclvalue(tkget(df.entry)))
#     } else {
#         tkmessageBox(title="Error",message="Please select a data set.",icon="error",type="ok")
#         return(0)
 #     }
 #   if (tclvalue(dfvar) != "") {
	#		df  <- parse(text=tclvalue(dfvar))[[1]]
#		} else {
#		tkmessageBox(title="Error",message="Please select a data set.",icon="error",type="ok")
#			return(0)
	#	}
	#
	# If scannf is false, check that nf is not empty and get it
	#
#		scannf <- as.logical(tclObj(scannfvar))
#		if (!scannf) {
#			if (tclvalue(nfvar) != "")
#				nf <- parse(text=tclvalue(nfvar))[[1]]
#				else nf <- 2
#		} else nf <- 2
	#
	# Make the command line
	#
	
		
################################
# Function to reset all dialog elements to default values
################################
	"reset" <- function()
	{
		tclvalue(dfvar)<-""
		tclvalue(nfvar)<-""
	  tclvalue(rowsupvar) <- ""
    tclvalue(colsupvar) <- ""
    tclvalue(rowsubvar) <- ""
    tclvalue(colsubvar) <- "" 
		tkconfigure(dfnr.label, text="")
		tkconfigure(dfnc.label, text="")
	  tkconfigure(ChooseRowSup.but, fg="black",text="Select")
	  tkconfigure(ChooseColSup.but, fg="black",text="Select")
	  tkconfigure(ChooseRowSub.but, fg="black",text="Select")
	  tkconfigure(ChooseColSub.but, fg="black",text="Select")
  }
	
################################
# Function to launch computations
################################
 	"execcomp" <- function()
	{
		  if (tclvalue(tkget(df.entry))!='')  {
        obj<-(tclvalue(tkget(df.entry)))
     } else {
         tkmessageBox(title="Error",message="Please select a data set.",icon="error",type="ok")
         return(0)
      }
  #
	# Check that the analysis name is not empty and get it
	#
		if (tclvalue(dudivar) == "") tkinsert(dudi.entry, "end", "res")
		dudiname <- parse(text=paste("\"",tclvalue(dudivar)[[1]],"\"",sep=""))
	#
	# Build and display the command line so that the user can check it
	#
		cmd <- build()
		if (cmd == 0) return(0)
#		if (show) {
			#
			# Echoe the command line to the console
			#
#			pr1 <- substr(options("prompt")$prompt, 1,2)
#			cat(eval(dudiname), " <- ", deparse(cmd, width = 256), "\n", pr1, sep="")
#		}
	#
	# Execute the command
	#
#		assign("caTkGUIFlag", 1, envir=.GlobalEnv)
		mydudi <- eval.parent(cmd)
		assign(eval(dudiname), mydudi, pos=1)
		eval(dudiname)
#    plot(ca(get(obj)))    # ,tclvalue(rowsupvar),tclvalue(colsupvar),tclvalue(rowsubvar),tclvalue(colsubvar)
    #dialog.dudi.display(show, history, eval(dudiname))
#		rm("caTkGUIFlag", envir=.GlobalEnv)
#		if (history) {
#			commande = paste(eval(dudiname), " <- ", deparse(cmd, width = 500), sep = "")
#  		rewriteHistory(commande)
#		}
	}

#
# Reset and Submit buttons
#
	RCSFrame <- tkframe(tt, relief="groove")
	reset.but <- tkbutton(RCSFrame, text="Reset", command=reset)
	cancel.but <- tkbutton(RCSFrame, text="Dismiss", command=function() tkdestroy(tt))
	submit.but <- tkbutton(RCSFrame, text="Run", default="active", command=function() execcomp())
	tkgrid(cancel.but, submit.but, reset.but, ipadx=20)	
	tkgrid(RCSFrame)
#
# If window is closed by user, terminate the dialog
#
#	tkbind(tt, "<Destroy>", function() tclvalue(done)<-2)
#	tkbind(tt, "<KeyPress-Return>", function() execcomp())
#	tkbind(tt, "<KeyPress-Escape>", function() tkdestroy(tt))
#
# User closed the window
#
#	if(tclvalue(done)=="2") return()
}

