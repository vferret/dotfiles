/* {{{ Information
let INFO = xml`
<plugin name="buftabs" version="1.0"
    href=""
    summary="Buftabs: show the tabbar in the statusline"
    xmlns="http://vimperator.org/namespaces/liberator">
<author email="s2marine0@gmail.com">s2marine</author>
<license href="">GPLv3</license>
<p>
  This is a fork from Lucas de Vries's buftabs (https://github.com/GGLucas/vimperator-buftabs).
  I fixed it.
</p>
<item>
<tags>'buftabs'</tags>
<spec>'buftabs'</spec>
<type>boolean</type>
<default>true</default>
<description>
Toggle the buftabs on or off. 
</description>
</item>
<item>
<tags>'buftabs_maxlength'</tags>
<spec>'buftabs_maxlength'</spec>
<type>number</type>
<default>25</default>
<description>
The maximum length in characters of a single entry in the buftabs line.
Set to 0 for unlimited.
</description>
</item>
</plugin>
`;
}}} */

(function () {

  Buftabs = {
    createBar: function() {
      var statusline = document.getElementById("liberator-statusline");
      var buftabsBar = document.getElementById("liberator-statusline-buftabs");
      var insertIndex = document.getElementById("liberator-status");
      if (!buftabsBar) {
        var buftabsBar = document.createElement("toolbaritem");
        buftabsBar.setAttribute("id", "liberator-statusline-buftabs");
        statusline.insertBefore(buftabsBar, insertIndex);
      }
    },
    clearBar: function() {
      var buftabsBar = document.getElementById("liberator-statusline-buftabs");
      while (buftabsBar.hasChildNodes()) {
        buftabsBar.removeChild(buftabsBar.lastChild);
      }
    },
    fillBar: function() {
      var buftabsBar = document.getElementById("liberator-statusline-buftabs");
      var browsers = window.getBrowser().browsers;
      for(let i=0;i<browsers.length;i++) {
        var buftab = document.createElement("label");
        var title = (i+1)+"."+browsers[i].contentTitle.substr(0, 12);
        buftab.setAttribute("value", title);
        (function(i) {
          buftab.onmousedown = function(e) {
            if(e.button==0) {
              gBrowser.selectTabAtIndex(i);
            }
            else if(e.button==1) {
              gBrowser.removeTab(gBrowser.tabs[i])
            }
          };
        })(i);
        if(i==gBrowser.tabContainer.selectedIndex) {
          buftab.setAttribute("style", "background:#585858;border-radius:2px;padding:2pt5pt;font-weight: bold;font-size:12pt;");
        }
        else {
          buftab.setAttribute("style", "background: transparent;font-size:12pt;");
        }
        buftabsBar.appendChild(buftab);
      }
    },
    updateUrl: function() {
      this.clearBar();
      this.fillBar();
    },
  };


  Buftabs.createBar();

  var tabContainer = window.getBrowser().mTabContainer;



  /*
  window.getBrowser().addEventListener("load", function (event) {
    Buftabs.updateUrl();
  }, false);
  */

  tabContainer.addEventListener("TabOpen", function (event) {
    Buftabs.updateUrl();
  }, false);
  tabContainer.addEventListener("TabSelect", function (event) {
    Buftabs.updateUrl();
  }, false);
  tabContainer.addEventListener("TabMove", function (event) {
    Buftabs.updateUrl();
  }, false);
  tabContainer.addEventListener("TabClose", function (event) {
    setTimeout("Buftabs.updateUrl()", 200);
  }, false);
  window.getBrowser().addEventListener("DOMTitleChanged", function (event) {
    Buftabs.updateUrl();
  }, false);

})();

// vim:sw=2 ts=2 et si fdm=marker:
