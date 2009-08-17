"OnColSup" <- function(df.entry,ChooseColSup.but,colsupvar)
{
      env<-environment()
      if (tclvalue(tkget(df.entry))!='')
        obj<-(tclvalue(tkget(df.entry)))
      else
      {
        tkmessageBox(title="Error",message="Please select a data set.",icon="error",type="ok")
        return(0);
      }

      vars<-colnames(get(obj))
      suplcol<-NULL

      ColSupWin<-tktoplevel()
      tkwm.title(ColSupWin,"Select supplementary columns")
      #cr?ation de la fonction DOK.funct
      OK.fun<-function()
      {
        vsup.select<-listvar.nom[as.numeric(tkcurselection(listvar))+1]
        if(length(vsup.select)==0)
        {
          assign("suplcol", NULL, envir=env)
    #      tclvalue(.DilluLabel)<-paste(firstLabel, "", sep=" ")
          tkconfigure(ChooseColSup.but, fg="black",text="Select")
           tclvalue(colsupvar)<-""
          tkdestroy(ColSupWin)
          return()
        }
        assign("suplcol", vsup.select, envir=env)
        tclvalue(colsupvar)<-suplcol
   #     tclvalue(.DilluLabel)<-paste(label, "", sep=" ")
        tkconfigure(ChooseColSup.but, fg="blue",text="Modify")
        tkdestroy(ColSupWin)

      }

      # cr?ation et mise en page de la fenetre Dillu
      listvar<-tklistbox(ColSupWin,selectmode="extended",exportselection="FALSE",yscrollcommand=function(...)tkset(scrvar,...)) # Liste vide
      scrvar <-tkscrollbar(ColSupWin,repeatinterval=5,command=function(...)tkyview(listvar,...))
      listvar.nom<-NULL
      indice<-0
      
      for (i in (1:ncol(get(obj)))) {
          if (is.numeric(get(obj)[,i])) {
            tkinsert(listvar,"end",vars[i]) # On renseigne la liste
            listvar.nom<-c(listvar.nom,vars[i])
            if(vars[i] %in% suplcol) tkselection.set(listvar, indice)
            indice<-indice+1
          }
      }

      OK.but<-tkbutton(ColSupWin, text="OK", width=16,command=OK.fun)

      tkgrid(tklabel(ColSupWin, text=""))
      tkgrid(tklabel(ColSupWin, text = "Select supplementary column(s)", fg = "blue"), column=1, columnspan = 1, sticky = "ew")
      tkgrid(listvar, scrvar, sticky = "nw")
      tkgrid.configure(scrvar, sticky = "ens", columnspan=1)
      tkgrid.configure(listvar, sticky = "ew", column=1, columnspan=1)
      tkgrid(tklabel(ColSupWin, text=""))
      tkgrid(OK.but, column=1,columnspan=1, sticky="ew")
      tkgrid(tklabel(ColSupWin, text=""))
      tkgrid.columnconfigure(ColSupWin,0, minsize=25)
      tkgrid.columnconfigure(ColSupWin,2, minsize=25)

  }
