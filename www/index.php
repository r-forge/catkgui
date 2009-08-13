<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" >
<title>BiplotGUI: Interactive Biplots in R</title>
<link href="http://r-forge.r-project.org/themes/rforge/styles/estilo1.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="#ffffff"><font size="1">
<p><! --- R-Forge Logo --- >
<table cellspacing="0" cellpadding="0" width="100%" border="0">
  <tbody>
  <tr>
    <td><a href="http://r-forge.r-project.org"><img alt="R-Forge Logo" 
      src="http://r-forge.r-project.org/themes/rforge//images/logo.png" 
      border=0> </a></td></tr></tbody></table><!-- get project title  --><!-- own website starts here, the following may be changed as you like --></p>

<h2>The BiplotGUI package homepage </h2>
<p><font size="2">The BiplotGUI package for R makes it easy to construct and 
interact with biplots.</font> </p>
<p>
<table cellspacing="0" cellpadding="0" width="750" align="left" border="0">
  <tbody>
  <tr>
    <td>
      <h4>Biplots </h4>
      <p><font size="2">Biplots can be interpreted as graphs in which observations 
      are represented as points while, simultaneously, variables are represented 
      as calibrated biplot axes. Such representations make it easy to visualise 
      multivariate data in two or three dimensions.&nbsp;The biplots of the 
      BiplotGUI package are based on the book by&nbsp;Gower and Hand (1996) and 
      can be thought of as multivariate analogues of the ordinary scatter 
      plot.</font> </p>

      <hr>

      <h4>Features</h4>
      <ul>
        <li>
        <div><font size="2">A&nbsp;graphical user interface (GUI), making the 
        package easy to use. </font></div>
        <li>
        <div><font size="2">Support for different types of biplots (PCA, 
        covariance/correlation, CVA, regression, Procrustes, circular 
        non-linear), both predictive and interpolative. </font></div>

        <li>
        <div><font size="2">Support for different scaling techniques (PCO, metric 
        MDS, non-metric MDS, semi-metric MDS). </font></div>
        <li>
        <div><font size="2">Various data transformations&nbsp;and distance metrics. 
        </font></div>
        <li>
        <div><font size="2">Additional descriptors (convex hulls, alpha-bags, 
        point densities, classification regions). </font></div>
        <li>

        <div><font size="2">Intermediate quantities for export back to R. 
        </font></div>
        <li>
        <div><font size="2">Diagnostics (graphs of convergence; point, group and 
        axis predictivities; Shepard diagrams). </font></div>
        <li>
        <div><font size="2">Interactivity (variable value prediction, zooming, 
        point and axis drag-and-drop, 3D biplots). </font></div>
        <li>
        <div><font size="2"> Customisable graphics. </font></div>

        <li>
        <div><font size="2">The package 
        is free and open-source.</font> </div></li></ul>
      <h4>Requirements 
      </h4>
      <ul>
        <li>
      <div><font size="2">R needs to be installed. <a 
        href="http://cran.r-project.org/bin/windows/base/">R 2.8.1</a> can 
        &nbsp;<font size="2">be downloaded from <a 
        href="http://cran.r-project.org">CRAN</a>    
        . </font></font> 
      </div>

        <li>
      <div><font size="2">At present, BiplotGUI runs only 
        in Windows.</font> 
      </div></li></ul>
      <h4>Installation 
      </h4>
      <ul>
        <li>
      <div><font size="2">To install the BiplotGUI package 
        and all its dependencies from within R, the following command can be 
        entered at the&nbsp;prompt of the R console: <font 
        face=Courier>install.packages("BiplotGUI")</font><font 
        face=Arial>.</font></font> 
      </div>

        <li>
      <div><font size="2">Alternatively, BiplotGUI <a 
        href="http://cran.r-project.org/web/packages/BiplotGUI/index.html">version 
        0.0-4.1</a> can be downloaded from CRAN, and 
        installed manually. The package dependencies (<a 
        href="http://cran.r-project.org/web/packages/colorspace/index.html">colorspace</a>          
          ,<span lang="EN"><a 
        href="http://cran.r-project.org/web/packages/deldir/index.html">deldir</a>, 
        <a 
        href="http://cran.r-project.org/web/packages/KernSmooth/index.html">KernSmooth</a>, 
        MASS, <a 
        href="http://cran.r-project.org/web/packages/rgl/index.html">rgl</a>, 
        tcltk, <a 
        href="http://cran.r-project.org/web/packages/tcltk2/index.html">tcltk2</a>, 
        <a 
        href="http://cran.r-project.org/web/packages/tkrplot/index.html">tkrplot</a></span>) 
        also need to be installed.</font> 
      </div></li></ul>

      <h4><a href="BiplotGUIManual.pdf">Manual</a> </h4>
      <h4><a href="Screenshots/index.html">Screenshots</a> </h4>
      <h4><a href="Examples/index.html">Examples</a> </h4>
      <hr>
       <font size="2">
      <p>

      <p></p></font>
      <p><font size="2">Click </font><a 
      href="http://r-forge.r-project.org/projects/biplotgui/"><font 
      size=2>here</font></a><font size="2"> for help, to report bugs, or to 
      download the developement version of the package.</font></p>
      <p>
      <hr>

      <p></p>

      <h4>Author </h4>

      <p><font size="2">Anthony la Grange</font> </p>
      <h4>References </h4>
      <p><font size="2">Gower JC&nbsp;and Hand DJ&nbsp;(1996). <em>Biplots</em>. 
      Monographs on Statistics and Applied Probability. London, UK: Chapman 
      &amp; Hall.</font> </p>

      <h4>License </h4>
      <p><font size="2">Permission is granted to copy, distributed and/or modify 
      the code of the BiplotGUI package under the terms of the </font><a 
      href="http://www.r-project.org/Licenses/GPL-3"><font size="2">GNU Public 
      License, Version 3 </font></a><font size="2">or any later version published 
      by the </font><a href="http://www.fsf.org/"><font size="2">Free Software 
      Foundation </font></a><font size="2">.</font> </p>
      <h4><font size="1">Last updated:&nbsp;14 March 2009</font> 
  </h4></td></tr></tbody></table></p>
<p>&nbsp;</p>

<p>&nbsp;</p></font>
</body>
</html>