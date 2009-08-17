"OnRowSub" <- function(df.entry,ChooseRowSub.but,rowsubvar)
{
      env<-environment()
      if (tclvalue(tkget(df.entry))!='')
        obj<-(tclvalue(tkget(df.entry)))
      else
      {
         tkmessageBox(title="Error",message="Please select a data set.",icon="error",type="ok")
         return(0);
      }

      rows<-rownames(get(obj))
      sublrow<-NULL

      RowSubWin<-tktoplevel()
      tkwm.title(RowSubWin,"Select supplementary rows")

      #cr?ation de la fonction LOK.funct
      OK.fun<-function()
      {
        Ligne.select<-rows[as.numeric(tkcurselection(listLigne))+1]
        if(length(Ligne.select)==0)
        {
          assign("sublrow", NULL, envir=env)
        #  tclvalue(.LilluLabel)<-paste(firstLabel, "", sep=" ")
          tkconfigure(ChooseRowSub.but, fg="black",text="Select")
           tclvalue(rowsubvar)<-""
          tkdestroy(RowSubWin)
          return()
        }
        assign("sublrow", Ligne.select, envir=env)
        tclvalue(rowsubvar)<-sublrow

        #as.character(vnr[numi]))
#        tclvalue(.LilluLabel)<-paste(label, ": OK", sep=" ")
       # tclvalue(.LilluLabel)<-paste(label, "", sep=" ")
        tkconfigure(ChooseRowSub.but, fg="blue",text="Modify")
        tkdestroy(RowSubWin)

      }
        # cr?ation et mise en page de la fenetre Lillu
      listLigne<-tklistbox(RowSubWin,selectmode="extended",exportselection="FALSE",yscrollcommand=function(...)tkset(scrLigne,...)) # Liste vide
      scrLigne <-tkscrollbar(RowSubWin,repeatinterval=5,command=function(...)tkyview(listLigne,...))
      indice<-0

      for (i in (1:nrow(get(obj))))
      {
          tkinsert(listLigne,"end",rows[i]) # On renseigne la liste
          if(rows[i] %in% sublrow) tkselection.set(listLigne, indice)
          indice<-indice+1
        }

        OK.but<-tkbutton(RowSubWin, text="OK", width=16,command=OK.fun)

        tkgrid(tklabel(RowSubWin, text=""))
        tkgrid(tklabel(RowSubWin, text = "Select supplementary row(s)", fg = "blue"), column=1, columnspan = 1, sticky = "ew")
        tkgrid(listLigne, scrLigne, sticky = "nw")
        tkgrid.configure(scrLigne, sticky = "ens", columnspan=1)
        tkgrid.configure(listLigne, sticky = "ew", column=1, columnspan=1)
        tkgrid(tklabel(RowSubWin, text=""))
        tkgrid(OK.but, column=1,columnspan=1, sticky="ew")
        tkgrid(tklabel(RowSubWin, text=""))
        tkgrid.columnconfigure(RowSubWin,0, minsize=25)
        tkgrid.columnconfigure(RowSubWin,2, minsize=25)

  }
