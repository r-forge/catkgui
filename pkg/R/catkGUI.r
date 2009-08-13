    GUI.TopLevel <- tktoplevel()
    tkwm.title(GUI.TopLevel, "caTkGUI")
    Rico <- tk2ico.load(file.path(Sys.getenv("R_HOME"), "bin",
        "R.exe"), res = "R")
    tk2ico.set(GUI.TopLevel, Rico)
    tk2ico.destroy(Rico)
    rm(Rico)
    tkwm.deiconify(GUI.TopLevel)
    GUI.AvailableScreenWidth <- round(as.numeric(tkwinfo("screenwidth",
        GUI.TopLevel)))
    GUI.AvailableScreenHeight <- round(as.numeric(tkwinfo("screenheight",
        GUI.TopLevel)))
    if (GUI.AvailableScreenWidth/GUI.AvailableScreenHeight <=
        1080/720) {
        GUI.ScreenWidth <- min(1080, round(GUI.AvailableScreenWidth *
            0.9))
        GUI.ScreenHeight <- min(720, round(GUI.AvailableScreenWidth/1080 *
            720 * 0.9))
    }
    else {
        GUI.ScreenWidth <- min(1080, round(GUI.AvailableScreenHeight/720 *
            1080 * 0.9))
        GUI.ScreenHeight <- min(720, round(GUI.AvailableScreenHeight *
            0.9))
    }
    .Tcl(paste("wm geometry ", GUI.TopLevel, " ", GUI.ScreenWidth,
        "x", GUI.ScreenHeight, "+", round(GUI.AvailableScreenWidth/2 -
            GUI.ScreenWidth/2, 0), "+", round(GUI.AvailableScreenHeight/2 -
            GUI.ScreenHeight/2, 0), sep = ""))
    .Tcl(paste("wm minsize ", GUI.TopLevel, " 900 600", sep = ""))
    GUI.resize.allowed <- TRUE
    GUI.resize.counter <- 0
    tkbind(GUI.TopLevel, "<Destroy>", function() GUI.resize.allowed <<- FALSE)

    GUI.resize.replot <- function() {
        if (GUI.WindowWidth != (temp1 <- as.numeric(tkwinfo("width",
            GUI.TopLevel))) | GUI.WindowHeight != (temp2 <- as.numeric(tkwinfo("height",
            GUI.TopLevel)))) {
            Biplot.replot()
          #  CurrentTab <- tclvalue(tcl(DiagnosticTabs.nb, "index",
                "current"))
            tcl(DiagnosticTabs.nb, "tab", 0, state = "normal")
            tkselect(DiagnosticTabs.nb, 0)
            ConvergenceTab.replot()
           # PointsTab.replot()
           # GroupsTab.replot()
           # AxesTab.replot()
           # PredictionsTab.place()
           # Kraal.replot()
           # tkselect(DiagnosticTabs.nb, CurrentTab)
           # if (tclvalue(Points.var) %in% c("10", "11", "12"))
           #     tcl(DiagnosticTabs.nb, "tab", 0, state = "normal")
           # else tcl(DiagnosticTabs.nb, "tab", 0, state = "disabled")
            GUI.WindowWidth <<- temp1
            GUI.WindowHeight <<- temp2
        }
        GUI.resize.counter <<- 0
    }

    GUI.resize <- function() {
        if (GUI.resize.allowed) {
            GUI.resize.counter <<- GUI.resize.counter + 1
            temp1 <- .Tcl(paste("after 200 ", suppressWarnings(tclFun(GUI.resize.replot)),
                sep = ""))
            if (GUI.resize.counter > 1)
                .Tcl(paste("after cancel ", temp1, sep = ""))
        }
    }
    
        GUI.BindingsOff <- function() {
        tkconfigure(GUI.TopLevel, cursor = "watch")
        Other.ProgressBar.create()
        tkconfigure(Other.ProgressBar.pb, value = 0)
        .Tcl("update")
        tkbind(GUI.TopLevel, "<Control-s>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-S>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-c>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-C>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-p>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-P>", function() NULL)
        if (.Platform$OS.type != "unix")
            tkbind(GUI.TopLevel, "<Control-+>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-minus>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-g>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-G>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-a>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-A>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-r>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-R>", function() NULL)
        tkbind(GUI.TopLevel, "a", function() NULL)
        tkbind(GUI.TopLevel, "A", function() NULL)
        tkbind(GUI.TopLevel, "r", function() NULL)
        tkbind(GUI.TopLevel, "R", function() NULL)
        tkbind(GUI.TopLevel, "b", function() NULL)
        tkbind(GUI.TopLevel, "B", function() NULL)
        tkbind(GUI.TopLevel, "c", function() NULL)
        tkbind(GUI.TopLevel, "C", function() NULL)
        tkbind(GUI.TopLevel, "d", function() NULL)
        tkbind(GUI.TopLevel, "D", function() NULL)
        tkbind(GUI.TopLevel, "0", function() NULL)
        tkbind(GUI.TopLevel, "1", function() NULL)
        tkbind(GUI.TopLevel, "2", function() NULL)
        tkbind(GUI.TopLevel, "3", function() NULL)
        tkbind(GUI.TopLevel, "4", function() NULL)
        tkbind(GUI.TopLevel, "5", function() NULL)
        tkbind(GUI.TopLevel, "6", function() NULL)
        tkbind(GUI.TopLevel, "<Control-n>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-N>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-l>", function() NULL)
        tkbind(GUI.TopLevel, "<Control-L>", function() NULL)
        tkbind(GUI.TopLevel, "<F1>", function() NULL)
        tkbind(GUI.TopLevel, "<Configure>", function() NULL)
        tkbind(BiplotRegion.image, "<Motion>", function() NULL)
        tkbind(BiplotRegion.image, "<Button-1>", function() NULL)
        tkbind(BiplotRegion.image, "<ButtonRelease-1>", function() NULL)
        tkbind(BiplotRegion.image, "<Button-3>", function() NULL)
        tkbind(GUI.TopLevel, "<F11>", function() NULL)
        tkbind(GUI.TopLevel, "<F12>", function() NULL)
     #   tkbind(ConvergenceTab.image, "<Button-3>", function() NULL)
     #   tkbind(PointsTab.image, "<Button-3>", function() NULL)
     #   tkbind(GroupsTab.image, "<Button-3>", function() NULL)
        tkbind(AxesTab.image, "<Button-3>", function() NULL)
    #    tkbind(Kraal.image, "<Motion>", function() NULL)
    #    tkbind(Kraal.image, "<Button-1>", function() NULL)
    #    tkbind(Kraal.image, "<ButtonRelease-1>", function() NULL)
    #    tkbind(Kraal.image, "<Button-3>", function() NULL)
    }
    
     GUI.BindingsOn <- function() {
        GUI.update()
        tkbind(GUI.TopLevel, "<Escape>", Other.Stop.cmd)
        tkbind(GUI.TopLevel, "<Control-s>", function() File.Save.as.cmd())
        tkbind(GUI.TopLevel, "<Control-S>", function() File.Save.as.cmd())
        tkbind(GUI.TopLevel, "<Control-c>", function() tkinvoke(MenuBar.File,
            1))
        tkbind(GUI.TopLevel, "<Control-C>", function() tkinvoke(MenuBar.File,
            1))
        tkbind(GUI.TopLevel, "<Control-p>", function() tkinvoke(MenuBar.File,
            3))
        tkbind(GUI.TopLevel, "<Control-P>", function() tkinvoke(MenuBar.File,
            3))
        if (.Platform$OS.type != "unix")
            tkbind(GUI.TopLevel, "<Control-+>", function() tkinvoke(MenuBar.View,
                16))
        tkbind(GUI.TopLevel, "<Control-minus>", function() tkinvoke(MenuBar.View,
            17))
        tkbind(GUI.TopLevel, "<Control-g>", function() tkinvoke(MenuBar.Format,
            1))
        tkbind(GUI.TopLevel, "<Control-G>", function() tkinvoke(MenuBar.Format,
            1))
        tkbind(GUI.TopLevel, "<Control-a>", function() tkinvoke(MenuBar.Format,
            2))
        tkbind(GUI.TopLevel, "<Control-A>", function() tkinvoke(MenuBar.Format,
            2))
        tkbind(GUI.TopLevel, "<Control-r>", function() tkinvoke(MenuBar.Format,
            6))
        tkbind(GUI.TopLevel, "<Control-R>", function() tkinvoke(MenuBar.Format,
            6))
        tkbind(GUI.TopLevel, "a", function() tkinvoke(MenuBar.Points,
            2))
        tkbind(GUI.TopLevel, "A", function() tkinvoke(MenuBar.Points,
            2))
     #   tkbind(GUI.TopLevel, "r", function() tkinvoke(MenuBar.Points.MDS,
     #       0))
     #   tkbind(GUI.TopLevel, "R", function() tkinvoke(MenuBar.Points.MDS,
     #       0))
     #   tkbind(GUI.TopLevel, "b", function() tkinvoke(MenuBar.Points.MDS,
     #       2))
     #   tkbind(GUI.TopLevel, "B", function() tkinvoke(MenuBar.Points.MDS,
     #       2))
     #   tkbind(GUI.TopLevel, "c", function() tkinvoke(MenuBar.Points.MDS,
     #       3))
     #   tkbind(GUI.TopLevel, "C", function() tkinvoke(MenuBar.Points.MDS,
     #       3))
     #   tkbind(GUI.TopLevel, "d", function() tkinvoke(MenuBar.Points.MDS,
     #       4))
     #   tkbind(GUI.TopLevel, "D", function() tkinvoke(MenuBar.Points.MDS,
     #       4))
        tkbind(GUI.TopLevel, "0", function() tkinvoke(MenuBar.Axes,
            0))
        tkbind(GUI.TopLevel, "1", function() tkinvoke(MenuBar.Joint,
            0))
        tkbind(GUI.TopLevel, "2", function() tkinvoke(MenuBar.Joint,
            1))
        tkbind(GUI.TopLevel, "3", function() tkinvoke(MenuBar.Joint,
            3))
        tkbind(GUI.TopLevel, "4", function() tkinvoke(MenuBar.Axes,
            2))
        tkbind(GUI.TopLevel, "5", function() tkinvoke(MenuBar.Axes,
            3))
        tkbind(GUI.TopLevel, "6", function() tkinvoke(MenuBar.Axes,
            5))
    #    tkbind(GUI.TopLevel, "<Control-n>", function() tkinvoke(MenuBar.Additional.Interpolate,
    #        0))
    #    tkbind(GUI.TopLevel, "<Control-N>", function() tkinvoke(MenuBar.Additional.Interpolate,
    #        0))
    #    tkbind(GUI.TopLevel, "<Control-l>", function() tkinvoke(MenuBar.Additional,
    #        8))
     #   tkbind(GUI.TopLevel, "<Control-L>", function() tkinvoke(MenuBar.Additional,
     #       8))
        tkbind(GUI.TopLevel, "<F1>", function() tkinvoke(MenuBar.Help,
            0))
        tkbind(GUI.TopLevel, "<Configure>", GUI.resize)
        tkbind(BiplotRegion.image, "<Motion>", Biplot.motion)
        tkbind(BiplotRegion.image, "<Button-1>", Biplot.LeftClick)
        tkbind(BiplotRegion.image, "<ButtonRelease-1>", Biplot.LeftRelease)
        tkbind(BiplotRegion.image, "<Button-3>", Biplot.RightClick)
        tkbind(GUI.TopLevel, "<F11>", function() tkinvoke(Other.External.menu,
            0))
        tkbind(GUI.TopLevel, "<F12>", function() tkinvoke(Other.External.menu,
            1))
        tkbind(ConvergenceTab.image, "<Button-3>", ConvergenceTab.RightClick)
        tkbind(PointsTab.image, "<Button-3>", PointsTab.RightClick)
        tkbind(GroupsTab.image, "<Button-3>", GroupsTab.RightClick)
        tkbind(AxesTab.image, "<Button-3>", AxesTab.RightClick)
     #   tkbind(Kraal.image, "<Motion>", Kraal.motion)
     #   tkbind(Kraal.image, "<Button-1>", Kraal.LeftClick)
     #   tkbind(Kraal.image, "<ButtonRelease-1>", Kraal.LeftRelease)
     #   tkbind(Kraal.image, "<Button-3>", Kraal.RightClick)
        ExportTab.update()
        tkconfigure(Other.ProgressBar.pb, value = 100)
        Other.ProgressBar.destroy()
        tkconfigure(GUI.TopLevel, cursor = "arrow")
        .Tcl("update")
    }
    
       GUI.update <- function() {
        if (tclvalue(Biplot.Axes.var) %in% c("0", "1", "2", "10",
            "11", "12") | tclvalue(Other.HideAxes.var) == "1")
            tkentryconfigure(MenuBar.View, 3, state = "disabled")
        else tkentryconfigure(MenuBar.View, 3, state = "normal")
        for (temp1 in 2:3) tkentryconfigure(MenuBar.View, temp1,
            variable = View.ClipAround.var)
        if (tclvalue(Other.HidePoints.var) == "1")
            tkentryconfigure(MenuBar.View, 5, state = "disabled")
        else tkentryconfigure(MenuBar.View, 5, state = "normal")
        tkentryconfigure(MenuBar.View, 5, variable = View.ShowPointLabels.var)
        if (Biplot.axes.mode == 0)
            tkentryconfigure(MenuBar.View, 6, state = "disabled")
        else tkentryconfigure(MenuBar.View, 6, state = "normal")
        tkentryconfigure(MenuBar.View, 6, variable = View.ShowPointValues.var)
        if (g > 1) {
            if (tclvalue(Other.HidePoints.var) == "1")
                tkentryconfigure(MenuBar.View, 8, state = "disabled")
            else tkentryconfigure(MenuBar.View, 8, state = "normal")
        }
        tkentryconfigure(MenuBar.View, 8, variable = View.ShowGroupLabelsInLegend.var)
        if (tclvalue(Biplot.Axes.var) == "10" | tclvalue(Other.HideAxes.var) ==
            "1")
            for (temp1 in c(10, 12)) {
                tkentryconfigure(MenuBar.View, temp1, state = "disabled")
                tkentryconfigure(Biplot.RightClickOutside.Menu,
                  temp1 - 5, state = "disabled")
            }
        else for (temp1 in c(10, 12)) {
            tkentryconfigure(MenuBar.View, temp1, state = "normal")
            tkentryconfigure(Biplot.RightClickOutside.Menu, temp1 -
                5, state = "normal")
        }
        if (tclvalue(Biplot.Axes.var) %in% c("10", "13", "14") |
            tclvalue(Other.HideAxes.var) == "1") {
            tkentryconfigure(MenuBar.View, 11, state = "disabled")
            tkentryconfigure(Biplot.RightClickOutside.Menu, 6,
                state = "disabled")
        }
        else {
            tkentryconfigure(MenuBar.View, 11, state = "normal")
            tkentryconfigure(Biplot.RightClickOutside.Menu, 6,
                state = "normal")
        }
        for (temp1 in 10:12) {
            tkentryconfigure(MenuBar.View, temp1, variable = View.AxisLabels.var)
            tkentryconfigure(Biplot.RightClickOutside.Menu, temp1 -
                5, variable = View.AxisLabels.var)
        }
        for (temp1 in c(0:1, 3)) tkentryconfigure(MenuBar.Joint,
            temp1, variable = Biplot.Axes.var)
        if (tclvalue(Points.var) %in% c("10", "11", "12"))
            tkentryconfigure(MenuBar.Points.MDS, 0, state = "normal")
        else tkentryconfigure(MenuBar.Points.MDS, 0, state = "disabled")
        if (tclvalue(Points.var) == "11")
            for (temp1 in 6:7) tkentryconfigure(MenuBar.Points.MDS,
                temp1, state = "normal", variable = Points.MDS.ApproachToTies.var)
        else for (temp1 in 6:7) tkentryconfigure(MenuBar.Points.MDS,
            temp1, state = "disabled", variable = Points.MDS.ApproachToTies.var)
        if (tclvalue(Points.DissimilarityMetric.var) == "3" &&
            tclvalue(Points.var) == "0")
            for (temp1 in 2:3) tkentryconfigure(MenuBar.Axes,
                temp1, state = "disabled")
        else for (temp1 in 2:3) tkentryconfigure(MenuBar.Axes,
            temp1, state = "normal")
        if ((tclvalue(Points.DissimilarityMetric.var) == "3" &&
            tclvalue(Points.var) == "0") || tclvalue(Points.var) %in%
            c("10", "11", "12"))
            for (temp1 in 5) tkentryconfigure(MenuBar.Axes, temp1,
                state = "disabled")
        else for (temp1 in 5) tkentryconfigure(MenuBar.Axes,
            temp1, state = "normal")
        for (temp1 in c(0, 2:3, 5)) tkentryconfigure(MenuBar.Axes,
            temp1, variable = Biplot.Axes.var)
        if (tclvalue(Biplot.Axes.var) == "10")
            for (temp1 in 0:1) tkentryconfigure(MenuBar.Additional.Interpolate,
                temp1, state = "disabled")
        else for (temp1 in 0:1) tkentryconfigure(MenuBar.Additional.Interpolate,
            temp1, state = "normal")
        if (tclvalue(Biplot.Axes.var) == "2")
            tkentryconfigure(MenuBar.Additional, 6, state = "normal")
        else tkentryconfigure(MenuBar.Additional, 6, state = "disabled")
    #    tkentryconfigure(MenuBar.Additional.Interpolate, 0, variable = Additional.Interpolate.ANewSample.var)
    #    tkentryconfigure(MenuBar.Additional.Interpolate, 1, variable = Additional.Interpolate.SampleGroupMeans.var)
    #    tkentryconfigure(MenuBar.Additional, 2, variable = Additional.ConvexHull.var)
    #    tkentryconfigure(MenuBar.Additional, 3, variable = Additional.AlphaBag.var)
    #    tkentryconfigure(MenuBar.Additional, 5, variable = Additional.PointDensities.var)
    #    tkentryconfigure(MenuBar.Additional, 6, variable = Additional.ClassificationRegion.var)
    #    if (tclvalue(Other.HideAxes.var) == "1" || tclvalue(tkget(SettingsBox.action.combo)) !=
    #        "Predict")
            tkentryconfigure(Biplot.RightClickInside.Menu, 5,
                state = "disabled")
        else tkentryconfigure(Biplot.RightClickInside.Menu, 5,
            state = "normal")
        if (tclvalue(Other.HidePoints.var) == "1" || tclvalue(Other.HideAxes.var) ==
            "1" || tclvalue(tkget(SettingsBox.action.combo)) !=
            "Predict")
            tkentryconfigure(Biplot.RightClickInside.Menu, 6,
                state = "disabled")
        else tkentryconfigure(Biplot.RightClickInside.Menu, 6,
            state = "normal")
        for (temp1 in 4:6) tkentryconfigure(Biplot.RightClickInside.Menu,
            temp1, variable = Biplot.points.mode)
        if (Biplot.axes.mode == 0)
            tkentryconfigure(Biplot.RightClickInside.Menu, 8,
                state = "disabled")
        else tkentryconfigure(Biplot.RightClickInside.Menu, 8,
            state = "normal")
        if (tclvalue(Biplot.Axes.var) == "10" | tclvalue(Other.HideAxes.var) ==
            "1")
            tkconfigure(SettingsBox.action.combo, state = "disabled")
        else tkconfigure(SettingsBox.action.combo, state = "normal")
        if (as.numeric(tclvalue(Biplot.Axes.var)) >= 10 && tclvalue(Points.var) %in%
            c("10", "11", "12"))
            tcl(DiagnosticTabs.nb, "tab", 0, state = "normal")
        else tcl(DiagnosticTabs.nb, "tab", 0, state = "disabled")
        switch(tclvalue(Biplot.Axes.var), `0` = {
            tcl(DiagnosticTabs.nb, "tab", 1, state = "normal")
            tcl(DiagnosticTabs.nb, "tab", 2, state = "disabled")
            tcl(DiagnosticTabs.nb, "tab", 3, state = "normal")
        }, `1` = {
            tcl(DiagnosticTabs.nb, "tab", 1, state = "disabled")
            tcl(DiagnosticTabs.nb, "tab", 2, state = "disabled")
            tcl(DiagnosticTabs.nb, "tab", 3, state = "disabled")
        }, `2` = {
            tcl(DiagnosticTabs.nb, "tab", 1, state = "normal")
            tcl(DiagnosticTabs.nb, "tab", 2, state = "normal")
            tcl(DiagnosticTabs.nb, "tab", 3, state = "normal")
        }, {
            tcl(DiagnosticTabs.nb, "tab", 1, state = "normal")
            tcl(DiagnosticTabs.nb, "tab", 2, state = "disabled")
            tcl(DiagnosticTabs.nb, "tab", 3, state = "disabled")
        })
        if (tclvalue(Biplot.Axes.var) == "10" | tclvalue(Other.HideAxes.var) ==
            "1" | !tclvalue(tkget(SettingsBox.action.combo)) ==
            "Predict")
            tcl(DiagnosticTabs.nb, "tab", 4, state = "disabled")
        else tcl(DiagnosticTabs.nb, "tab", 4, state = "normal")
        if (tclvalue(Biplot.Axes.var) == "10")
            tkentryconfigure(Other.Hide.menu, 1, state = "disabled")
        else tkentryconfigure(Other.Hide.menu, 1, state = "normal")
        if (as.numeric(tclvalue(Biplot.Axes.var)) >= 10 && as.numeric(tclvalue(Points.var)) >=
            10)
            tkentryconfigure(Other.External.menu, 1, state = "disabled")
        else tkentryconfigure(Other.External.menu, 1, state = "normal")
    }

      File.Save.as.cmd <- function() {
        GUI.BindingsOff()
        switch(tclvalue(File.SaveAs.var), `0` = File.SaveAs.PDF.cmd(),
            `1` = File.SaveAs.Postscript.cmd(), `2` = File.SaveAs.Metafile.cmd(),
            `3` = File.SaveAs.Bmp.cmd(), `4` = File.SaveAs.Png.cmd(),
            `5` = File.SaveAs.Jpeg.cmd(), `6` = File.SaveAs.Jpeg.cmd(),
            `7` = File.SaveAs.Jpeg.cmd(), `8` = File.SaveAs.PicTeX.cmd())
        GUI.BindingsOn()
    }
     File.SaveAs.var <- tclVar("0")
    File.SaveAs.PDF.cmd <- function() {
        FileName <- tclvalue(tkgetSaveFile(filetypes = "{{PDF files} {.pdf}} {{All files} *}"))
        if (nchar(FileName)) {
            nn <- nchar(FileName)
            if (nn < 5 || substr(FileName, nn - 3, nn) != ".pdf")
                FileName <- paste(FileName, ".pdf", sep = "")
            pdf(FileName, width = 7, height = 7)
            Biplot.plot(screen = FALSE)
            dev.off()
        }
        tkfocus(GUI.TopLevel)
    }
    File.SaveAs.Postscript.cmd <- function() {
        FileName <- tclvalue(tkgetSaveFile(filetypes = "{{Postscript files} {.ps}} {{All files} *}"))
        if (nchar(FileName)) {
            nn <- nchar(FileName)
            if (nn < 4 || substr(FileName, nn - 2, nn) != ".ps")
                FileName <- paste(FileName, ".ps", sep = "")
            postscript(file = FileName, width = 8, height = 8,
                horizontal = FALSE, onefile = FALSE, paper = "default",
                family = "URWHelvetica")
            Biplot.plot(screen = FALSE)
            dev.off()
        }
        tkfocus(GUI.TopLevel)
    }
    File.SaveAs.Metafile.cmd <- function() {
        FileName <- tclvalue(tkgetSaveFile(filetypes = "{{Metafiles} {.wmf}} {{All files} *}"))
        if (nchar(FileName)) {
            nn <- nchar(FileName)
            if (nn < 5 || substr(FileName, nn - 3, nn) != ".wmf")
                FileName <- paste(FileName, ".wmf", sep = "")
            win.metafile(FileName, width = 8, height = 8, restoreConsole = FALSE)
            Biplot.plot(screen = FALSE)
            dev.off()
        }
        tkfocus(GUI.TopLevel)
    }
    File.SaveAs.Bmp.cmd <- function() {
        FileName <- tclvalue(tkgetSaveFile(filetypes = "{{Bitmap files} {.bmp}} {{All files} *}"))
        if (nchar(FileName)) {
            nn <- nchar(FileName)
            if (nn < 5 || substr(FileName, nn - 3, nn) != ".bmp")
                FileName <- paste(FileName, ".bmp", sep = "")
            bmp(FileName, width = 8, height = 8, units = "in",
                restoreConsole = FALSE, res = 96)
            Biplot.plot(screen = FALSE)
            dev.off()
        }
        tkfocus(GUI.TopLevel)
    }
    File.SaveAs.Png.cmd <- function() {
        FileName <- tclvalue(tkgetSaveFile(filetypes = "{{Png files} {.png}} {{All files} *}"))
        if (nchar(FileName)) {
            nn <- nchar(FileName)
            if (nn < 5 || substr(FileName, nn - 3, nn) != ".png")
                FileName <- paste(FileName, ".png", sep = "")
            png(FileName, width = 8, height = 8, units = "in",
                restoreConsole = FALSE, res = 96)
            Biplot.plot(screen = FALSE)
            dev.off()
        }
        tkfocus(GUI.TopLevel)
    }
    File.SaveAs.Jpeg.cmd <- function() {
        FileName <- tclvalue(tkgetSaveFile(filetypes = "{{Jpeg files} {.jpg .jpeg}} {{All files} *}"))
        if (nchar(FileName)) {
            nn <- nchar(FileName)
            if (nn < 5 || substr(FileName, nn - 3, nn) != ".jpg")
                FileName <- paste(FileName, ".jpg", sep = "")
            jpeg(FileName, width = 8, height = 8, units = "in",
                restoreConsole = FALSE, res = 96, quality = File.Jpeg.quality)
            Biplot.plot(screen = FALSE)
            dev.off()
        }
        tkfocus(GUI.TopLevel)
    }
    File.Jpeg.quality <- NULL
    File.SaveAs.PicTeX.cmd <- function() {
        FileName <- tclvalue(tkgetSaveFile(filetypes = "{{TeX files} {.tex}} {{All files} *}"))
        if (nchar(FileName)) {
            nn <- nchar(FileName)
            if (nn < 5 || substr(FileName, nn - 3, nn) != ".tex")
                FileName <- paste(FileName, ".tex", sep = "")
            pictex(FileName, width = 8, height = 8, debug = FALSE,
                bg = "white", fg = "black")
            Biplot.plot(screen = FALSE)
            dev.off()
        }
        tkfocus(GUI.TopLevel)
    }
    File.Copy.cmd <- function() {
        win.metafile(width = 8, height = 8, restoreConsole = FALSE)
        Biplot.plot(screen = FALSE)
        dev.off()
    }
    File.Print.cmd <- function() {
        try(win.print(), silent = TRUE)
        if (geterrmessage() != "Error in win.print() : unable to start device devWindows\n") {
            Biplot.plot()
            dev.off()
        }
    }
