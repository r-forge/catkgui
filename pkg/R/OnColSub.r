"OnColSub" <- function(df.entry,ChooseColSub.but,colsubvar)
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
      sublcol<-NULL

      ColSubWin<-tktoplevel()
      tkwm.title(ColSubWin,"Select supplementary columns")
      #cr?ation de la fonction DOK.funct
      OK.fun<-function()
      {
        vsup.select<-listvar.nom[as.numeric(tkcurselection(listvar))+1]
        if(length(vsup.select)==0)
        {
          assign("sublcol", NULL, envir=env)
    #      tclvalue(.DilluLabel)<-paste(firstLabel, "", sep=" ")
          tkconfigure(ChooseColSub.but, fg="black",text="Select")
          tclvalue(colsubvar)<-""
          tkdestroy(ColSubWin)
          return()
        }
        assign("sublcol", vsup.select, envir=env)
        tclvalue(colsubvar)<-sublcol
   #     tclvalue(.DilluLabel)<-paste(label, "", sep=" ")
        tkconfigure(ChooseColSub.but, fg="blue",text="Modify")
        tkdestroy(ColSubWin)

      }

      # cr?ation et mise en page de la fenetre Dillu
      listvar<-tklistbox(ColSubWin,selectmode="extended",exportselection="FALSE",yscrollcommand=function(...)tkset(scrvar,...)) # Liste vide
      scrvar <-tkscrollbar(ColSubWin,repeatinterval=5,command=function(...)tkyview(listvar,...))
      listvar.nom<-NULL
      indice<-0

      for (i in (1:ncol(get(obj)))) {
          if (is.numeric(get(obj)[,i])) {
            tkinsert(listvar,"end",vars[i]) # On renseigne la liste
            listvar.nom<-c(listvar.nom,vars[i])
            if(vars[i] %in% sublcol) tkselection.set(listvar, indice)
            indice<-indice+1
          }
      }

      OK.but<-tkbutton(ColSubWin, text="OK", width=16,command=OK.fun)

      tkgrid(tklabel(ColSubWin, text=""))
      tkgrid(tklabel(ColSubWin, text = "Select supplementary column(s)", fg = "blue"), column=1, columnspan = 1, sticky = "ew")
      tkgrid(listvar, scrvar, sticky = "nw")
      tkgrid.configure(scrvar, sticky = "ens", columnspan=1)
      tkgrid.configure(listvar, sticky = "ew", column=1, columnspan=1)
      tkgrid(tklabel(ColSubWin, text=""))
      tkgrid(OK.but, column=1,columnspan=1, sticky="ew")
      tkgrid(tklabel(ColSubWin, text=""))
      tkgrid.columnconfigure(ColSubWin,0, minsize=25)
      tkgrid.columnconfigure(ColSubWin,2, minsize=25)

  }
