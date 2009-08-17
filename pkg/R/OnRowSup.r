"OnRowSup" <- function(df.entry,ChooseRowSup.but,rowsupvar)
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
      suplrow<-NULL

      RowSupWin<-tktoplevel()
      tkwm.title(RowSupWin,"Select supplementary rows")

      #cr?ation de la fonction LOK.funct
      OK.fun<-function()
      {
        Ligne.select<-rows[as.numeric(tkcurselection(listLigne))+1]
        if(length(Ligne.select)==0)
        {
          assign("suplrow", NULL, envir=env)
        #  tclvalue(.LilluLabel)<-paste(firstLabel, "", sep=" ")
          tkconfigure(ChooseRowSup.but, fg="black",text="Select")
          tclvalue(rowsupvar)<-""
          tkdestroy(RowSupWin)
          return()
        }
        assign("suplrow", Ligne.select, envir=env)
        tclvalue(rowsupvar)<-suplrow
      
        #as.character(vnr[numi]))
#        tclvalue(.LilluLabel)<-paste(label, ": OK", sep=" ")
       # tclvalue(.LilluLabel)<-paste(label, "", sep=" ")
        tkconfigure(ChooseRowSup.but, fg="blue",text="Modify")
        tkdestroy(RowSupWin)
      
      }
        # cr?ation et mise en page de la fenetre Lillu
      listLigne<-tklistbox(RowSupWin,selectmode="extended",exportselection="FALSE",yscrollcommand=function(...)tkset(scrLigne,...)) # Liste vide
      scrLigne <-tkscrollbar(RowSupWin,repeatinterval=5,command=function(...)tkyview(listLigne,...))
      indice<-0

      for (i in (1:nrow(get(obj))))
      {
          tkinsert(listLigne,"end",rows[i]) # On renseigne la liste
          if(rows[i] %in% suplrow) tkselection.set(listLigne, indice)
          indice<-indice+1
        }

        OK.but<-tkbutton(RowSupWin, text="OK", width=16,command=OK.fun)

        tkgrid(tklabel(RowSupWin, text=""))
        tkgrid(tklabel(RowSupWin, text = "Select supplementary row(s)", fg = "blue"), column=1, columnspan = 1, sticky = "ew")
        tkgrid(listLigne, scrLigne, sticky = "nw")
        tkgrid.configure(scrLigne, sticky = "ens", columnspan=1)
        tkgrid.configure(listLigne, sticky = "ew", column=1, columnspan=1)
        tkgrid(tklabel(RowSupWin, text=""))
        tkgrid(OK.but, column=1,columnspan=1, sticky="ew")
        tkgrid(tklabel(RowSupWin, text=""))
        tkgrid.columnconfigure(RowSupWin,0, minsize=25)
        tkgrid.columnconfigure(RowSupWin,2, minsize=25)
        
  }