File.Options.cmd <- function() {
        local.GUI.func <- function() {
            top <- tktoplevel()
            tkwm.withdraw(top)
            onDefaults <- function() {
                local.MDSConvergence.var <<- tclVar(1e-06)
                tkconfigure(entry1, textvariable = local.MDSConvergence.var)
                local.MDSMaximumIterations.var <<- tclVar(5000)
                tkconfigure(entry2, textvariable = local.MDSMaximumIterations.var)
                local.ProcrustesConvergence.var <<- tclVar(1e-06)
                tkconfigure(entry3, textvariable = local.ProcrustesConvergence.var)
                local.ProcrustesMaximumIterations.var <<- tclVar(5000)
                tkconfigure(entry4, textvariable = local.ProcrustesMaximumIterations.var)
                local.IterationsToLiveUpdate.var <<- tclVar(5)
                tkconfigure(entry5, textvariable = local.IterationsToLiveUpdate.var)
                local.ReuseExternalWindows.var <<- tclVar(FALSE)
                tkconfigure(checkbutton1, variable = local.ReuseExternalWindows.var)
                local.ThreeDFlyBy.var <<- tclVar(FALSE)
                tkconfigure(checkbutton2, variable = local.ThreeDFlyBy.var)
                local.ThreeDMouseButtonActionLeft.var <<- tclVar("trackball")
                tkconfigure(combo1, text = "trackball")
                local.ThreeDMouseButtonActionMiddle.var <<- tclVar("zoom")
                tkconfigure(combo2, text = "zoom")
                local.ThreeDMouseButtonActionRight.var <<- tclVar("fov")
                tkconfigure(combo3, text = "fov")
            }
            onOK <- function() {
                boptions$MDS.convergence <<- as.numeric(tclvalue(local.MDSConvergence.var))
                boptions$MDS.MaximumIterations <<- as.numeric(tclvalue(local.MDSMaximumIterations.var))
                boptions$Procrustes.convergence <<- as.numeric(tclvalue(local.ProcrustesConvergence.var))
                boptions$Procrustes.MaximumIterations <<- as.numeric(tclvalue(local.ProcrustesMaximumIterations.var))
                boptions$IterationsToLiveUpdate <<- as.numeric(tclvalue(local.IterationsToLiveUpdate.var))
                boptions$ReuseExternalWindows <<- as.logical(as.numeric(tclvalue(local.ReuseExternalWindows.var)))
                boptions$ThreeD.FlyBy <<- as.logical(as.numeric(tclvalue(local.ThreeDFlyBy.var)))
                boptions$ThreeD.MouseButtonAction <<- c(tclvalue(tkget(combo1)),
                  tclvalue(tkget(combo2)), tclvalue(tkget(combo3)))
                tkdestroy(top)
            }
            onCancel <- function() tkdestroy(top)
            local.MDSConvergence.var <- tclVar(boptions$MDS.convergence)
            local.MDSMaximumIterations.var <- tclVar(boptions$MDS.MaximumIterations)
            local.ProcrustesConvergence.var <- tclVar(boptions$Procrustes.convergence)
            local.ProcrustesMaximumIterations.var <- tclVar(boptions$Procrustes.MaximumIterations)
            local.IterationsToLiveUpdate.var <- tclVar(boptions$IterationsToLiveUpdate)
            local.ReuseExternalWindows.var <- tclVar(boptions$ReuseExternalWindows)
            local.ThreeDFlyBy.var <- tclVar(boptions$ThreeD.FlyBy)
            local.ThreeDMouseButtonActionLeft.var <- tclVar(boptions$ThreeD.MouseButtonAction[1])
            local.ThreeDMouseButtonActionMiddle.var <- tclVar(boptions$ThreeD.MouseButtonAction[2])
            local.ThreeDMouseButtonActionRight.var <- tclVar(boptions$ThreeD.MouseButtonAction[3])
            frame1 <- tkwidget(top, "TitleFrame", text = "Convergence")
            tkplace(frame1, relx = 0.05, relwidth = 0.9, y = 10,
                height = 105, `in` = top)
            tkplace(tk2label(frame1, text = "MDS relative convergence"),
                x = 11, y = 20, `in` = frame1)
            entry1 <- tk2entry(frame1, textvariable = local.MDSConvergence.var,
                justify = "right", takefocus = FALSE)
            tkplace(entry1, relx = 0.95, y = 20, height = 18,
                relwidth = 0.125, `in` = frame1, anchor = "ne")
            tkplace(tk2label(frame1, text = "MDS maximum iterations"),
                x = 11, y = 40, `in` = frame1)
            entry2 <- tk2entry(frame1, textvariable = local.MDSMaximumIterations.var,
                justify = "right", takefocus = FALSE)
            tkplace(entry2, relx = 0.95, y = 40, height = 18,
                relwidth = 0.125, `in` = frame1, anchor = "ne")
            tkplace(tk2label(frame1, text = "Procrustes absolute convergence"),
                x = 11, y = 60, `in` = frame1)
            entry3 <- tk2entry(frame1, textvariable = local.ProcrustesConvergence.var,
                justify = "right", takefocus = FALSE)
            tkplace(entry3, relx = 0.95, y = 60, height = 18,
                relwidth = 0.125, `in` = frame1, anchor = "ne")
            tkplace(tk2label(frame1, text = "Procrustes maximum iterations"),
                x = 11, y = 80, `in` = frame1)
            entry4 <- tk2entry(frame1, textvariable = local.ProcrustesMaximumIterations.var,
                justify = "right", takefocus = FALSE)
            tkplace(entry4, relx = 0.95, y = 80, height = 18,
                relwidth = 0.125, `in` = frame1, anchor = "ne")
            frame2 <- tkwidget(top, "TitleFrame", text = "Graphical")
            tkplace(frame2, relx = 0.05, relwidth = 0.9, y = 130,
                height = 125, `in` = top)
            tkplace(tk2label(frame2, text = "Iterations to live update"),
                x = 11, y = 20, `in` = frame2)
            entry5 <- tk2entry(frame2, textvariable = local.IterationsToLiveUpdate.var,
                justify = "right", takefocus = FALSE)
            tkplace(entry5, relx = 0.95, y = 20, height = 18,
                relwidth = 0.125, `in` = frame2, anchor = "ne")
            tkplace(tk2label(frame2, text = "Re-use external windows"),
                x = 11, y = 40, `in` = frame2)
            checkbutton1 <- tk2checkbutton(frame2, variable = local.ReuseExternalWindows.var)
            tkplace(checkbutton1, relx = 0.9, y = 40, height = 17,
                `in` = frame2)
            tkplace(tk2label(frame2, text = "Three-dimensional `fly-by'"),
                x = 11, y = 60, `in` = frame2)
            checkbutton2 <- tk2checkbutton(frame2, variable = local.ThreeDFlyBy.var)
            tkplace(checkbutton2, relx = 0.9, y = 60, height = 17,
                `in` = frame2)
            tkplace(tk2label(frame2, text = "Three-dimensional mouse button action:"),
                x = 11, y = 80, `in` = frame2)
            MousePossibilities <- c("none", "trackball", "xAxis",
                "yAxis", "zAxis", "polar", "zoom", "fov")
            tkplace(tk2label(frame2, text = "Left"), x = 11,
                y = 100, `in` = frame2)
            combo1 <- tkwidget(frame2, "ComboBox", editable = FALSE,
                values = MousePossibilities, text = boptions$ThreeD.MouseButtonAction[1])
            tkplace(combo1, relx = 0.11, y = 100, relwidth = 0.2,
                height = 17, `in` = frame2)
            tkplace(tk2label(frame2, text = "Middle"), relx = 0.33,
                y = 100, `in` = frame2)
            combo2 <- tkwidget(frame2, "ComboBox", editable = FALSE,
                values = MousePossibilities, text = boptions$ThreeD.MouseButtonAction[2])
            tkplace(combo2, relx = 0.44, y = 100, relwidth = 0.2,
                height = 17, `in` = frame2)
            tkplace(tk2label(frame2, text = "Right"), relx = 0.66,
                y = 100, `in` = frame2)
            combo3 <- tkwidget(frame2, "ComboBox", editable = FALSE,
                values = MousePossibilities, text = boptions$ThreeD.MouseButtonAction[3])
            tkplace(combo3, relx = 0.755, y = 100, relwidth = 0.2,
                height = 17, `in` = frame2)
            button1 <- tk2button(top, text = "Defaults", width = 10,
                command = onDefaults)
            button2 <- tk2button(top, text = "OK", width = 10,
                command = onOK)
            button3 <- tk2button(top, text = "Cancel", width = 10,
                command = onCancel)
            tkplace(button1, relx = 0.05, rely = 0.99, anchor = "sw")
            tkplace(button2, relx = 0.775, rely = 0.99, anchor = "se")
            tkplace(button3, relx = 0.96, rely = 0.99, anchor = "se")
            tkbind(top, "<Return>", onOK)
            tkbind(top, "<Escape>", onCancel)
            tkbind(top, "<Destroy>", function() {
                tkgrab.release(top)
                tkfocus(GUI.TopLevel)
            })
            tkwm.geometry(top, paste("390x292", "+", round(GUI.AvailableScreenWidth/2 -
                390/2, 0), "+", round(GUI.AvailableScreenHeight/2 -
                292/2, 0), sep = ""))
            tkwm.focusmodel(top, "active")
            tkwm.resizable(top, "0", "0")
            tkwm.deiconify(top)
            tkwm.title(top, "Options")
            tkgrab.set(top)
            Rico <- tk2ico.load(res = "question")
            tk2ico.set(top, Rico)
            tk2ico.destroy(Rico)
            rm(Rico)
            tkwait.window(top)
        }
        local.GUI.func()
    }
    File.Exit.cmd <- function() {
        temp1 <- tkmessageBox(icon = "question", message = "Are you sure?",
            parent = GUI.TopLevel, title = "Exit", type = "yesno")
        if (tclvalue(temp1) == "yes")
            tkdestroy(GUI.TopLevel)
        else GUI.BindingsOn()
    }
    View.ShowTitle.cmd <- function() {
        Biplot.replot()
    }
    View.ShowTitle.var <- tclVar("0")
    View.ClipAroundPoints.cmd <- function() {
        Biplot.replot()
    }
    View.ClipAroundPointsAndAxes.cmd <- function() {
        Biplot.replot()
    }
    View.ClipAround.var <- tclVar("0")
    View.ShowPointLabels.cmd <- function() {
        Biplot.replot()
    }
    View.ShowPointLabels.var <- tclVar("1")
    View.ShowPointValues.cmd <- function() {
        Biplot.replot()
    }
    View.ShowPointValues.var <- tclVar("1")
    View.ShowGroupLabelsInLegend.cmd <- function() {
        Biplot.replot()
    }
    View.ShowGroupLabelsInLegend.var <- if (g == 1)
        tclVar("0")
    else tclVar("1")
    View.DontShowAxisLabels.cmd <- function() {
        if (p.in < p)
            Kraal.replot()
        Biplot.replot()
    }
    View.ShowClingingAxisLabels.cmd <- function() {
        if (p.in < p)
            Kraal.replot()
        Biplot.replot()
    }
    View.ShowAxisLabelsInLegend.cmd <- function() {
        if (p.in < p)
            Kraal.replot()
        Biplot.replot()
    }
    View.AxisLabels.var <- tclVar("1")
    View.ShowAdditionalLabelsInLegend.cmd <- function() {
        Biplot.replot()
    }
    View.ShowAdditionalLabelsInLegend.var <- tclVar("1")
    View.ShowNextLegendEntries.cmd <- function() {
        if (Legend.CurrentPage < Legend.LastPage) {
            Legend.CurrentPage <<- Legend.CurrentPage + 1
            Biplot.replot()
        }
    }
    View.ShowPreviousLegendEntries.cmd <- function() {
        if (Legend.CurrentPage > 1) {
            Legend.CurrentPage <<- Legend.CurrentPage - 1
            Biplot.replot()
        }
    }
    View.CalibrateDisplaySpaceAxes.cmd <- function() {
        Biplot.replot()
    }
    View.CalibrateDisplaySpaceAxes.var <- tclVar("0")
    Format.Title.cmd <- function() {
        local.GUI.func <- function() {
            top <- tktoplevel()
            tkwm.withdraw(top)
            onDefault <- function() {
                NewTitle <<- tclVar(Biplot.title.default)
                tkconfigure(entry1, textvariable = NewTitle)
            }
            onOK <- function() {
                tkdestroy(top)
                if (Biplot.title != tclvalue(NewTitle)) {
                  Biplot.title <<- tclvalue(NewTitle)
                  Biplot.replot()
                }
            }
            onCancel <- function() tkdestroy(top)
            NewTitle <- tclVar(Biplot.title)
            frame1 <- tk2frame(top, relief = "groove", borderwidth = "1.5p")
            label1 <- tk2label(frame1, text = "New title")
            entry1 <- tk2entry(frame1, textvariable = NewTitle)
            button1 <- tk2button(top, text = "OK", width = 10,
                command = onOK)
            button2 <- tk2button(top, text = "Cancel", width = 10,
                command = onCancel)
            button3 <- tk2button(top, text = "Default", width = 10,
                command = onDefault)
            tkplace(frame1, relx = 0.5, rely = 0.4, relwidth = 0.9,
                relheight = 0.4, anchor = "center")
            tkplace(label1, relx = 0.05, rely = 0.5, `in` = frame1,
                anchor = "w")
            tkplace(entry1, relx = 0.5, rely = 0.5, relwidth = 0.45,
                `in` = frame1, anchor = "w")
            tkplace(button1, relx = 0.7, rely = 0.85, anchor = "e")
            tkplace(button2, relx = 0.95, rely = 0.85, anchor = "e")
            tkplace(button3, relx = 0.05, rely = 0.85, anchor = "w")
            tkbind(entry1, "<Return>", onOK)
            tkbind(top, "<Escape>", onCancel)
            tkbind(top, "<Destroy>", function() {
                tkgrab.release(top)
                tkfocus(GUI.TopLevel)
            })
            tkwm.geometry(top, paste("300x120", "+", round(GUI.AvailableScreenWidth/2 -
                300/2, 0), "+", round(GUI.AvailableScreenHeight/2 -
                120/2, 0), sep = ""))
            tkwm.focusmodel(top, "active")
            tkwm.resizable(top, "0", "0")
            tkwm.deiconify(top)
            tkwm.title(top, "Title")
            tkgrab.set(top)
            Rico <- tk2ico.load(res = "question")
            tk2ico.set(top, Rico)
            tk2ico.destroy(Rico)
            rm(Rico)
            tkwait.window(top)
        }
        local.GUI.func()
    }
    
    Format.ByGroup.cmd <- function(WhichGroupInitially = 1, WhichTabInitially = 1) {
            local.GUI.func <- function() {
            ReturnToWindow <- tkfocus()
            top <- tktoplevel()
            tkwm.withdraw(top)
            WhichGroup <- WhichGroupInitially
            UpdateEntryBoxes <- function() {
                if (WhichGroup == 1 && tclvalue(local.points.cex.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.points.cex.var[[temp1]] <<- tclVar(tclvalue(local.points.cex.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.points.label.cex.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.points.label.cex.var[[temp1]] <<- tclVar(tclvalue(local.points.label.cex.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.points.label.HorizOffset.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.points.label.HorizOffset.var[[temp1]] <<- tclVar(tclvalue(local.points.label.HorizOffset.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.points.label.VertOffset.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.points.label.VertOffset.var[[temp1]] <<- tclVar(tclvalue(local.points.label.VertOffset.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.SampleGroupMeans.cex.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.SampleGroupMeans.cex.var[[temp1]] <<- tclVar(tclvalue(local.SampleGroupMeans.cex.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.SampleGroupMeans.label.cex.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.SampleGroupMeans.label.cex.var[[temp1]] <<- tclVar(tclvalue(local.SampleGroupMeans.label.cex.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.SampleGroupMeans.label.HorizOffset.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.SampleGroupMeans.label.HorizOffset.var[[temp1]] <<- tclVar(tclvalue(local.SampleGroupMeans.label.HorizOffset.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.SampleGroupMeans.label.VertOffset.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.SampleGroupMeans.label.VertOffset.var[[temp1]] <<- tclVar(tclvalue(local.SampleGroupMeans.label.VertOffset.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.ConvexHullAlphaBag.lwd.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.ConvexHullAlphaBag.lwd.var[[temp1]] <<- tclVar(tclvalue(local.ConvexHullAlphaBag.lwd.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.ConvexHullAlphaBag.TukeyMedian.cex.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.ConvexHullAlphaBag.TukeyMedian.cex.var[[temp1]] <<- tclVar(tclvalue(local.ConvexHullAlphaBag.TukeyMedian.cex.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.ConvexHullAlphaBag.TukeyMedian.cex.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.ConvexHullAlphaBag.TukeyMedian.cex.var[[temp1]] <<- tclVar(tclvalue(local.ConvexHullAlphaBag.TukeyMedian.cex.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.cex.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.ConvexHullAlphaBag.TukeyMedian.label.cex.var[[temp1]] <<- tclVar(tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.cex.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var[[temp1]] <<- tclVar(tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var[[1]]))
                if (WhichGroup == 1 && tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var[[1]]) !=
                  " ")
                  for (temp1 in 2:(g + 1)) local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var[[temp1]] <<- tclVar(tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var[[1]]))
            }

    ChangeGroup <- function() {
                UpdateEntryBoxes()
                temp <- as.numeric(tclvalue(tkcurselection(listbox1))) +
                  1
                if (!is.na(temp))
                  WhichGroup <<- temp
                local.points.pch.var[[1]] <<- if (all(unlist(lapply(local.points.pch.var[-1],
                  tclvalue)) == tclvalue(local.points.pch.var[[2]])))
                  local.points.pch.var[[2]]
                else tclVar(" ")
                tkconfigure(spinboxA1, textvariable = local.points.pch.var[[WhichGroup]])
                local.points.cex.var[[1]] <<- if (all(unlist(lapply(local.points.cex.var[-1],
                  tclvalue)) == tclvalue(local.points.cex.var[[2]])))
                  local.points.cex.var[[2]]
                else tclVar(" ")
                tkconfigure(entryA1, textvariable = local.points.cex.var[[WhichGroup]])
                local.points.col.fg.var[[1]] <<- if (all(unlist(local.points.col.fg.var[-1]) ==
                  local.points.col.fg.var[[2]]))
                  local.points.col.fg.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelA1, background = local.points.col.fg.var[[WhichGroup]])
                local.points.col.bg.var[[1]] <<- if (all(unlist(local.points.col.bg.var[-1]) ==
                  local.points.col.bg.var[[2]]))
                  local.points.col.bg.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelA2, background = local.points.col.bg.var[[WhichGroup]])
                local.points.label.font.var[[1]] <<- if (all(unlist(lapply(local.points.label.font.var[-1],
                  tclvalue)) == tclvalue(local.points.label.font.var[[2]])))
                  local.points.label.font.var[[2]]
                else tclVar(" ")
                tkconfigure(spinboxA2, textvariable = local.points.label.font.var[[WhichGroup]])
                local.points.label.cex.var[[1]] <<- if (all(unlist(lapply(local.points.label.cex.var[-1],
                  tclvalue)) == tclvalue(local.points.label.cex.var[[2]])))
                  local.points.label.cex.var[[2]]
                else tclVar(" ")
                tkconfigure(entryA2, textvariable = local.points.label.cex.var[[WhichGroup]])
                local.points.label.col.var[[1]] <<- if (all(unlist(local.points.label.col.var[-1]) ==
                  local.points.label.col.var[[2]]))
                  local.points.label.col.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelA3, background = local.points.label.col.var[[WhichGroup]])
                local.points.label.HorizOffset.var[[1]] <<- if (all(unlist(lapply(local.points.label.HorizOffset.var[-1],
                  tclvalue)) == tclvalue(local.points.label.HorizOffset.var[[2]])))
                  local.points.label.HorizOffset.var[[2]]
                else tclVar(" ")
                tkconfigure(entryA3, textvariable = local.points.label.HorizOffset.var[[WhichGroup]])
                local.points.label.VertOffset.var[[1]] <<- if (all(unlist(lapply(local.points.label.VertOffset.var[-1],
                  tclvalue)) == tclvalue(local.points.label.VertOffset.var[[2]])))
                  local.points.label.VertOffset.var[[2]]
                else tclVar(" ")
                tkconfigure(entryA4, textvariable = local.points.label.VertOffset.var[[WhichGroup]])
                local.SampleGroupMeans.pch.var[[1]] <<- if (all(unlist(lapply(local.SampleGroupMeans.pch.var[-1],
                  tclvalue)) == tclvalue(local.SampleGroupMeans.pch.var[[2]])))
                  local.SampleGroupMeans.pch.var[[2]]
                else tclVar(" ")
                tkconfigure(spinboxB1, textvariable = local.SampleGroupMeans.pch.var[[WhichGroup]])
                local.SampleGroupMeans.cex.var[[1]] <<- if (all(unlist(lapply(local.SampleGroupMeans.cex.var[-1],
                  tclvalue)) == tclvalue(local.SampleGroupMeans.cex.var[[2]])))
                  local.SampleGroupMeans.cex.var[[2]]
                else tclVar(" ")
                tkconfigure(entryB1, textvariable = local.SampleGroupMeans.cex.var[[WhichGroup]])
                local.SampleGroupMeans.col.fg.var[[1]] <<- if (all(unlist(local.SampleGroupMeans.col.fg.var[-1]) ==
                  local.SampleGroupMeans.col.fg.var[[2]]))
                  local.SampleGroupMeans.col.fg.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelB1, background = local.SampleGroupMeans.col.fg.var[[WhichGroup]])
                local.SampleGroupMeans.col.bg.var[[1]] <<- if (all(unlist(local.SampleGroupMeans.col.bg.var[-1]) ==
                  local.SampleGroupMeans.col.bg.var[[2]]))
                  local.SampleGroupMeans.col.bg.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelB2, background = local.SampleGroupMeans.col.bg.var[[WhichGroup]])
                local.SampleGroupMeans.label.font.var[[1]] <<- if (all(unlist(lapply(local.SampleGroupMeans.label.font.var[-1],
                  tclvalue)) == tclvalue(local.SampleGroupMeans.label.font.var[[2]])))
                  local.SampleGroupMeans.label.font.var[[2]]
                else tclVar(" ")
                tkconfigure(spinboxB2, textvariable = local.SampleGroupMeans.label.font.var[[WhichGroup]])
                local.SampleGroupMeans.label.cex.var[[1]] <<- if (all(unlist(lapply(local.SampleGroupMeans.label.cex.var[-1],
                  tclvalue)) == tclvalue(local.SampleGroupMeans.label.cex.var[[2]])))
                  local.SampleGroupMeans.label.cex.var[[2]]
                else tclVar(" ")
                tkconfigure(entryB2, textvariable = local.SampleGroupMeans.label.cex.var[[WhichGroup]])
                local.SampleGroupMeans.label.col.var[[1]] <<- if (all(unlist(local.SampleGroupMeans.label.col.var[-1]) ==
                  local.SampleGroupMeans.label.col.var[[2]]))
                  local.SampleGroupMeans.label.col.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelB3, background = local.SampleGroupMeans.label.col.var[[WhichGroup]])
                local.SampleGroupMeans.label.HorizOffset.var[[1]] <<- if (all(unlist(lapply(local.SampleGroupMeans.label.HorizOffset.var[-1],
                  tclvalue)) == tclvalue(local.SampleGroupMeans.label.HorizOffset.var[[2]])))
                  local.SampleGroupMeans.label.HorizOffset.var[[2]]
                else tclVar(" ")
                tkconfigure(entryB3, textvariable = local.SampleGroupMeans.label.HorizOffset.var[[WhichGroup]])
                local.SampleGroupMeans.label.VertOffset.var[[1]] <<- if (all(unlist(lapply(local.SampleGroupMeans.label.VertOffset.var[-1],
                  tclvalue)) == tclvalue(local.SampleGroupMeans.label.VertOffset.var[[2]])))
                  local.SampleGroupMeans.label.VertOffset.var[[2]]
                else tclVar(" ")
                tkconfigure(entryB4, textvariable = local.SampleGroupMeans.label.VertOffset.var[[WhichGroup]])
                local.ConvexHullAlphaBag.lty.var[[1]] <<- if (all(unlist(lapply(local.ConvexHullAlphaBag.lty.var[-1],
                  tclvalue)) == tclvalue(local.ConvexHullAlphaBag.lty.var[[2]])))
                  local.ConvexHullAlphaBag.lty.var[[2]]
                else tclVar(" ")
                tkconfigure(spinboxC1, textvariable = local.ConvexHullAlphaBag.lty.var[[WhichGroup]])
                local.ConvexHullAlphaBag.lwd.var[[1]] <<- if (all(unlist(lapply(local.ConvexHullAlphaBag.lwd.var[-1],
                  tclvalue)) == tclvalue(local.ConvexHullAlphaBag.lwd.var[[2]])))
                  local.ConvexHullAlphaBag.lwd.var[[2]]
                else tclVar(" ")
                tkconfigure(entryC1, textvariable = local.ConvexHullAlphaBag.lwd.var[[WhichGroup]])
                local.ConvexHullAlphaBag.col.fg.var[[1]] <<- if (all(unlist(local.ConvexHullAlphaBag.col.fg.var[-1]) ==
                  local.ConvexHullAlphaBag.col.fg.var[[2]]))
                  local.ConvexHullAlphaBag.col.fg.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelC1, background = local.ConvexHullAlphaBag.col.fg.var[[WhichGroup]])
                local.ConvexHullAlphaBag.col.bg.var[[1]] <<- if (all(unlist(local.ConvexHullAlphaBag.col.bg.var[-1]) ==
                  local.ConvexHullAlphaBag.col.bg.var[[2]]))
                  local.ConvexHullAlphaBag.col.bg.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelC2, background = local.ConvexHullAlphaBag.col.bg.var[[WhichGroup]])
                local.ConvexHullAlphaBag.TukeyMedian.pch.var[[1]] <<- if (all(unlist(lapply(local.ConvexHullAlphaBag.TukeyMedian.pch.var[-1],
                  tclvalue)) == tclvalue(local.ConvexHullAlphaBag.TukeyMedian.pch.var[[2]])))
                  local.ConvexHullAlphaBag.TukeyMedian.pch.var[[2]]
                else tclVar(" ")
                tkconfigure(spinboxC2, textvariable = local.ConvexHullAlphaBag.TukeyMedian.pch.var[[WhichGroup]])
                local.ConvexHullAlphaBag.TukeyMedian.cex.var[[1]] <<- if (all(unlist(lapply(local.ConvexHullAlphaBag.TukeyMedian.cex.var[-1],
                  tclvalue)) == tclvalue(local.ConvexHullAlphaBag.TukeyMedian.cex.var[[2]])))
                  local.ConvexHullAlphaBag.TukeyMedian.cex.var[[2]]
                else tclVar(" ")
                tkconfigure(entryC2, textvariable = local.ConvexHullAlphaBag.TukeyMedian.cex.var[[WhichGroup]])
                local.ConvexHullAlphaBag.TukeyMedian.col.fg.var[[1]] <<- if (all(unlist(local.ConvexHullAlphaBag.TukeyMedian.col.fg.var[-1]) ==
                  local.ConvexHullAlphaBag.TukeyMedian.col.fg.var[[2]]))
                  local.ConvexHullAlphaBag.TukeyMedian.col.fg.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelC3, background = local.ConvexHullAlphaBag.TukeyMedian.col.fg.var[[WhichGroup]])
                local.ConvexHullAlphaBag.TukeyMedian.col.bg.var[[1]] <<- if (all(unlist(local.ConvexHullAlphaBag.TukeyMedian.col.bg.var[-1]) ==
                  local.ConvexHullAlphaBag.TukeyMedian.col.bg.var[[2]]))
                  local.ConvexHullAlphaBag.TukeyMedian.col.bg.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelC4, background = local.ConvexHullAlphaBag.TukeyMedian.col.bg.var[[WhichGroup]])
                local.ConvexHullAlphaBag.TukeyMedian.label.font.var[[1]] <<- if (all(unlist(lapply(local.ConvexHullAlphaBag.TukeyMedian.label.font.var[-1],
                  tclvalue)) == tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.font.var[[2]])))
                  local.ConvexHullAlphaBag.TukeyMedian.label.font.var[[2]]
                else tclVar(" ")
                tkconfigure(spinboxC3, textvariable = local.ConvexHullAlphaBag.TukeyMedian.label.font.var[[WhichGroup]])
                local.ConvexHullAlphaBag.TukeyMedian.label.cex.var[[1]] <<- if (all(unlist(lapply(local.ConvexHullAlphaBag.TukeyMedian.label.cex.var[-1],
                  tclvalue)) == tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.cex.var[[2]])))
                  local.ConvexHullAlphaBag.TukeyMedian.label.cex.var[[2]]
                else tclVar(" ")
                tkconfigure(entryC3, textvariable = local.ConvexHullAlphaBag.TukeyMedian.label.cex.var[[WhichGroup]])
                local.ConvexHullAlphaBag.TukeyMedian.label.col.var[[1]] <<- if (all(unlist(local.ConvexHullAlphaBag.TukeyMedian.label.col.var[-1]) ==
                  local.ConvexHullAlphaBag.TukeyMedian.label.col.var[[2]]))
                  local.ConvexHullAlphaBag.TukeyMedian.label.col.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelC5, background = local.ConvexHullAlphaBag.TukeyMedian.label.col.var[[WhichGroup]])
                local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var[[1]] <<- if (all(unlist(lapply(local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var[-1],
                  tclvalue)) == tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var[[2]])))
                  local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var[[2]]
                else tclVar(" ")
                tkconfigure(entryC4, textvariable = local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var[[WhichGroup]])
                local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var[[1]] <<- if (all(unlist(lapply(local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var[-1],
                  tclvalue)) == tclvalue(local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var[[2]])))
                  local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var[[2]]
                else tclVar(" ")
                tkconfigure(entryC5, textvariable = local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var[[WhichGroup]])
                local.ClassificationRegion.col.bg.var[[1]] <<- if (all(unlist(local.ClassificationRegion.col.bg.var[-1]) ==
                  local.ClassificationRegion.col.bg.var[[2]]))
                  local.ClassificationRegion.col.bg.var[[2]]
                else text2hex("SystemButtonFace")
                tkconfigure(labelD1, background = local.ClassificationRegion.col.bg.var[[WhichGroup]])
            }

             onDefaults <- function() {
                bpar.initialise1.func()
                initialise()
                ChangeGroup()
            }
            onOK <- function() {
                UpdateEntryBoxes()
                bpar$gpoints.pch <<- as.numeric(lapply(local.points.pch.var[-1],
                  tclvalue))
                bpar$gpoints.cex <<- as.numeric(lapply(local.points.cex.var[-1],
                  tclvalue))
                bpar$gpoints.col.fg <<- unlist(local.points.col.fg.var[-1])
                bpar$gpoints.col.bg <<- unlist(local.points.col.bg.var[-1])
                bpar$gpoints.label.font <<- as.numeric(lapply(local.points.label.font.var[-1],
                  tclvalue))
                bpar$gpoints.label.cex <<- as.numeric(lapply(local.points.label.cex.var[-1],
                  tclvalue))
                bpar$gpoints.label.col <<- unlist(local.points.label.col.var[-1])
                bpar$gpoints.label.HorizOffset <<- as.numeric(lapply(local.points.label.HorizOffset.var[-1],
                  tclvalue))
                bpar$gpoints.label.VertOffset <<- as.numeric(lapply(local.points.label.VertOffset.var[-1],
                  tclvalue))
                bpar$gSampleGroupMeans.pch <<- as.numeric(lapply(local.SampleGroupMeans.pch.var[-1],
                  tclvalue))
                bpar$gSampleGroupMeans.cex <<- as.numeric(lapply(local.SampleGroupMeans.cex.var[-1],
                  tclvalue))
                bpar$gSampleGroupMeans.col.fg <<- unlist(local.SampleGroupMeans.col.fg.var[-1])
                bpar$gSampleGroupMeans.col.bg <<- unlist(local.SampleGroupMeans.col.bg.var[-1])
                bpar$gSampleGroupMeans.label.font <<- as.numeric(lapply(local.SampleGroupMeans.label.font.var[-1],
                  tclvalue))
                bpar$gSampleGroupMeans.label.cex <<- as.numeric(lapply(local.SampleGroupMeans.label.cex.var[-1],
                  tclvalue))
                bpar$gSampleGroupMeans.label.col <<- unlist(local.SampleGroupMeans.label.col.var[-1])
                bpar$gSampleGroupMeans.label.HorizOffset <<- as.numeric(lapply(local.SampleGroupMeans.label.HorizOffset.var[-1],
                  tclvalue))
                bpar$gSampleGroupMeans.label.VertOffset <<- as.numeric(lapply(local.SampleGroupMeans.label.VertOffset.var[-1],
                  tclvalue))
                bpar$gConvexHullAlphaBag.lty <<- as.numeric(lapply(local.ConvexHullAlphaBag.lty.var[-1],
                  tclvalue))
                bpar$gConvexHullAlphaBag.lwd <<- as.numeric(lapply(local.ConvexHullAlphaBag.lwd.var[-1],
                  tclvalue))
                bpar$gConvexHullAlphaBag.col.fg <<- unlist(local.ConvexHullAlphaBag.col.fg.var[-1])
                bpar$gConvexHullAlphaBag.col.bg <<- unlist(local.ConvexHullAlphaBag.col.bg.var[-1])
                bpar$gConvexHullAlphaBag.TukeyMedian.pch <<- as.numeric(lapply(local.ConvexHullAlphaBag.TukeyMedian.pch.var[-1],
                  tclvalue))
                bpar$gConvexHullAlphaBag.TukeyMedian.cex <<- as.numeric(lapply(local.ConvexHullAlphaBag.TukeyMedian.cex.var[-1],
                  tclvalue))
                bpar$gConvexHullAlphaBag.TukeyMedian.col.fg <<- unlist(local.ConvexHullAlphaBag.TukeyMedian.col.fg.var[-1])
                bpar$gConvexHullAlphaBag.TukeyMedian.col.bg <<- unlist(local.ConvexHullAlphaBag.TukeyMedian.col.bg.var[-1])
                bpar$gConvexHullAlphaBag.TukeyMedian.label.font <<- as.numeric(lapply(local.ConvexHullAlphaBag.TukeyMedian.label.font.var[-1],
                  tclvalue))
                bpar$gConvexHullAlphaBag.TukeyMedian.label.cex <<- as.numeric(lapply(local.ConvexHullAlphaBag.TukeyMedian.label.cex.var[-1],
                  tclvalue))
                bpar$gConvexHullAlphaBag.TukeyMedian.label.col <<- unlist(local.ConvexHullAlphaBag.TukeyMedian.label.col.var[-1])
                bpar$gConvexHullAlphaBag.TukeyMedian.label.HorizOffset <<- as.numeric(lapply(local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var[-1],
                  tclvalue))
                bpar$gConvexHullAlphaBag.TukeyMedian.label.VertOffset <<- as.numeric(lapply(local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var[-1],
                  tclvalue))
                bpar$gClassificationRegion.col.bg <<- unlist(local.ClassificationRegion.col.bg.var[-1])
                bparp.func()
                if (WhichTabInitially == 1)
                  Biplot.replot()
                if (tclvalue(Biplot.Axes.var) %in% c("0", "2"))
                  PointsTab.predictivities.replot()
                if (tclvalue(Biplot.Axes.var) == "2")
                  GroupsTab.replot()
                if (n.in < n)
                  Kraal.replot()
                tkdestroy(top)
            }

                onCancel <- function() tkdestroy(top)
            local.points.pch.var <- NULL
            local.points.cex.var <- NULL
            local.points.col.fg.var <- NULL
            local.points.col.bg.var <- NULL
            local.points.label.font.var <- NULL
            local.points.label.cex.var <- NULL
            local.points.label.col.var <- NULL
            local.points.label.HorizOffset.var <- NULL
            local.points.label.VertOffset.var <- NULL
            local.SampleGroupMeans.pch.var <- NULL
            local.SampleGroupMeans.cex.var <- NULL
            local.SampleGroupMeans.col.fg.var <- NULL
            local.SampleGroupMeans.col.bg.var <- NULL
            local.SampleGroupMeans.label.font.var <- NULL
            local.SampleGroupMeans.label.cex.var <- NULL
            local.SampleGroupMeans.label.col.var <- NULL
            local.SampleGroupMeans.label.HorizOffset.var <- NULL
            local.SampleGroupMeans.label.VertOffset.var <- NULL
            local.ConvexHullAlphaBag.lty.var <- NULL
            local.ConvexHullAlphaBag.lwd.var <- NULL
            local.ConvexHullAlphaBag.col.fg.var <- NULL
            local.ConvexHullAlphaBag.col.bg.var <- NULL
            local.ConvexHullAlphaBag.TukeyMedian.pch.var <- NULL
            local.ConvexHullAlphaBag.TukeyMedian.cex.var <- NULL
            local.ConvexHullAlphaBag.TukeyMedian.col.fg.var <- NULL
            local.ConvexHullAlphaBag.TukeyMedian.col.bg.var <- NULL
            local.ConvexHullAlphaBag.TukeyMedian.label.font.var <- NULL
            local.ConvexHullAlphaBag.TukeyMedian.label.cex.var <- NULL
            local.ConvexHullAlphaBag.TukeyMedian.label.col.var <- NULL
            local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var <- NULL
            local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var <- NULL
            local.ClassificationRegion.col.bg.var <- NULL

            initialise <- function() {
                local.points.pch.var <<- lapply(c(if (identical(bpar$gpoints.pch,
                  rep(bpar$gpoints.pch[1], g))) bpar$gpoints.pch[1] else " ",
                  as.character(bpar$gpoints.pch)), tclVar)
                local.points.cex.var <<- lapply(c(if (identical(bpar$gpoints.cex,
                  rep(bpar$gpoints.cex[1], g))) bpar$gpoints.cex[1] else " ",
                  as.character(bpar$gpoints.cex)), tclVar)
                local.points.col.fg.var <<- lapply(c(if (identical(bpar$gpoints.col.fg,
                  rep(bpar$gpoints.col.fg[1], g))) bpar$gpoints.col.fg[1] else "SystemButtonFace",
                  as.character(bpar$gpoints.col.fg)), text2hex)
                local.points.col.bg.var <<- lapply(c(if (identical(bpar$gpoints.col.bg,
                  rep(bpar$gpoints.col.bg[1], g))) bpar$gpoints.col.bg[1] else "SystemButtonFace",
                  as.character(bpar$gpoints.col.bg)), text2hex)
                local.points.label.font.var <<- lapply(c(if (identical(bpar$gpoints.label.font,
                  rep(bpar$gpoints.label.font[1], g))) bpar$gpoints.label.font[1] else " ",
                  as.character(bpar$gpoints.label.font)), tclVar)
                local.points.label.cex.var <<- lapply(c(if (identical(bpar$gpoints.label.cex,
                  rep(bpar$gpoints.label.cex[1], g))) bpar$gpoints.label.cex[1] else " ",
                  as.character(bpar$gpoints.label.cex)), tclVar)
                local.points.label.col.var <<- lapply(c(if (identical(bpar$gpoints.label.col,
                  rep(bpar$gpoints.label.col[1], g))) bpar$gpoints.label.col[1] else "SystemButtonFace",
                  as.character(bpar$gpoints.label.col)), text2hex)
                local.points.label.HorizOffset.var <<- lapply(c(if (identical(bpar$gpoints.label.HorizOffset,
                  rep(bpar$gpoints.label.HorizOffset[1], g))) bpar$gpoints.label.HorizOffset[1] else " ",
                  as.character(bpar$gpoints.label.HorizOffset)),
                  tclVar)
                local.points.label.VertOffset.var <<- lapply(c(if (identical(bpar$gpoints.label.VertOffset,
                  rep(bpar$gpoints.label.VertOffset[1], g))) bpar$gpoints.label.VertOffset[1] else " ",
                  as.character(bpar$gpoints.label.VertOffset)),
                  tclVar)
                local.SampleGroupMeans.pch.var <<- lapply(c(if (identical(bpar$gSampleGroupMeans.pch,
                  rep(bpar$gSampleGroupMeans.pch[1], g))) bpar$gSampleGroupMeans.pch[1] else " ",
                  as.character(bpar$gSampleGroupMeans.pch)),
                  tclVar)
                local.SampleGroupMeans.cex.var <<- lapply(c(if (identical(bpar$gSampleGroupMeans.cex,
                  rep(bpar$gSampleGroupMeans.cex[1], g))) bpar$gSampleGroupMeans.cex[1] else " ",
                  as.character(bpar$gSampleGroupMeans.cex)),
                  tclVar)
                local.SampleGroupMeans.col.fg.var <<- lapply(c(if (identical(bpar$gSampleGroupMeans.col.fg,
                  rep(bpar$gSampleGroupMeans.col.fg[1], g))) bpar$gSampleGroupMeans.col.fg[1] else "SystemButtonFace",
                  as.character(bpar$gSampleGroupMeans.col.fg)),
                  text2hex)
                local.SampleGroupMeans.col.bg.var <<- lapply(c(if (identical(bpar$gSampleGroupMeans.col.bg,
                  rep(bpar$gSampleGroupMeans.col.bg[1], g))) bpar$gSampleGroupMeans.col.bg[1] else "SystemButtonFace",
                  as.character(bpar$gSampleGroupMeans.col.bg)),
                  text2hex)
                local.SampleGroupMeans.label.font.var <<- lapply(c(if (identical(bpar$gSampleGroupMeans.label.font,
                  rep(bpar$gSampleGroupMeans.label.font[1], g))) bpar$gSampleGroupMeans.label.font[1] else " ",
                  as.character(bpar$gSampleGroupMeans.label.font)),
                  tclVar)
                local.SampleGroupMeans.label.cex.var <<- lapply(c(if (identical(bpar$gSampleGroupMeans.label.cex,
                  rep(bpar$gSampleGroupMeans.label.cex[1], g))) bpar$gSampleGroupMeans.label.cex[1] else " ",
                  as.character(bpar$gSampleGroupMeans.label.cex)),
                  tclVar)
                local.SampleGroupMeans.label.col.var <<- lapply(c(if (identical(bpar$gSampleGroupMeans.label.col,
                  rep(bpar$gSampleGroupMeans.label.col[1], g))) bpar$gSampleGroupMeans.label.col[1] else "SystemButtonFace",
                  as.character(bpar$gSampleGroupMeans.label.col)),
                  text2hex)
                local.SampleGroupMeans.label.HorizOffset.var <<- lapply(c(if (identical(bpar$gSampleGroupMeans.label.HorizOffset,
                  rep(bpar$gSampleGroupMeans.label.HorizOffset[1],
                    g))) bpar$gSampleGroupMeans.label.HorizOffset[1] else " ",
                  as.character(bpar$gSampleGroupMeans.label.HorizOffset)),
                  tclVar)
                local.SampleGroupMeans.label.VertOffset.var <<- lapply(c(if (identical(bpar$gSampleGroupMeans.label.VertOffset,
                  rep(bpar$gSampleGroupMeans.label.VertOffset[1],
                    g))) bpar$gSampleGroupMeans.label.VertOffset[1] else " ",
                  as.character(bpar$gSampleGroupMeans.label.VertOffset)),
                  tclVar)
                local.ConvexHullAlphaBag.lty.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.lty,
                  rep(bpar$gConvexHullAlphaBag.lty[1], g))) bpar$gConvexHullAlphaBag.lty[1] else " ",
                  as.character(bpar$gConvexHullAlphaBag.lty)),
                  tclVar)
                local.ConvexHullAlphaBag.lwd.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.lwd,
                  rep(bpar$gConvexHullAlphaBag.lwd[1], g))) bpar$gConvexHullAlphaBag.lwd[1] else " ",
                  as.character(bpar$gConvexHullAlphaBag.lwd)),
                  tclVar)
                local.ConvexHullAlphaBag.col.fg.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.col.fg,
                  rep(bpar$gConvexHullAlphaBag.col.fg[1], g))) bpar$gConvexHullAlphaBag.col.fg[1] else "SystemButtonFace",
                  as.character(bpar$gConvexHullAlphaBag.col.fg)),
                  text2hex)
                local.ConvexHullAlphaBag.col.bg.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.col.bg,
                  rep(bpar$gConvexHullAlphaBag.col.bg[1], g))) bpar$gConvexHullAlphaBag.col.bg[1] else "SystemButtonFace",
                  as.character(bpar$gConvexHullAlphaBag.col.bg)),
                  text2hex)
                local.ConvexHullAlphaBag.TukeyMedian.pch.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.TukeyMedian.pch,
                  rep(bpar$gConvexHullAlphaBag.TukeyMedian.pch[1],
                    g))) bpar$gConvexHullAlphaBag.TukeyMedian.pch[1] else " ",
                  as.character(bpar$gConvexHullAlphaBag.TukeyMedian.pch)),
                  tclVar)
                local.ConvexHullAlphaBag.TukeyMedian.cex.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.TukeyMedian.cex,
                  rep(bpar$gConvexHullAlphaBag.TukeyMedian.cex[1],
                    g))) bpar$gConvexHullAlphaBag.TukeyMedian.cex[1] else " ",
                  as.character(bpar$gConvexHullAlphaBag.TukeyMedian.cex)),
                  tclVar)
                local.ConvexHullAlphaBag.TukeyMedian.col.fg.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.TukeyMedian.col.fg,
                  rep(bpar$gConvexHullAlphaBag.TukeyMedian.col.fg[1],
                    g))) bpar$gConvexHullAlphaBag.TukeyMedian.col.fg[1] else "SystemButtonFace",
                  as.character(bpar$gConvexHullAlphaBag.TukeyMedian.col.fg)),
                  text2hex)
                local.ConvexHullAlphaBag.TukeyMedian.col.bg.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.TukeyMedian.col.bg,
                  rep(bpar$gConvexHullAlphaBag.TukeyMedian.col.bg[1],
                    g))) bpar$gConvexHullAlphaBag.TukeyMedian.col.bg[1] else "SystemButtonFace",
                  as.character(bpar$gConvexHullAlphaBag.TukeyMedian.col.bg)),
                  text2hex)
                local.ConvexHullAlphaBag.TukeyMedian.label.font.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.TukeyMedian.label.font,
                  rep(bpar$gConvexHullAlphaBag.TukeyMedian.label.font[1],
                    g))) bpar$gConvexHullAlphaBag.TukeyMedian.label.font[1] else " ",
                  as.character(bpar$gConvexHullAlphaBag.TukeyMedian.label.font)),
                  tclVar)
                local.ConvexHullAlphaBag.TukeyMedian.label.cex.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.TukeyMedian.label.cex,
                  rep(bpar$gConvexHullAlphaBag.TukeyMedian.label.cex[1],
                    g))) bpar$gConvexHullAlphaBag.TukeyMedian.label.cex[1] else " ",
                  as.character(bpar$gConvexHullAlphaBag.TukeyMedian.label.cex)),
                  tclVar)
                local.ConvexHullAlphaBag.TukeyMedian.label.col.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.TukeyMedian.label.col,
                  rep(bpar$gConvexHullAlphaBag.TukeyMedian.label.col[1],
                    g))) bpar$gConvexHullAlphaBag.TukeyMedian.label.col[1] else "SystemButtonFace",
                  as.character(bpar$gConvexHullAlphaBag.TukeyMedian.label.col)),
                  text2hex)
                local.ConvexHullAlphaBag.TukeyMedian.label.HorizOffset.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.TukeyMedian.label.HorizOffset,
                  rep(bpar$gConvexHullAlphaBag.TukeyMedian.label.HorizOffset[1],
                    g))) bpar$gConvexHullAlphaBag.TukeyMedian.label.HorizOffset[1] else " ",
                  as.character(bpar$gConvexHullAlphaBag.TukeyMedian.label.HorizOffset)),
                  tclVar)
                local.ConvexHullAlphaBag.TukeyMedian.label.VertOffset.var <<- lapply(c(if (identical(bpar$gConvexHullAlphaBag.TukeyMedian.label.VertOffset,
                  rep(bpar$gConvexHullAlphaBag.TukeyMedian.label.VertOffset[1],
                    g))) bpar$gConvexHullAlphaBag.TukeyMedian.label.VertOffset[1] else " ",
                  as.character(bpar$gConvexHullAlphaBag.TukeyMedian.label.VertOffset)),
                  tclVar)
                local.ClassificationRegion.col.bg.var <<- lapply(c(if (identical(bpar$gClassificationRegion.col.bg,
                  rep(bpar$gClassificationRegion.col.bg[1], g))) bpar$gClassificationRegion.col.bg[1] else "SystemButtonFace",
                  as.character(bpar$gClassificationRegion.col.bg)),
                  text2hex)
            }

    MenuBar.menu <- tk2menu(GUI.TopLevel)
    tkconfigure(GUI.TopLevel, menu = MenuBar.menu)
    MenuBar.File <- tk2menu(MenuBar.menu, tearoff = FALSE)
    MenuBar.File.SaveAs <- tk2menu(MenuBar.menu, tearoff = FALSE)
    tkadd(MenuBar.File.SaveAs, "radiobutton", label = "PDF...",
        underline = "0", variable = File.SaveAs.var, value = "0",
        command = function() {
            GUI.BindingsOff()
            File.SaveAs.PDF.cmd()
            GUI.BindingsOn()
        })
